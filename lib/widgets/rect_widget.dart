import 'package:flutter/material.dart';
import '../models/rect_node.dart';
import '../models/settings.dart';

class RectWidget extends StatelessWidget {
  final RectNode node;
  final Settings settings;
  final VoidCallback onChanged;

  const RectWidget({
    super.key,
    required this.node,
    required this.settings,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Split node: Row or Column with two equal children
    if (!node.isLeaf) {
      final children = [
        Expanded(
          child: RectWidget(
            node: node.first!,
            settings: settings,
            onChanged: onChanged,
          ),
        ),
        Expanded(
          child: RectWidget(
            node: node.second!,
            settings: settings,
            onChanged: onChanged,
          ),
        ),
      ];
      return node.direction == Axis.horizontal
          ? Row(children: children)
          : Column(children: children);
    }

    // Leaf: colored rectangle you can tap
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () {
            // minimum size so it doesn't split forever
            if (constraints.maxWidth < 40 || constraints.maxHeight < 40) return;

            // wider than tall -> split left/right, else top/bottom
            node.direction = constraints.maxWidth >= constraints.maxHeight
                ? Axis.horizontal
                : Axis.vertical;
            node.first = RectNode();
            node.second = RectNode();
            onChanged();
          },
          child: Container(
            margin: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: settings.gradient ? null : node.color1,
              gradient: settings.gradient
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [node.color1, node.color2],
                    )
                  : null,
              borderRadius: BorderRadius.circular(settings.cornerRadius),
              border: settings.borderWidth > 0
                  ? Border.all(
                      color: settings.borderColor,
                      width: settings.borderWidth,
                    )
                  : null,
            ),
          ),
        );
      },
    );
  }
}