part of '../text_style_preview.dart';

class TextStylePreview extends StatefulWidget {
  final Text child;
  const TextStylePreview({super.key, required this.child});

  @override
  State<TextStylePreview> createState() => _TextStylePreviewState();
}

class _TextStylePreviewState extends State<TextStylePreview> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final typographyList = [
      textTheme.displayLarge,
      textTheme.displayMedium,
      textTheme.displaySmall,
      textTheme.headlineLarge,
      textTheme.headlineMedium,
      textTheme.headlineSmall,
      textTheme.titleLarge,
      textTheme.titleMedium,
      textTheme.titleSmall,
      textTheme.labelLarge,
      textTheme.labelMedium,
      textTheme.labelSmall,
      textTheme.bodyLarge,
      textTheme.bodyMedium,
      textTheme.bodySmall,
    ];

    return GestureDetector(
      onTap: () {
        // シートを表示
        // showModalBottomSheet(
        //   context: context,
        //   builder: (context) {
        //     return ListView.builder(
        //       shrinkWrap: true,
        //       itemCount: typographyList.length - 11,
        //       itemBuilder: (context, index) {
        //         return ListTile(
        //           title: DefaultTextStyle(
        //             style: typographyList[index]!,
        //             child: widget.child,
        //           ),
        //           onTap: () {
        //             setState(() {
        //               _index = index;
        //             });
        //             Navigator.pop(context);
        //           },
        //         );
        //       },
        //     );
        //   },
        // );
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.black54,
          barrierColor: Colors.transparent,
          builder: (context) {
            return SizedBox(
              height: 250,
              child: PageView.builder(
                controller: PageController(viewportFraction: 0.8),
                onPageChanged: (value) {
                  setState(() {
                    _index = value;
                  });
                },
                itemCount: typographyList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: DefaultTextStyle(
                      style: typographyList[index]!,
                      child: widget.child,
                    ),
                    subtitle:
                        Text(typographyList[index]!.debugLabel.toString()),
                    onTap: () {
                      setState(() {
                        _index = index;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            );
          },
        );
      },
      child: DefaultTextStyle(
        style: typographyList[_index]!,
        child: widget.child,
      ),
    );
  }
}
