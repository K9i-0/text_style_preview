part of '../text_style_preview.dart';

enum TextThemeType {
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

extension _TextThemeTypeEx on TextThemeType {
  TextStyle textStyle(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    switch (this) {
      case TextThemeType.displayLarge:
        return textTheme.displayLarge!;
      case TextThemeType.displayMedium:
        return textTheme.displayMedium!;
      case TextThemeType.displaySmall:
        return textTheme.displaySmall!;
      case TextThemeType.headlineLarge:
        return textTheme.headlineLarge!;
      case TextThemeType.headlineMedium:
        return textTheme.headlineMedium!;
      case TextThemeType.headlineSmall:
        return textTheme.headlineSmall!;
      case TextThemeType.titleLarge:
        return textTheme.titleLarge!;
      case TextThemeType.titleMedium:
        return textTheme.titleMedium!;
      case TextThemeType.titleSmall:
        return textTheme.titleSmall!;
      case TextThemeType.labelLarge:
        return textTheme.labelLarge!;
      case TextThemeType.labelMedium:
        return textTheme.labelMedium!;
      case TextThemeType.labelSmall:
        return textTheme.labelSmall!;
      case TextThemeType.bodyLarge:
        return textTheme.bodyLarge!;
      case TextThemeType.bodyMedium:
        return textTheme.bodyMedium!;
      case TextThemeType.bodySmall:
        return textTheme.bodySmall!;
    }
  }
}
