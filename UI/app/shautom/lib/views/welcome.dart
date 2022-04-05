import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';
import 'package:shautom/views/auth/register.dart';
import 'package:shautom/views/auth/login.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        body: SafeArea(
      child: Container(
          width: double.infinity,
          height: size.height,
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: size.height * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  LogoWidget(),
                  Text(
                    "Welcome",
                    style: TextStyle(
                      color: Color(0xBD3F51B5),
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  RichText(
                      text: TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                                text: "miHome",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xBD3F51B5))),
                            TextSpan(
                                text:
                                    " is a companion app for SHAUTOM - an IoT-based smart home automation system that provides a platform for intelligent and efficient consumption of domestic utilities",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal))
                          ],
                          style: TextStyle(
                            color: Colors.grey,
                          )),
                      textAlign: TextAlign.center),
                  SizedBox(height: size.height * 0.065),
                  Column(
                    children: <Widget>[
                      MaterialButton(
                        color: Color(0xFF3F51B5),
                        minWidth: double.infinity,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(40)),
                        child: Text("Login",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            )),
                      ),
                      SizedBox(
                        height: size.height * 0.05,
                      ),
                      MaterialButton(
                        color: Color(0xBD3F51B5),
                        minWidth: double.infinity,
                        height: 50,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationPage()));
                        },
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(40)),
                        child: Text("Register",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 16,
                            )),
                      ),
                    ],
                  )
                ],
              )
            ],
          )),
    ));
  }
}
