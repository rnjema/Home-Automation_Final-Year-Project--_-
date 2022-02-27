import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    Key? key,
    this.imageUrl = "assets/images/logo2.png",
    this.heightFactor = 1 / 3.2,
    this.widthFactor = 0.7,
  }) : super(key: key);

  final String imageUrl;
  final double heightFactor;
  final double widthFactor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * heightFactor,
      width: size.width * widthFactor,
      decoration: BoxDecoration(
          image: DecorationImage(
              //scale: 1.5,
              image: AssetImage(imageUrl))),
    );
  }
}
