import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatelessWidget {
  final VoidCallback logOut;
  final Widget pageTitle;
  final Widget? childWidget;

  CustomSliverAppBar({
    Key? key,
    required this.pageTitle,
    this.childWidget,
    required this.logOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverAppBar(
      elevation: 2,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          child: childWidget,
          padding: EdgeInsets.only(top: 30),
          //margin: ,
        ),
        centerTitle: true,
      ),
      expandedHeight: size.height * 0.2,
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
          side: BorderSide(color: Color(0xFFFEDB41).withOpacity(0.3), width: 3),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40))),
    );
  }
}
