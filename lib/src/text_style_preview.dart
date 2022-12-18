part of '../text_style_preview.dart';

typedef DescriptionBuilder = String Function(
    TextThemeType textThemeType, TextStyle textStyle);

class TextStylePreview extends StatefulWidget {
  final Text child;
  final bool enabled;
  final TextThemeType initTextThemeType;
  final Color? backgroundColor;
  final Color? barrierColor;
  final double? modalHeight;
  final LaunchType launchType;
  final bool showDivider;
  final DescriptionBuilder? descriptionBuilder;
  const TextStylePreview({
    super.key,
    required this.child,
    this.enabled = true,
    this.initTextThemeType = TextThemeType.bodyMedium,
    this.backgroundColor,
    this.barrierColor,
    this.modalHeight,
    this.launchType = LaunchType.onTap,
    this.showDivider = false,
    this.descriptionBuilder,
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

    showPreviewSheet() => showModalBottomSheet(
          context: context,
          backgroundColor: widget.backgroundColor,
          barrierColor: widget.barrierColor,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setModalState) => SizedBox(
                height: widget.modalHeight,
                child: Column(
                  children: [
                    if (widget.showDivider) const Divider(),
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
                          descriptionBuilder: widget.descriptionBuilder,
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
        if (widget.launchType == LaunchType.onTap) {
          showPreviewSheet.call();
        }
      },
      onLongPress: () {
        if (widget.launchType == LaunchType.onLongPress) {
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
