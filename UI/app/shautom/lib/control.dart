import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';

class ControlPage extends StatefulWidget {
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  bool _isTvOn = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        child: GridView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: size.height * 0.1,
              child: Column(children: [
                Center(
                  child: Icon(
                    Icons.lightbulb,
                    size: 50,
                    color: Colors.blue,
                  ),
                )
              ]),
              decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(40),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              height: size.height * 0.1,
              decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(40),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              height: size.height * 0.1,
              decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(40),
                  borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              height: size.height * 0.1,
              decoration: BoxDecoration(
                  color: Colors.grey.withAlpha(40),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ],
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        ),
      ),
    );
  }
}
