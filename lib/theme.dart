import 'package:flutter/material.dart';

class ThemeColor {
  static Color mainColor = Color.fromRGBO(0, 136, 12, 1);
}

final lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF006E08),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF89FC77),
  onPrimaryContainer: Color(0xFF002201),
  secondary: Colors.green.shade50, //Color(0xFF2F6B26),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFA6F694),
  onSecondaryContainer: Colors.green.shade50, //Color(0xFF2F6B26),
  tertiary: Colors.green.shade50, //Color(0xFF2F6B26),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFB0F49E),
  onTertiaryContainer: Colors.green.shade50, //Color(0xFF2F6B26),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFCFDF6),
  onBackground: Color(0xFF1A1C18),
  surface: Color.fromARGB(255, 32, 36, 42), //Color(0xFF1A1C1E),
  onSurface: Color(0xFF1A1C18),
  surfaceVariant: Color(0xFFDFE4D8),
  onSurfaceVariant: Colors.green.shade50, //Color(0xFF2F6B26),
  outline: Colors.green.shade50, //Color(0xFF2F6B26),
  onInverseSurface: Color(0xFFF1F1EB),
  inverseSurface: Colors.green.shade50, //Color(0xFF2F6B26),
  inversePrimary: Color(0xFF6DDF5E),
  shadow: Color(0xFF000000),
  surfaceTint: Colors.green.shade50, //Color(0xFF2F6B26),
  outlineVariant: Color(0xFFC3C8BC),
  scrim: Colors.green.shade50, //Color(0xFF2F6B26),
);
