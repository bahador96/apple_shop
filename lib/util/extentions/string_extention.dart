import 'dart:ui';

extension ColorParsing on String? {
  Color parseToColor() {
    String colorString = 'FF$this';
    int hexColor = int.parse(colorString, radix: 16);

    return Color(hexColor);
  }
}
