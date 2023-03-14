import 'package:flutter/material.dart';
import 'package:text_style_preview/src/launch_type.dart';
import 'package:text_style_preview/src/type_scale_category.dart';

typedef DescriptionBuilder = String Function(
    TypeScaleCategory typeScaleCategory, TextStyle textStyle);

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
  /// Default is [(typeScaleCategory, textStyle) => typeScaleCategory.name].
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
  ThemeExtension<TextStylePreviewStyle> copyWith({
    Color? backgroundColor,
    Color? barrierColor,
    double? modalHeight,
    LaunchType? launchType,
    bool? showDivider,
    DescriptionBuilder? descriptionBuilder,
    bool? reverse,
    int? previewMaxLines,
  }) {
    return TextStylePreviewStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      barrierColor: barrierColor ?? this.barrierColor,
      modalHeight: modalHeight ?? this.modalHeight,
      launchType: launchType ?? this.launchType,
      showDivider: showDivider ?? this.showDivider,
      descriptionBuilder: descriptionBuilder ?? this.descriptionBuilder,
      reverse: reverse ?? this.reverse,
      previewMaxLines: previewMaxLines ?? this.previewMaxLines,
    );
  }

  @override
  ThemeExtension<TextStylePreviewStyle> lerp(
      ThemeExtension<TextStylePreviewStyle>? other, double t) {
    return this;
  }
}
