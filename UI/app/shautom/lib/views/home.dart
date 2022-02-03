import 'package:flutter/material.dart';
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
                    SizedBox(),
                    TextFieldContainer(
                        child: TextField(
                      decoration: InputDecoration(
                          //fillColor: Colors.transparent,
                          hintText: 'Username',
                          icon: Icon(Icons.person)),
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
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
