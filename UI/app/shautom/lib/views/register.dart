import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';
import 'package:shautom/views/containers.dart';
import 'package:shautom/views/form_fields.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              //alignment: Alignment.center,
              children: <Widget>[
                Container(
                    height: size.height * 0.2,
                    padding: EdgeInsets.symmetric(vertical: 0),
                    child: LogoWidget()),
                //SizedBox(height: size.height * 0.005),
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
                              itemCount: RegistrationFields.length,
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                        height: size.height * 0.02,
                                      ),
                              itemBuilder: (BuildContext context, int index) {
                                return TextFieldContainer(
                                    child: TextFormField(
                                  obscureText: RegistrationFields[index].hidden,
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    //labelText: RegistrationFields[index].hintText,
                                    hintText:
                                        RegistrationFields[index].hintText,
                                    icon: RegistrationFields[index].icon,
                                  ),
                                ));
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
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
                      child: Text("Register",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 16,
                          )),
                    )),
              ]),
        ),
      ),
    );
  }
}
