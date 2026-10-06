import 'package:flutter/material.dart';
import '../models/rect_node.dart';
import '../models/settings.dart';
import '../widgets/rect_widget.dart';
import '../widgets/settings_panel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RectNode root = RectNode();
  final Settings settings = Settings();

  void refresh() => setState(() {});

  void reset() => setState(() => root = RectNode());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: RectWidget(
              node: root,
              settings: settings,
              onChanged: refresh,
            ),
          ),
          Positioned(
            top: 32,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                'Rectangles: ${root.totalRectangles}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'reset',
            onPressed: reset,
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: 'settings',
            onPressed: () => showSettingsPanel(context, settings, refresh),
            child: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
} 