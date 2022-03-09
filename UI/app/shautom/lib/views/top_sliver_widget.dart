import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final VoidCallback logOut;
  Widget pageTitle;
  Widget? child;

  CustomSliverAppBar({
    Key? key,
    required this.pageTitle,
    this.child,
    required this.logOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        pageTitle,
        new IconButton(
          icon: Icon(Icons
              .logout_rounded), //ImageIcon(Svg('assets/images/icons/logout (1).svg')),
          onPressed: logOut,
          padding: EdgeInsets.only(top: 0, right: 0),
        ),
      ]),
      backgroundColor: Colors.blue.withOpacity(0.6),
      shape: ContinuousRectangleBorder(
          side: BorderSide(color: Colors.white.withOpacity(0.7), width: 4),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
    );
  }
}
