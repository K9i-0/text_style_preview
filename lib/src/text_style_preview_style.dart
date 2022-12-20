part of '../text_style_preview.dart';

/// The style of the [TextStylePreview].
class TextStylePreviewStyle extends ThemeExtension<TextStylePreviewStyle> {
  /// The background color of the modal.
  /// Default is null.
  final Color? backgroundColor;

  /// The barrier color of the modal.
  /// Default is [Colors.transparent].
  final Color? barrierColor;

  /// The height of the modal.
  /// Default is null.
  final double? modalHeight;

  /// The type of launch for the [TextStylePreview].
  /// Default is [LaunchType.onTap].
  final LaunchType? launchType;

  /// Whether to show a divider top of the modal.
  /// Default is true.
  final bool? showDivider;

  /// The builder of the text style description.
  /// Default is [(scaleCategory, textStyle) => scaleCategory.name].
  final DescriptionBuilder? descriptionBuilder;

  /// Whether to reverse the order of the scale categories.
  /// Default is false.
  final bool? reverse;

  /// The maximum number of lines for the preview.
  /// Default is 1.
  final int? previewMaxLines;
  const TextStylePreviewStyle({
    this.backgroundColor,
    this.barrierColor,
    this.modalHeight,
    this.launchType,
    this.showDivider,
    this.descriptionBuilder,
    this.reverse,
    this.previewMaxLines,
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
      previewMaxLines: previewMaxLines,
    );
  }

  @override
  ThemeExtension<TextStylePreviewStyle> lerp(
      ThemeExtension<TextStylePreviewStyle>? other, double t) {
    return this;
  }
}
