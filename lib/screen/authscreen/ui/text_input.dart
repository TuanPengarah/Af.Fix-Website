import 'package:affix_web/config/constant.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

SizedBox authTextInput({
  @required BuildContext context,
  @required bool isDarkMode,
  @required TextEditingController controller,
  @required String title,
  @required String subtitle,
  @required FocusNode focus,
  bool isPassword,
  @required Icon icon,
  String err,
  @required TextInputType type,
  RoundedLoadingButtonController buttonController,
  Function onEnter,
}) {
  return SizedBox(
    width: 400,
    child: TextField(
      obscureText: isPassword ?? false,
      controller: controller,
      focusNode: focus,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.center,
      keyboardType: type ?? TextInputType.emailAddress,
      style: TextStyle(fontWeight: FontWeight.bold),
      onEditingComplete: onEnter,
      decoration: InputDecoration(
        prefixIcon: icon,
        hintText: subtitle,
        errorText: err,
        errorStyle: TextStyle(color: Colors.amber.shade800),
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 13,
        ),
        filled: true,
        alignLabelWithHint: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: title,
        labelStyle: TextStyle(
          color: isDarkMode == false ? Colors.white : kColorGrey,
          fontSize: 13,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.amber.shade800,
            width: 2.5,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    ),
  );
}
