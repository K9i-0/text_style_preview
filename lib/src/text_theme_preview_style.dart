part of '../text_style_preview.dart';

class TextThemePreviewStyle extends ThemeExtension<TextThemePreviewStyle> {
  final Color? backgroundColor;
  final Color? barrierColor;
  final double? modalHeight;
  final LaunchType? launchType;
  final bool? showDivider;
  final DescriptionBuilder? descriptionBuilder;
  const TextThemePreviewStyle({
    this.backgroundColor,
    this.barrierColor,
    this.modalHeight,
    this.launchType,
    this.showDivider,
    this.descriptionBuilder,
  });

  @override
  ThemeExtension<TextThemePreviewStyle> copyWith() {
    return TextThemePreviewStyle(
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      modalHeight: modalHeight,
      launchType: launchType,
      showDivider: showDivider,
      descriptionBuilder: descriptionBuilder,
    );
  }

  @override
  ThemeExtension<TextThemePreviewStyle> lerp(
      ThemeExtension<TextThemePreviewStyle>? other, double t) {
    return this;
  }
}
