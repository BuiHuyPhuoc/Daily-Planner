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
    return Text(this.widget.title, style: GoogleFonts.manrope(fontSize: 22, color: Theme.of(context).colorScheme.onPrimary),);
  }
}