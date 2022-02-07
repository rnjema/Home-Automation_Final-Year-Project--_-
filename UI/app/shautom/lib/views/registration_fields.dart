import 'package:flutter/material.dart';
import 'package:shautom/views/containers.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class TextFieldItem {
  TextFieldItem(this.hintText, this.icon);

  String hintText;
  ImageIcon icon;
}

List<TextFieldItem> formItems = <TextFieldItem>[
  TextFieldItem("First name", ImageIcon(Svg('assets/images/icons/user.svg'))),
  TextFieldItem("Last name", ImageIcon(Svg('assets/images/icons/user.svg'))),
];
