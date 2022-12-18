part of '../text_style_preview.dart';

class TextStylePreviewStyle extends ThemeExtension<TextStylePreviewStyle> {
  final Color? backgroundColor;
  final Color? barrierColor;
  final double? modalHeight;
  final LaunchType? launchType;
  final bool? showDivider;
  final DescriptionBuilder? descriptionBuilder;
  const TextStylePreviewStyle({
    this.backgroundColor,
    this.barrierColor,
    this.modalHeight,
    this.launchType,
    this.showDivider,
    this.descriptionBuilder,
  });

  @override
  ThemeExtension<TextStylePreviewStyle> copyWith() {
    return TextStylePreviewStyle(
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      modalHeight: modalHeight,
      launchType: launchType,
      showDivider: showDivider,
      descriptionBuilder: descriptionBuilder,
    );
  }

  @override
  ThemeExtension<TextStylePreviewStyle> lerp(
      ThemeExtension<TextStylePreviewStyle>? other, double t) {
    return this;
  }
}
