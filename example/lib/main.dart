import 'package:flutter/material.dart';
import 'package:text_style_preview/text_style_preview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.red,
        // set default stye like this
        extensions: const [
          TextStylePreviewStyle(
            showDivider: false,
          ),
        ],
      ),
      home: const TextStylePreviewDemoScreen(),
    );
  }
}

class TextStylePreviewDemoScreen extends StatelessWidget {
  const TextStylePreviewDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Style Preview Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              // basic usage
              const TextStylePreview(
                child: Text('Sample Text'),
              ),
              const SizedBox(height: 20),
              // advanced usage
              TextStylePreview(
                initScaleCategory: ScaleCategory.headlineSmall,
                applyCustomStyle: (textStyle) => textStyle.apply(
                  color: Colors.blue,
                  fontSizeFactor: 1.5,
                ),
                // set stye like this
                style: TextStylePreviewStyle(
                  modalHeight: 300,
                  barrierColor: Colors.transparent,
                  showDivider: true,
                  descriptionBuilder: (scaleCategory, textStyle) =>
                      scaleCategory.name,
                ),
                child: const Text('Sample Text2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
