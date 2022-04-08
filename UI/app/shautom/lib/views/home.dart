import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'dart:async';

import 'package:shautom/control.dart';
import 'package:shautom/models/user.dart';
import 'package:shautom/monitor.dart';
import 'package:shautom/profile.dart';
import 'package:shautom/views/components/logo.dart';
import 'package:shautom/views/welcome.dart';
import 'package:shautom/views/top_sliver_widget.dart';
import 'package:shautom/landing.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isLoaded = false;

  User? _user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WelcomePage()));
  }

  late DatabaseReference _dhtRef;
  late Stream<DatabaseEvent> _dhtStream;

  /// Initializes Firebase realtime database configuration & state
  Future<void> init() async {
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    _dhtRef = FirebaseDatabase.instance
        .ref("Shautom/User/2vtcqvRNBVUPi0XtnxbUJRAy9GE2/");

    _dhtStream = _dhtRef.onValue.asBroadcastStream();
  }

  @override
  void dispose() {
    super.dispose();
    _dhtStream.drain();
    //_dhtRef.onDisconnect();
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
      setState(() {
        _isLoaded = true;
      });
    });
    init();
  }

  UserModel getUser() {
    return this.loggedInUser;
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Map<String, dynamic>> _pages = {
      0: {
        'title': 'Home',
        'widget': LandingPage(
          loaded: _isLoaded,
          user: loggedInUser,
          dataRef: _dhtRef,
        )
      },
      1: {'title': 'Control Dashboard', 'widget': ControlPage()},
      2: {'title': 'Monitoring Dashboard', 'widget': MonitorPage()},
      3: {
        'title': 'Profile',
        'widget': ProfilePage(
          user: loggedInUser,
        )
      },
    };

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return WillPopScope(
      onWillPop: () async {
        final isFirstTab = !await _pages[_selectedIndex]!['widget']
            .key
            .currentState
            .maybePop();

        if (isFirstTab) {
          if (_selectedIndex != 0) {
            _onItemTapped(0);

            return false;
          }
        }

        return isFirstTab;
      },
      child: Container(
        child: Scaffold(
            //resizeToAvoidBottomInset: false,
            body: SafeArea(
                child: CustomScrollView(slivers: [
              CustomSliverAppBar(
                  childWidget: LogoWidget(
                    widthFactor: 0.8,
                  ),
                  pageTitle: Text(_pages[_selectedIndex]!['title']),
                  logOut: _signOut),
              SliverFillRemaining(
                  child: IndexedStack(
                index: _selectedIndex,
                children: _pages.entries
                    .map((e) => e.value['widget'] as Widget)
                    .toList(),
              )),
            ])),
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
                    icon: ImageIcon(Svg('assets/images/icons/control.svg')),
                    label: "Control"),
                BottomNavigationBarItem(
                    icon: ImageIcon(Svg('assets/images/icons/monitor.svg')),
                    label: 'Monitor'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                      size: 30,
                    ), //ImageIcon(Svg('assets/images/icons/person.svg',),ize: 30),
                    label: 'Settings'),
              ],
            )),
      ),
    );
  }
}
