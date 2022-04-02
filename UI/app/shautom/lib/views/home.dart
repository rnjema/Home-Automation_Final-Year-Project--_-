import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import 'package:shautom/control.dart';
import 'package:shautom/models/user.dart';
import 'package:shautom/monitor.dart';
import 'package:shautom/profile.dart';
import 'package:shautom/views/components/logo.dart';
import 'package:shautom/views/components/readings.dart';
import 'package:shautom/views/welcome.dart';
import 'package:shautom/views/top_sliver_widget.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

class LandingPage extends StatelessWidget {
  UserModel? user;
  bool loaded;

  LandingPage({
    Key? key,
    required this.user,
    required this.loaded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: GestureDetector(
                onTap: () => null,
                child: loaded
                    ? RichText(
                        text: TextSpan(
                            style: TextStyle(
                              fontSize: 30,
                            ),
                            children: <InlineSpan>[
                            TextSpan(
                                text: "Welcome Home, \n",
                                style: TextStyle(color: Colors.black)),
                            TextSpan(
                                text: "${user!.firstName}",
                                style: TextStyle(
                                  color: Colors.blueGrey.withOpacity(0.7),
                                  //fontStyle: FontStyle.italic
                                ))
                          ]))
                    : Text(''),
              )),
            ],
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            margin: EdgeInsets.only(top: 0),
            height: size.height * 0.25,
            child: ListView(
              children: [
                Card(
                  elevation: 2,
                  shadowColor: Colors.blue.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.black.withOpacity(0.1), width: 2)),
                  child: Container(
                    padding: EdgeInsets.only(left: 6, top: 3),
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.thermostat,
                              color: Colors.red.withOpacity(0.4),
                            ),
                            Text(
                              "Temperature",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.005,
                        ),
                        Container(
                          padding: EdgeInsets.all(0),
                          width: 105,
                          height: 105,
                          child: Center(child: TemperatureGauge(value: 25)),
                        ),
                      ],
                    ),
                    width: size.width * 0.4,
                    height: size.height * 0.25,
                  ),
                ),
                Card(
                  elevation: 2,
                  shadowColor: Colors.blue.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.black.withOpacity(0.1), width: 2)),
                  child: Container(
                    padding: EdgeInsets.only(left: 6, top: 3),
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(children: [
                          Icon(
                            MaterialCommunityIcons.water_percent,
                            color: Colors.blue.withOpacity(0.4),
                          ),
                          SizedBox(width: 5),
                          Text("Humidity")
                        ]),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Container(
                            padding: EdgeInsets.all(0),
                            width: 105,
                            height: 105,
                            child: Center(
                              child: HumidityGauge(value: 80),
                            )),
                      ],
                    ),
                    width: size.width * 0.4,
                    height: size.height * 0.25,
                  ),
                ),
                Card(
                  elevation: 2,
                  shadowColor: Colors.blue.withOpacity(0.6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.black.withOpacity(0.1), width: 2)),
                  child: Container(
                    padding: EdgeInsets.only(left: 6, top: 3),
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(children: [
                          Icon(
                            Icons.bolt,
                            color: Colors.red.withOpacity(0.4),
                          ),
                          Text("Power Consumption")
                        ]),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Center(child: Text('Current Consumption')),
                      ],
                    ),
                    width: size.width * 0.45,
                    height: size.height * 0.25,
                  ),
                ),
              ],
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 15),
          Text('Devices', style: TextStyle(fontSize: 25)),
          SizedBox(
            height: size.height * 0.2,
            width: double.infinity,
            child: Container(
              child: ListView(scrollDirection: Axis.horizontal, children: [
                Card(
                    elevation: 2,
                    shadowColor: Colors.blue.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Colors.black.withOpacity(0.1), width: 2)),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            gradient: RadialGradient(
                                colors: [Colors.blue, Colors.red])))),
                Card(
                    elevation: 2,
                    shadowColor: Colors.blue.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Colors.black.withOpacity(0.1), width: 2)),
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: RadialGradient(
                                colors: [Colors.blue, Colors.red])))),
                Card(
                    elevation: 2,
                    shadowColor: Colors.blue.withOpacity(0.6),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Colors.black.withOpacity(0.1), width: 2)),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: RadialGradient(
                              colors: [Colors.blue, Colors.red])),
                    ))
              ]),
            ),
          )
        ]);
  }
}

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
  }

  UserModel getUser() {
    return this.loggedInUser;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //Media Device data config

    Map<int, Map<String, dynamic>> _pages = {
      0: {
        'title': 'Home',
        'widget': LandingPage(
          loaded: _isLoaded,
          user: loggedInUser,
        )
      },
      1: {
        'title': 'Profile',
        'widget': ProfilePage(
          user: loggedInUser,
        )
      },
      2: {'title': 'Control Dashboard', 'widget': ControlPage()},
      3: {'title': 'Monitoring Dashboard', 'widget': MonitorPage()}
    };

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Container(
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
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                  ), //ImageIcon(Svg('assets/images/icons/person.svg',),ize: 30),
                  label: 'Settings'),
              BottomNavigationBarItem(
                  icon: ImageIcon(Svg('assets/images/icons/control.svg')),
                  label: "Control"),
              BottomNavigationBarItem(
                  icon: ImageIcon(Svg('assets/images/icons/monitor.svg')),
                  label: 'Monitor'),
            ],
          )),
    );
  }
}
