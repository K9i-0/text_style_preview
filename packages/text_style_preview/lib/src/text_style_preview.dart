import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:text_style_preview/src/launch_type.dart';
import 'package:text_style_preview/src/text_style_preview_style.dart';
import 'package:text_style_preview/src/type_scale_category.dart';

typedef TextStyleConverter = TextStyle Function(TextStyle textStyle);

extension _TypeScaleCategoryX on TypeScaleCategory {
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

  TextStyle customStyleAppliedTextStyle(
      BuildContext context, TextStyleConverter? converter) {
    final textStyle = this.textStyle(context);
    return converter != null ? converter(textStyle) : textStyle;
  }
}

///The widget to preview the [TextStyle] of the [Text].
///
/// The [TextStylePreview] is only enabled in debug mode.
///
/// The [TextStylePreview] can be launched by tapping or long pressing on the [Text].
///
/// The [TextStylePreview] can be customized by [TextStylePreviewStyle].
///
/// The [TextStylePreview] can apply a custom style to the [Text] by [TextStyleConverter].
class TextStylePreview extends StatefulWidget {
  /// The [Text] to preview the [TextStyle].
  final Text child;

  /// Whether the [TextStylePreview] is enabled.
  final bool enabled;

  /// The initial scale category of the [TextStyle].
  final TypeScaleCategory initTypeScaleCategory;

  /// The custom style to apply to the [TextStyle].
  final TextStyleConverter? applyCustomStyle;

  /// The style to customize the [TextStylePreview].
  final TextStylePreviewStyle? style;
  const TextStylePreview({
    super.key,
    required this.child,
    this.enabled = true,
    this.initTypeScaleCategory = TypeScaleCategory.bodyMedium,
    this.applyCustomStyle,
    this.style,
  });

  @override
  State<TextStylePreview> createState() => _TextStylePreviewState();
}

class _TextStylePreviewState extends State<TextStylePreview> {
  late TypeScaleCategory _selectedTypeScaleCategory;

  @override
  void initState() {
    _selectedTypeScaleCategory = widget.initTypeScaleCategory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode || !widget.enabled) {
      return widget.child;
    }

    final defaultTextStylePreviewStyle =
        Theme.of(context).extension<TextStylePreviewStyle>();
    final textStylePreviewStyle = widget.style;

    final backgroundColor = textStylePreviewStyle?.backgroundColor ??
        defaultTextStylePreviewStyle?.backgroundColor;
    final barrierColor = textStylePreviewStyle?.barrierColor ??
        defaultTextStylePreviewStyle?.barrierColor ??
        Colors.transparent;
    final modalHeight = textStylePreviewStyle?.modalHeight ??
        defaultTextStylePreviewStyle?.modalHeight;
    final launchType = textStylePreviewStyle?.launchType ??
        defaultTextStylePreviewStyle?.launchType ??
        LaunchType.onTap;
    final showDivider = textStylePreviewStyle?.showDivider ??
        defaultTextStylePreviewStyle?.showDivider ??
        true;
    final descriptionBuilder = textStylePreviewStyle?.descriptionBuilder ??
        defaultTextStylePreviewStyle?.descriptionBuilder;
    final reverse = textStylePreviewStyle?.reverse ??
        defaultTextStylePreviewStyle?.reverse ??
        false;
    final previewMaxLines = textStylePreviewStyle?.previewMaxLines ??
        defaultTextStylePreviewStyle?.previewMaxLines ??
        1;

    final typeScaleCategoryValues = reverse
        ? TypeScaleCategory.values.reversed.toList()
        : TypeScaleCategory.values;

    showPreviewSheet() => showModalBottomSheet(
          context: context,
          backgroundColor: backgroundColor,
          barrierColor: barrierColor,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setModalState) => SizedBox(
                height: modalHeight,
                child: Column(
                  children: [
                    if (showDivider) const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: typeScaleCategoryValues.length,
                        itemBuilder: (context, index) => _TextThemeItem(
                          typeScaleCategory: typeScaleCategoryValues[index],
                          selectedTypeScaleCategory: _selectedTypeScaleCategory,
                          onTap: () {
                            setState(() {
                              _selectedTypeScaleCategory =
                                  typeScaleCategoryValues[index];
                            });
                            setModalState(() {
                              _selectedTypeScaleCategory =
                                  typeScaleCategoryValues[index];
                            });
                          },
                          descriptionBuilder: descriptionBuilder,
                          applyCustomStyle: widget.applyCustomStyle,
                          previewMaxLines: previewMaxLines,
                          child: widget.child,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );

    return GestureDetector(
      onTap: () {
        if (launchType == LaunchType.onTap) {
          showPreviewSheet.call();
        }
      },
      onLongPress: () {
        if (launchType == LaunchType.onLongPress) {
          showPreviewSheet.call();
        }
      },
      child: DefaultTextStyle(
        style: _selectedTypeScaleCategory.customStyleAppliedTextStyle(
          context,
          widget.applyCustomStyle,
        ),
        child: widget.child,
      ),
    );
  }
}

class _TextThemeItem extends StatelessWidget {
  final TypeScaleCategory selectedTypeScaleCategory;
  final TypeScaleCategory typeScaleCategory;
  final VoidCallback onTap;
  final DescriptionBuilder? descriptionBuilder;
  final TextStyleConverter? applyCustomStyle;
  final int? previewMaxLines;
  final Text child;
  const _TextThemeItem({
    required this.selectedTypeScaleCategory,
    required this.typeScaleCategory,
    required this.onTap,
    required this.child,
    required this.descriptionBuilder,
    required this.applyCustomStyle,
    required this.previewMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.check,
        color: selectedTypeScaleCategory == typeScaleCategory
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
      ),
      title: DefaultTextStyle(
        style: typeScaleCategory.customStyleAppliedTextStyle(
          context,
          applyCustomStyle,
        ),
        maxLines: previewMaxLines,
        child: child,
      ),
      subtitle: Text(
        descriptionBuilder != null
            ? descriptionBuilder!(
                typeScaleCategory,
                typeScaleCategory.customStyleAppliedTextStyle(
                  context,
                  applyCustomStyle,
                ),
              )
            : typeScaleCategory.name,
      ),
      onTap: onTap,
    );
  }
}
