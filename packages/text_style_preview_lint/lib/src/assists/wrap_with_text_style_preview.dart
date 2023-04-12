import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

/// [TypeChecker] from `Text` from flutter
const _textType = TypeChecker.fromName('Text', packageName: 'flutter');

/// But the priority above everything else
const _wrapPriority = 100;

class WrapWithTextStylePreview extends DartAssist {
  WrapWithTextStylePreview();

  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      // Select from "new" to the opening bracket
      if (!target.intersects(node.constructorName.sourceRange)) return;

      final createdType = node.constructorName.type.type;
      if (createdType == null || !_textType.isExactlyType(createdType)) {
        return;
      }

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Wrap with TextStylePreview',
        priority: _wrapPriority,
      );

      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleInsertion(
          node.offset,
          'TextStylePreview(child: ',
        );
        builder.addSimpleInsertion(node.end, ',)');
      });
    });
  }
}
