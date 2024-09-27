// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// class CustomAppBar extends StatelessWidget {
//   CustomAppBar({super.key});
//   Widget? leading;
//   Widget? title;
//   List<Widget>? actions;
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       leading: leading,
//       title: title,
//       actions: actions,
//     );
//   }
// }

PreferredSizeWidget CustomAppBar({
  required BuildContext context,
  Widget? leading,
  String title = "",
  List<Widget>? actions,
}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    scrolledUnderElevation: 0,
    leading: leading,
    title: Text(
      title,
      style: GoogleFonts.manrope(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    ),
    actions: actions,
  );
}
