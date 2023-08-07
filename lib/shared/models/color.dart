import 'dart:ui';

extension ColorUtil on Color {
  Color mix(Color color, double amount) {
    return Color.lerp(this, color, amount)!;
  }
}
