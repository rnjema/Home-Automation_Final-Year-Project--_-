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
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 2.5),
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2.5),
      width: size.width * 0.4,
      height: size.height * 0.08,
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(40)),
      child: child,
    );
  }
}
