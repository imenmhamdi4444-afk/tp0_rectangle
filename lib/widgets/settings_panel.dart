import 'package:flutter/material.dart';
import '../models/settings.dart';

void showSettingsPanel(
  BuildContext context,
  Settings settings,
  VoidCallback onChanged,
) {
  const borderColors = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
  ];

  showModalBottomSheet(
    context: context,
    builder: (_) => StatefulBuilder(
      builder: (context, setSheet) {
        void update(VoidCallback change) {
          change();
          setSheet(() {}); // redraw the panel
          onChanged(); // redraw the rectangles
        }

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Border width: ${settings.borderWidth.toStringAsFixed(1)}'),
              Slider(
                value: settings.borderWidth,
                min: 0,
                max: 20,
                onChanged: (v) => update(() => settings.borderWidth = v),
              ),
              Text('Corner radius: ${settings.cornerRadius.toStringAsFixed(1)}'),
              Slider(
                value: settings.cornerRadius,
                min: 0,
                max: 60,
                onChanged: (v) => update(() => settings.cornerRadius = v),
              ),
              SwitchListTile(
                title: const Text('Gradient mode'),
                value: settings.gradient,
                onChanged: (v) => update(() => settings.gradient = v),
              ),
              const Text('Border color'),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: borderColors
                    .map(
                      (c) => GestureDetector(
                        onTap: () => update(() => settings.borderColor = c),
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: settings.borderColor == c
                                  ? Colors.grey
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        );
      },
    ),
  );
}