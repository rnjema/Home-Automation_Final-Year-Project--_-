import 'package:flutter/material.dart';
//import 'package:shautom/views/containers.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

const Map<String, TextInputType?> _inputTypes = {
  'email': TextInputType.emailAddress,
  'phone': TextInputType.phone,
  'default': TextInputType.text
};

String? validateUser(String? value) {
  if (value == null || value.isEmpty) {
    return "Username can not be empty!";
  } else {
    return null;
  }
}

String? validatePassword(String? val) {
  if (val == null || val.isEmpty) {
    return "Password must not be empty!";
  } else if (val.length < 6) {
    return "Password must be 6+ characters long!";
  } else {
    return null;
  }
}

//final List<Function> _validators = [validateUser, validatePassword];

class TextFieldItem {
  final String hintText;
  final ImageIcon icon;
  final bool hidden;
  final TextInputType? kType;

  // With default hidden value
  const TextFieldItem(this.hintText, this.icon,
      {this.hidden = false, this.kType = TextInputType.text});
}

List<TextFieldItem> registrationFields = <TextFieldItem>[
  TextFieldItem("First name",
      ImageIcon(Svg('assets/images/icons/user.svg', color: Color(0xFF3F51B5)))),
  TextFieldItem("Last name",
      ImageIcon(Svg('assets/images/icons/user.svg', color: Color(0xFF3F51B5)))),
  TextFieldItem("Email",
      ImageIcon(Svg('assets/images/icons/email.svg', color: Color(0xFF3F51B5))),
      kType: _inputTypes['email']),
  TextFieldItem(
      "Phone",
      ImageIcon(
          Svg('assets/images/icons/telephone.svg', color: Color(0xFF3F51B5))),
      kType: _inputTypes['phone']),
  TextFieldItem("Password",
      ImageIcon(Svg('assets/images/icons/key.svg', color: Color(0xFF3F51B5))),
      hidden: true),
  TextFieldItem("Confirm Password",
      ImageIcon(Svg('assets/images/icons/key.svg', color: Color(0xFF3F51B5))),
      hidden: true),
];

List<TextFieldItem> loginFields = <TextFieldItem>[
  TextFieldItem("Email",
      ImageIcon(Svg('assets/images/icons/user.svg', color: Color(0xFF3F51B5))),
      kType: _inputTypes['email']),
  TextFieldItem("Password",
      ImageIcon(Svg('assets/images/icons/key.svg', color: Color(0xFF3F51B5))),
      hidden: true),
];
