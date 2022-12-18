part of '../text_style_preview.dart';

typedef DescriptionBuilder = String Function(
    TextThemeType textThemeType, TextStyle textStyle);

class TextStylePreview extends StatefulWidget {
  final Text child;
  final bool enabled;
  final TextThemeType initTextThemeType;
  final TextThemePreviewStyle? style;
  const TextStylePreview({
    super.key,
    required this.child,
    this.enabled = true,
    this.initTextThemeType = TextThemeType.bodyMedium,
    this.style,
  });

  @override
  State<TextStylePreview> createState() => _TextStylePreviewState();
}

class _TextStylePreviewState extends State<TextStylePreview> {
  late TextThemeType _selectedTextThemeType;

  @override
  void initState() {
    _selectedTextThemeType = widget.initTextThemeType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode || !widget.enabled) {
      return widget.child;
    }

    final defaultTextThemePreviewStyle =
        Theme.of(context).extension<TextThemePreviewStyle>();
    final textThemePreviewStyle = widget.style;
    final backgroundColor = textThemePreviewStyle?.backgroundColor ??
        defaultTextThemePreviewStyle?.backgroundColor;
    final barrierColor = textThemePreviewStyle?.barrierColor ??
        defaultTextThemePreviewStyle?.barrierColor;
    final modalHeight = textThemePreviewStyle?.modalHeight ??
        defaultTextThemePreviewStyle?.modalHeight;
    final launchType = textThemePreviewStyle?.launchType ??
        defaultTextThemePreviewStyle?.launchType ??
        LaunchType.onTap;
    final showDivider = textThemePreviewStyle?.showDivider ??
        defaultTextThemePreviewStyle?.showDivider ??
        false;
    final descriptionBuilder = textThemePreviewStyle?.descriptionBuilder ??
        defaultTextThemePreviewStyle?.descriptionBuilder;

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
                        itemCount: TextThemeType.values.length,
                        itemBuilder: (context, index) => _TextThemeItem(
                          textThemeType: TextThemeType.values[index],
                          selectedTextThemeType: _selectedTextThemeType,
                          onTap: () {
                            setState(() {
                              _selectedTextThemeType =
                                  TextThemeType.values[index];
                            });
                            setModalState(() {
                              _selectedTextThemeType =
                                  TextThemeType.values[index];
                            });
                          },
                          descriptionBuilder: descriptionBuilder,
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
        style: _selectedTextThemeType.textStyle(context),
        child: widget.child,
      ),
    );
  }
}

class _TextThemeItem extends StatelessWidget {
  final TextThemeType selectedTextThemeType;
  final TextThemeType textThemeType;
  final VoidCallback onTap;
  final DescriptionBuilder? descriptionBuilder;
  final Text child;
  const _TextThemeItem({
    required this.selectedTextThemeType,
    required this.textThemeType,
    required this.onTap,
    required this.child,
    required this.descriptionBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.check,
        color: selectedTextThemeType == textThemeType
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
      ),
      title: DefaultTextStyle(
        style: textThemeType.textStyle(context),
        child: child,
      ),
      subtitle: Text(
        descriptionBuilder != null
            ? descriptionBuilder!(
                textThemeType,
                textThemeType.textStyle(context),
              )
            : textThemeType.textStyle(context).debugLabel.toString(),
      ),
      onTap: onTap,
    );
  }
}
