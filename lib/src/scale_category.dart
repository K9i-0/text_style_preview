part of '../text_style_preview.dart';

enum ScaleCategory {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  labelLarge,
  labelMedium,
  labelSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
}

extension _ScaleCategoryEx on ScaleCategory {
  TextStyle textStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    switch (this) {
      case ScaleCategory.displayLarge:
        return textTheme.displayLarge!;
      case ScaleCategory.displayMedium:
        return textTheme.displayMedium!;
      case ScaleCategory.displaySmall:
        return textTheme.displaySmall!;
      case ScaleCategory.headlineLarge:
        return textTheme.headlineLarge!;
      case ScaleCategory.headlineMedium:
        return textTheme.headlineMedium!;
      case ScaleCategory.headlineSmall:
        return textTheme.headlineSmall!;
      case ScaleCategory.titleLarge:
        return textTheme.titleLarge!;
      case ScaleCategory.titleMedium:
        return textTheme.titleMedium!;
      case ScaleCategory.titleSmall:
        return textTheme.titleSmall!;
      case ScaleCategory.labelLarge:
        return textTheme.labelLarge!;
      case ScaleCategory.labelMedium:
        return textTheme.labelMedium!;
      case ScaleCategory.labelSmall:
        return textTheme.labelSmall!;
      case ScaleCategory.bodyLarge:
        return textTheme.bodyLarge!;
      case ScaleCategory.bodyMedium:
        return textTheme.bodyMedium!;
      case ScaleCategory.bodySmall:
        return textTheme.bodySmall!;
    }
  }
}
