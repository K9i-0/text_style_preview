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

class TextStylePreview extends StatefulWidget {
  final Text child;
  final bool enabled;
  final ScaleCategory initScaleCategory;
  final TextStyleConverter? applyCustomStyle;
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
        defaultTextStylePreviewStyle?.barrierColor;
    final modalHeight = textStylePreviewStyle?.modalHeight ??
        defaultTextStylePreviewStyle?.modalHeight;
    final launchType = textStylePreviewStyle?.launchType ??
        defaultTextStylePreviewStyle?.launchType ??
        LaunchType.onTap;
    final showDivider = textStylePreviewStyle?.showDivider ??
        defaultTextStylePreviewStyle?.showDivider ??
        false;
    final descriptionBuilder = textStylePreviewStyle?.descriptionBuilder ??
        defaultTextStylePreviewStyle?.descriptionBuilder;
    final reverse = textStylePreviewStyle?.reverse ??
        defaultTextStylePreviewStyle?.reverse ??
        false;

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
  final Text child;
  const _TextThemeItem({
    required this.selectedScaleCategory,
    required this.scaleCategory,
    required this.onTap,
    required this.child,
    required this.descriptionBuilder,
    required this.applyCustomStyle,
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
            : scaleCategory
                .customStyleAppliedTextStyle(
                  context,
                  applyCustomStyle,
                )
                .debugLabel
                .toString(),
      ),
      onTap: onTap,
    );
  }
}
