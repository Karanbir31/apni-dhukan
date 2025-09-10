import "package:flutter/material.dart";

class MyAppTheme {
  final TextTheme textTheme;

  const MyAppTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006783),
      surfaceTint: Color(0xff006783),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff8bdcff),
      onPrimaryContainer: Color(0xff00617c),
      secondary: Color(0xff46626f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffc9e7f7),
      onSecondaryContainer: Color(0xff4c6875),
      tertiary: Color(0xff725185),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffebc3ff),
      onTertiaryContainer: Color(0xff6d4d80),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff7fafc),
      onSurface: Color(0xff181c1e),
      onSurfaceVariant: Color(0xff3f484d),
      outline: Color(0xff6f787e),
      outlineVariant: Color(0xffbec8ce),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d3133),
      inversePrimary: Color(0xff80d1f4),
      primaryFixed: Color(0xffbce9ff),
      onPrimaryFixed: Color(0xff001f2a),
      primaryFixedDim: Color(0xff80d1f4),
      onPrimaryFixedVariant: Color(0xff004d63),
      secondaryFixed: Color(0xffc9e7f7),
      onSecondaryFixed: Color(0xff001f2a),
      secondaryFixedDim: Color(0xffadcbda),
      onSecondaryFixedVariant: Color(0xff2e4b57),
      tertiaryFixed: Color(0xfff4d9ff),
      onTertiaryFixed: Color(0xff2b0d3d),
      tertiaryFixedDim: Color(0xffe0b8f4),
      onTertiaryFixedVariant: Color(0xff593a6c),
      surfaceDim: Color(0xffd7dadd),
      surfaceBright: Color(0xfff7fafc),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff1f4f6),
      surfaceContainer: Color(0xffebeef1),
      surfaceContainerHigh: Color(0xffe6e8eb),
      surfaceContainerHighest: Color(0xffe0e3e5),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd8f2ff),
      surfaceTint: Color(0xff80d1f4),
      onPrimary: Color(0xff003545),
      primaryContainer: Color(0xff8bdcff),
      onPrimaryContainer: Color(0xff00617c),
      secondary: Color(0xffadcbda),
      onSecondary: Color(0xff163440),
      secondaryContainer: Color(0xff2e4b57),
      onSecondaryContainer: Color(0xff9cbac8),
      tertiary: Color(0xfffae8ff),
      onTertiary: Color(0xff412354),
      tertiaryContainer: Color(0xffebc3ff),
      onTertiaryContainer: Color(0xff6d4d80),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101416),
      onSurface: Color(0xffe0e3e5),
      onSurfaceVariant: Color(0xffbec8ce),
      outline: Color(0xff899297),
      outlineVariant: Color(0xff3f484d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe0e3e5),
      inversePrimary: Color(0xff006783),
      primaryFixed: Color(0xffbce9ff),
      onPrimaryFixed: Color(0xff001f2a),
      primaryFixedDim: Color(0xff80d1f4),
      onPrimaryFixedVariant: Color(0xff004d63),
      secondaryFixed: Color(0xffc9e7f7),
      onSecondaryFixed: Color(0xff001f2a),
      secondaryFixedDim: Color(0xffadcbda),
      onSecondaryFixedVariant: Color(0xff2e4b57),
      tertiaryFixed: Color(0xfff4d9ff),
      onTertiaryFixed: Color(0xff2b0d3d),
      tertiaryFixedDim: Color(0xffe0b8f4),
      onTertiaryFixedVariant: Color(0xff593a6c),
      surfaceDim: Color(0xff101416),
      surfaceBright: Color(0xff363a3c),
      surfaceContainerLowest: Color(0xff0b0f11),
      surfaceContainerLow: Color(0xff181c1e),
      surfaceContainer: Color(0xff1c2022),
      surfaceContainerHigh: Color(0xff272b2d),
      surfaceContainerHighest: Color(0xff313538),
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
