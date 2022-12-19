part of '../text_style_preview.dart';

/// The style of the [TextStylePreview].
class TextStylePreviewStyle extends ThemeExtension<TextStylePreviewStyle> {
  /// The background color of the modal.
  final Color? backgroundColor;

  /// The barrier color of the modal.
  final Color? barrierColor;

  /// The height of the modal.
  final double? modalHeight;

  /// The type of launch for the [TextStylePreview].
  final LaunchType? launchType;

  /// Whether to show a divider top of the modal.
  final bool? showDivider;

  /// The builder of the text style description.
  final DescriptionBuilder? descriptionBuilder;

  /// Whether to reverse the order of the scale categories.
  final bool? reverse;
  const TextStylePreviewStyle({
    this.backgroundColor,
    this.barrierColor,
    this.modalHeight,
    this.launchType,
    this.showDivider,
    this.descriptionBuilder,
    this.reverse,
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
      reverse: reverse,
    );
  }

  @override
  ThemeExtension<TextStylePreviewStyle> lerp(
      ThemeExtension<TextStylePreviewStyle>? other, double t) {
    return this;
  }
}
