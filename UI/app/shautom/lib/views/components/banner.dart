import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget(
    Key? key,
    this.imageUrl, [
    this.heightFactor = 1 / 3.2,
    this.widthFactor = 0.7,
  ]) : super(key: key);

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
