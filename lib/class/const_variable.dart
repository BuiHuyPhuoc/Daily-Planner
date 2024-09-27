import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// ignore: must_be_immutable
class AppBarTitle extends StatefulWidget {
  AppBarTitle({super.key, required this.title});
  String title;

  @override
  State<AppBarTitle> createState() => _AppBarTitleState();
}

class _AppBarTitleState extends State<AppBarTitle> {
  @override
  Widget build(BuildContext context) {
    return Text(
      this.widget.title,
      style: PrimaryTextStyle(
          fontSize: 22, color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}

TextStyle PrimaryTextStyle(
    {Paint? background,
    Color? backgroundColor,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<FontFeature>? fontFeatures,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    Paint? foreground,
    double? height,
    double? letterSpacing,
    Locale? locale,
    List<Shadow>? shadows,
    TextBaseline? textBaseline,
    TextStyle? textStyle,
    double? wordSpacing}) {
  return GoogleFonts.lexendDeca(
      background: background,
      backgroundColor: backgroundColor,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      fontFeatures: fontFeatures,
      fontSize: fontSize,
      fontWeight: fontWeight,
      foreground: foreground,
      height: height,
      letterSpacing: letterSpacing,
      locale: locale,
      shadows: shadows,
      textBaseline: textBaseline,
      textStyle: textStyle,
      wordSpacing: wordSpacing);
}
