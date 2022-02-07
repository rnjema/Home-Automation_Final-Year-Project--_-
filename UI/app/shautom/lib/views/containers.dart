import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
      width: size.width * 0.4,
      height: size.height * 0.09,
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(50)),
      child: child,
    );
  }
}
