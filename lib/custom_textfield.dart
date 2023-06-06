import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:goferry/theme.dart';

InputDecoration kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: const TextStyle(color: Colors.grey),
    contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ThemeColor.mainColor, width: 1.0),
      borderRadius: const BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ThemeColor.mainColor, width: 2.0),
      borderRadius: const BorderRadius.all(Radius.circular(32.0)),
    ));

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.prefix,
    this.enabled,
    this.prefixIcon,
    this.validator,
    this.textEditingController,
    this.isPassword = false,
    this.hintText,
    this.labelText,
    this.autovalidateMode,
    this.keyboardType,
    this.onTap,
    this.onSaved,
    this.textInputFormatter,
  }) : super(key: key);
  final bool? enabled;
  final bool? isPassword;
  final TextEditingController? textEditingController;
  final List<TextInputFormatter>? textInputFormatter;
  final String? hintText, labelText;
  final Icon? prefixIcon;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: false,
      controller: textEditingController,
      inputFormatters: textInputFormatter,
      decoration: kTextFieldDecoration.copyWith(
          //contentPadding: EdgeInsets.all(0),
          prefix: prefix,
          prefixIcon: prefixIcon,
          hintText: hintText,
          labelText: labelText,
          suffixIcon: const SizedBox(height: 0)),
      onSaved: onSaved,
      onTap: onTap,
    );
  }
}
