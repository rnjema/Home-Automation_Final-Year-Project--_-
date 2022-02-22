import 'package:flutter/material.dart';
//import 'package:shautom/views/containers.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

String? validateUser(String? value) {
  if (value == null) {
    return "Username can not be empty!";
  } else {
    return null;
  }
}

String? validatePassword(String? val) {
  if (val == null) {
    return "Password must not be empty!";
  } else {
    return null;
  }
}

class TextFieldItem {
  final String hintText;
  final ImageIcon icon;
  final bool hidden;

  // With default hidden value
  TextFieldItem(this.hintText, this.icon, [this.hidden = false]);
}

List<TextFieldItem> registrationFields = <TextFieldItem>[
  TextFieldItem("First name",
      ImageIcon(Svg('assets/images/icons/user.svg', color: Color(0xFF3F51B5)))),
  TextFieldItem("Last name",
      ImageIcon(Svg('assets/images/icons/user.svg', color: Color(0xFF3F51B5)))),
  TextFieldItem(
      "Email",
      ImageIcon(
          Svg('assets/images/icons/email.svg', color: Color(0xFF3F51B5)))),
  TextFieldItem(
      "Phone",
      ImageIcon(
          Svg('assets/images/icons/telephone.svg', color: Color(0xFF3F51B5)))),
  TextFieldItem(
      "Password",
      ImageIcon(Svg('assets/images/icons/key.svg', color: Color(0xFF3F51B5))),
      true),
  TextFieldItem(
      "Confirm Password",
      ImageIcon(Svg('assets/images/icons/key.svg', color: Color(0xFF3F51B5))),
      true),
];

List<TextFieldItem> loginFields = <TextFieldItem>[
  TextFieldItem("Username/Email",
      ImageIcon(Svg('assets/images/icons/user.svg', color: Color(0xFF3F51B5)))),
  TextFieldItem(
      "Password",
      ImageIcon(Svg('assets/images/icons/key.svg', color: Color(0xFF3F51B5))),
      true),
];
