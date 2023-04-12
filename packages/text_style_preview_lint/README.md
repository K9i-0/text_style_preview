text_style_preview_lint is a package to make using [text_style_preview] more comfortable.

## Getting started

text_style_preview_lint is implemented using [custom_lint]. As such, it uses custom_lint's installation logic.  
Long story short:

- Add both text_style_preview_lint and custom_lint to your `pubspec.yaml`:
  ```yaml
  dev_dependencies:
    custom_lint:
    text_style_preview_lint:
  ```
- Enable `custom_lint`'s plugin in your `analysis_options.yaml`:

  ```yaml
  analyzer:
    plugins:
      - custom_lint
  ```

## Usage

Wrap Text widget with a TextStylePreview

<p align="center">
  <img src="https://raw.githubusercontent.com/K9i-0/text_style_preview/main/WrapWithTextStylePreview.png" alt="text_style_preview" />
</p>

[text_style_preview]: https://pub.dev/packages/text_style_preview
[text_style_preview_lint]: https://pub.dev/packages/text_style_preview_lint
[custom_lint]: https://pub.dev/packages/custom_lint