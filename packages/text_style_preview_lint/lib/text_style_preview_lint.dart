library text_style_preview_lint;

import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:text_style_preview_lint/src/assists/wrap_with_text_style_preview.dart';

PluginBase createPlugin() => _TextStylePreviewLint();

class _TextStylePreviewLint extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => const [];

  @override
  List<Assist> getAssists() => [
        WrapWithTextStylePreview(),
      ];
}
