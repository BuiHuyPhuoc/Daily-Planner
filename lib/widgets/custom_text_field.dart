import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget CustomTextField(
    {Icon? prefixIcon,
    required BuildContext context,
    String hintText = "...",
    TextEditingController? controller,
    bool obscureText = false,
    IconButton? suffixIcon,
    int maxLines = 1,
    bool readOnly = false,
    String? value,
    List<FilteringTextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    bool enable = true,
    bool enableSuggestions = true,
    bool autocorrect =  true}) {
  return TextFormField(
    validator: validator,
    inputFormatters: inputFormatters,
    initialValue: value,
    readOnly: readOnly,
    maxLines: maxLines,
    obscureText: obscureText,
    enableSuggestions: enableSuggestions,
    autocorrect: autocorrect,
    controller: controller,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
      hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary.withOpacity(0.8)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      errorStyle: TextStyle(color: Theme.of(context).colorScheme.error),
    ),
  );
}
