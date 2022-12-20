part of '../text_style_preview.dart';

typedef DescriptionBuilder = String Function(
    ScaleCategory scaleCategory, TextStyle textStyle);
typedef TextStyleConverter = TextStyle Function(TextStyle textStyle);

extension _ScaleCategoryEx2 on ScaleCategory {
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
  final ScaleCategory initScaleCategory;

  /// The custom style to apply to the [TextStyle].
  final TextStyleConverter? applyCustomStyle;

  /// The style to customize the [TextStylePreview].
  final TextStylePreviewStyle? style;
  const TextStylePreview({
    super.key,
    required this.child,
    this.enabled = true,
    this.initScaleCategory = ScaleCategory.bodyMedium,
    this.applyCustomStyle,
    this.style,
  });

  @override
  State<TextStylePreview> createState() => _TextStylePreviewState();
}

class _TextStylePreviewState extends State<TextStylePreview> {
  late ScaleCategory _selectedScaleCategory;

  @override
  void initState() {
    _selectedScaleCategory = widget.initScaleCategory;
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

    final scaleCategoryValues =
        reverse ? ScaleCategory.values.reversed.toList() : ScaleCategory.values;

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
                        itemCount: scaleCategoryValues.length,
                        itemBuilder: (context, index) => _TextThemeItem(
                          scaleCategory: scaleCategoryValues[index],
                          selectedScaleCategory: _selectedScaleCategory,
                          onTap: () {
                            setState(() {
                              _selectedScaleCategory =
                                  scaleCategoryValues[index];
                            });
                            setModalState(() {
                              _selectedScaleCategory =
                                  scaleCategoryValues[index];
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
        style: _selectedScaleCategory.customStyleAppliedTextStyle(
          context,
          widget.applyCustomStyle,
        ),
        child: widget.child,
      ),
    );
  }
}

class _TextThemeItem extends StatelessWidget {
  final ScaleCategory selectedScaleCategory;
  final ScaleCategory scaleCategory;
  final VoidCallback onTap;
  final DescriptionBuilder? descriptionBuilder;
  final TextStyleConverter? applyCustomStyle;
  final int? previewMaxLines;
  final Text child;
  const _TextThemeItem({
    required this.selectedScaleCategory,
    required this.scaleCategory,
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
        color: selectedScaleCategory == scaleCategory
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
      ),
      title: DefaultTextStyle(
        style: scaleCategory.customStyleAppliedTextStyle(
          context,
          applyCustomStyle,
        ),
        maxLines: previewMaxLines,
        child: child,
      ),
      subtitle: Text(
        descriptionBuilder != null
            ? descriptionBuilder!(
                scaleCategory,
                scaleCategory.customStyleAppliedTextStyle(
                  context,
                  applyCustomStyle,
                ),
              )
            : scaleCategory.name,
      ),
      onTap: onTap,
    );
  }
}
