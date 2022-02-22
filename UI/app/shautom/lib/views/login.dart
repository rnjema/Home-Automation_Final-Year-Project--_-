import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';
import 'package:shautom/views/containers.dart';
import 'package:shautom/views/form_fields.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:shautom/views/register.dart';

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
                        child: Image(
                            image: AssetImage('assets/images/icons/back.png')),
                      ),
                      Text(
                        "Back",
                        style:
                            TextStyle(fontSize: 18, color: Color(0xFFC0B01D)),
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
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          SizedBox(height: size.height * 0.05),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return TextFieldContainer(
                                        child: TextFormField(
                                      controller: _controllers[index],
                                      obscureText: loginFields[index].hidden,
                                      decoration: new InputDecoration(
                                        border: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        //labelText: LoginFields[index].hintText,
                                        hintText: loginFields[index].hintText,
                                        icon: loginFields[index].icon,
                                      ),
                                    ));
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                        padding: EdgeInsets.only(bottom: size.height * 0.01),
                        width: size.width * 0.6,
                        child: ElevatedButton(
                          onPressed: () => print("Button pressed"),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF3F51B5),
                            shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          child: Text("Log In",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontSize: 16,
                              )),
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
