part of '../text_style_preview.dart';

/// The type scale category of the Material Design.
///
/// https://m3.material.io/styles/typography/type-scale-tokens
enum TypeScaleCategory {
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

extension _TypeScaleCategoryEx on TypeScaleCategory {
  TextStyle textStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    switch (this) {
      case TypeScaleCategory.displayLarge:
        return textTheme.displayLarge!;
      case TypeScaleCategory.displayMedium:
        return textTheme.displayMedium!;
      case TypeScaleCategory.displaySmall:
        return textTheme.displaySmall!;
      case TypeScaleCategory.headlineLarge:
        return textTheme.headlineLarge!;
      case TypeScaleCategory.headlineMedium:
        return textTheme.headlineMedium!;
      case TypeScaleCategory.headlineSmall:
        return textTheme.headlineSmall!;
      case TypeScaleCategory.titleLarge:
        return textTheme.titleLarge!;
      case TypeScaleCategory.titleMedium:
        return textTheme.titleMedium!;
      case TypeScaleCategory.titleSmall:
        return textTheme.titleSmall!;
      case TypeScaleCategory.labelLarge:
        return textTheme.labelLarge!;
      case TypeScaleCategory.labelMedium:
        return textTheme.labelMedium!;
      case TypeScaleCategory.labelSmall:
        return textTheme.labelSmall!;
      case TypeScaleCategory.bodyLarge:
        return textTheme.bodyLarge!;
      case TypeScaleCategory.bodyMedium:
        return textTheme.bodyMedium!;
      case TypeScaleCategory.bodySmall:
        return textTheme.bodySmall!;
    }
  }
}
