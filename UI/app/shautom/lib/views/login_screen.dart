import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shautom/constants.dart';
import 'package:shautom/views/components/bg-image.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackgroundImage(
        image: AssetImage('assets/images/iot-background.jpg'),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
                width: double.infinity,
                height: size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                        top: size.height * 0.05,
                        child: Container(
                            width: size.height * 0.3,
                            child: Image.asset("assets/images/logo.png"))),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Positioned(
                        top: size.height * 0.3,
                        child: TextFieldContainer(
                          child: TextField(
                              decoration: InputDecoration(
                            //fillColor: Colors.transparent,
                            border: InputBorder.none,
                            hintText: 'Username',
                            icon: Icon(Icons.person),
                            //suffixIcon: ImageIcon(SvgIma)),
                          )),
                        ))
                  ],
                ))));
  }
}

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
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
