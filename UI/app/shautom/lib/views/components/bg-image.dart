import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final Widget child;
  final ImageProvider image;

  // Constructor
  const BackgroundImage({
    Key? key,
    required this.image,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context)
        .size; // Return a size object with device height and width
    return Container(
        height: size.height,
        width: double.infinity,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: image,
                /*colorFilter: ColorFilter.mode(
                  Colors.blue.withOpacity(0.2),
                  BlendMode.darken,
                ),*/
                fit: BoxFit.cover)),
        child: child);
  }
}
