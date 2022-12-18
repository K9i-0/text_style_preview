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
          TextThemePreviewStyle(
            modalHeight: 200,
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
              const TextStylePreview(
                child: Text('Sample Text'),
              ),
              const SizedBox(height: 20),
              TextStylePreview(
                initTextThemeType: TextThemeType.headlineSmall,
                // set stye like this
                style: TextThemePreviewStyle(
                  modalHeight: 300,
                  barrierColor: Colors.transparent,
                  showDivider: true,
                  descriptionBuilder: (textThemeType, textStyle) =>
                      textThemeType.name,
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
