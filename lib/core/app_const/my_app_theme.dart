import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:google_fonts/google_fonts.dart';

class MyAppTheme {
  final TextTheme textTheme;

  const MyAppTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1e6586),
      surfaceTint: Color(0xff1e6586),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffc5e7ff),
      onPrimaryContainer: Color(0xff004c6a),
      secondary: Color(0xff4e616d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffd2e5f4),
      onSecondaryContainer: Color(0xff374955),
      tertiary: Color(0xff615a7c),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffe7deff),
      onTertiaryContainer: Color(0xff494263),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff6fafe),
      onSurface: Color(0xff181c1f),
      onSurfaceVariant: Color(0xff41484d),
      outline: Color(0xff71787e),
      outlineVariant: Color(0xffc1c7ce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2c3134),
      inversePrimary: Color(0xff91cef4),
      primaryFixed: Color(0xffc5e7ff),
      onPrimaryFixed: Color(0xff001e2d),
      primaryFixedDim: Color(0xff91cef4),
      onPrimaryFixedVariant: Color(0xff004c6a),
      secondaryFixed: Color(0xffd2e5f4),
      onSecondaryFixed: Color(0xff0a1e28),
      secondaryFixedDim: Color(0xffb6c9d8),
      onSecondaryFixedVariant: Color(0xff374955),
      tertiaryFixed: Color(0xffe7deff),
      onTertiaryFixed: Color(0xff1d1735),
      tertiaryFixedDim: Color(0xffcbc1e9),
      onTertiaryFixedVariant: Color(0xff494263),
      surfaceDim: Color(0xffd7dadf),
      surfaceBright: Color(0xfff6fafe),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f4f8),
      surfaceContainer: Color(0xffebeef3),
      surfaceContainerHigh: Color(0xffe5e8ed),
      surfaceContainerHighest: Color(0xffdfe3e7),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff91cef4),
      surfaceTint: Color(0xff91cef4),
      onPrimary: Color(0xff00344a),
      primaryContainer: Color(0xff004c6a),
      onPrimaryContainer: Color(0xffc5e7ff),
      secondary: Color(0xffb6c9d8),
      onSecondary: Color(0xff20333e),
      secondaryContainer: Color(0xff374955),
      onSecondaryContainer: Color(0xffd2e5f4),
      tertiary: Color(0xffcbc1e9),
      onTertiary: Color(0xff332c4c),
      tertiaryContainer: Color(0xff494263),
      onTertiaryContainer: Color(0xffe7deff),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffdfe3e7),
      onSurfaceVariant: Color(0xffc1c7ce),
      outline: Color(0xff8b9297),
      outlineVariant: Color(0xff41484d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe3e7),
      inversePrimary: Color(0xff1e6586),
      primaryFixed: Color(0xffc5e7ff),
      onPrimaryFixed: Color(0xff001e2d),
      primaryFixedDim: Color(0xff91cef4),
      onPrimaryFixedVariant: Color(0xff004c6a),
      secondaryFixed: Color(0xffd2e5f4),
      onSecondaryFixed: Color(0xff0a1e28),
      secondaryFixedDim: Color(0xffb6c9d8),
      onSecondaryFixedVariant: Color(0xff374955),
      tertiaryFixed: Color(0xffe7deff),
      onTertiaryFixed: Color(0xff1d1735),
      tertiaryFixedDim: Color(0xffcbc1e9),
      onTertiaryFixedVariant: Color(0xff494263),
      surfaceDim: Color(0xff0f1417),
      surfaceBright: Color(0xff353a3d),
      surfaceContainerLowest: Color(0xff0a0f12),
      surfaceContainerLow: Color(0xff181c1f),
      surfaceContainer: Color(0xff1c2023),
      surfaceContainerHigh: Color(0xff262b2e),
      surfaceContainerHighest: Color(0xff313539),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,

    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: colorScheme.primary, // 👈 status bar color
        statusBarIconBrightness: colorScheme.brightness == Brightness.dark
            ? Brightness
                  .light // light icons for dark bg
            : Brightness.dark, // dark icons for light bg
      ),
    ),
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}


TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
  GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}
