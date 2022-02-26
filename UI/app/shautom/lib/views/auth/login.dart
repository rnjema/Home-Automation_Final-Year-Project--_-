import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';
import 'package:shautom/views/auth/form_fields.dart';
import 'package:shautom/views/auth/register.dart';

import 'package:shautom/views/home.dart';

import 'package:shautom/main.dart' show MiHome;

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<int, TextEditingController> _controllers = {
    0: TextEditingController(),
    1: TextEditingController()
  };

  bool _isVisible = false;

  void _setVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  final List<String? Function(String?)> _validators = [
    validateEmail,
    validatePassword
  ];

  Future loginUser() async {
    // show dialog on fetching and verifying user credentials
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()));

    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          //handling nulls and castin
          email: _controllers[0]?.text.trim() as String,
          password: _controllers[1]?.text.trim() as String,
        );
        print('User loggen in!');
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } on FirebaseAuthException catch (e) {
        print(e);
      }

      MiHome().navigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: size.height,
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: GestureDetector(
                    child: Row(children: [
                      Container(
                          padding: const EdgeInsets.only(right: 8.0),
                          height: 16,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Color(0xFFC0B01D),
                          )),
                      Text(
                        "Back",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFC0B01D),
                            textBaseline: TextBaseline.alphabetic,
                            height: 2),
                      )
                    ]),
                    onTap: () => Navigator.pop(context),
                  )),
              SizedBox(height: size.height * 0.01),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  //alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                        height: size.height * 0.2,
                        padding: EdgeInsets.symmetric(vertical: 0),
                        child: LogoWidget()),
                    SizedBox(height: size.height * 0.01),
                    /*Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                    ),*/
                    Container(
                        width: size.width * 0.8,
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                ListView.separated(
                                    //reverse: true,
                                    shrinkWrap: true,
                                    physics: ScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    itemCount: loginFields.length,
                                    separatorBuilder: (BuildContext context,
                                            int index) =>
                                        SizedBox(height: size.height * 0.05),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return TextFormField(
                                        keyboardType: loginFields[index].kType,
                                        controller: _controllers[index],
                                        obscureText:
                                            index == 0 ? false : !_isVisible,
                                        //autovalidateMode: ,
                                        validator: _validators[index],
                                        decoration: new InputDecoration(
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.lightBlueAccent),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            //labelText: LoginFields[index].hintText,
                                            labelText:
                                                loginFields[index].hintText,
                                            icon: loginFields[index].icon,
                                            suffixIcon: index == 0
                                                ? null
                                                : IconButton(
                                                    icon: Icon(!_isVisible
                                                        ? Icons.visibility
                                                        : Icons.visibility_off),
                                                    onPressed: _setVisibility,
                                                  )),
                                      );
                                    }),
                                SizedBox(height: size.height * 0.05),
                                Container(
                                    padding: EdgeInsets.only(
                                        bottom: size.height * 0.01),
                                    width: size.width * 0.6,
                                    child: ElevatedButton(
                                      onPressed: loginUser,
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xFF3F51B5),
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(40))),
                                      child: Text("Log In",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Colors.white,
                                            fontSize: 16,
                                          )),
                                    )),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Divider(
                            thickness: 1.5,
                            indent: size.width * 0.05,
                            endIndent: (size.width * 0.05) / 2,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          child: Text(
                            "OR",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Poppins",
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.grey, shape: BoxShape.circle),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1.5,
                            indent: (size.width * 0.05) / 2,
                            endIndent: size.width * 0.05,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                        padding: EdgeInsets.only(bottom: size.height * 0.05),
                        width: size.width * 0.6,
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationPage())),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFFFFFFF),
                            shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          child: Text("Register New User",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                fontSize: 16,
                              )),
                        )),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}

/**
 () {
                                        
                                      } 
*/
