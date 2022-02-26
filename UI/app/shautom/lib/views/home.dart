import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:shautom/control.dart';
import 'package:shautom/models/user.dart';
import 'package:shautom/monitor.dart';
import 'package:shautom/profile.dart';

import 'package:shautom/views/welcome.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  User? _user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(_user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Media Device data config

    List<Widget> _pages = [
      Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: RichText(
                  text: TextSpan(children: <InlineSpan>[
                    TextSpan(
                        text: "Hello, ", style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: "${loggedInUser.firstName}",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontStyle: FontStyle.italic))
                  ]),
                )),
                Align(
                  alignment: Alignment.topRight,
                  child: new IconButton(
                    icon: ImageIcon(Svg('assets/images/icons/logout (1).svg')),
                    onPressed: _signOut,
                    padding: EdgeInsets.only(top: 0, right: 0),
                  ),
                ),
              ],
            )
          ]),
      ProfilePage(),
      ControlPage(),
      MonitorPage()
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
                width: double.infinity,
                height: size.height,
                padding: EdgeInsets.symmetric(
                    horizontal: 2, vertical: size.height * 0.005),
                child: _pages.elementAt(_selectedIndex))),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
          backgroundColor: Colors.grey.withAlpha(50),
          elevation: 0, //Color(0xFF3F51B5)
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: ImageIcon(Svg('assets/images/icons/home.svg')),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                    Svg(
                      'assets/images/icons/person.svg',
                    ),
                    size: 30),
                label: 'Profile'),
            BottomNavigationBarItem(
                icon: ImageIcon(Svg('assets/images/icons/control.svg')),
                label: "Control"),
            BottomNavigationBarItem(
                icon: ImageIcon(Svg('assets/images/icons/monitor.svg')),
                label: 'Monitor'),
          ],
        ));
  }
}
