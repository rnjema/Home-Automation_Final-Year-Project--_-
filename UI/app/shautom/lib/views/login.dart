import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';
import 'package:shautom/views/navbar_container.dart';
import 'package:shautom/views/containers.dart';
import 'package:shautom/views/form_fields.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.01, vertical: size.height * 0.01),
              child: LogoWidget(
                heightFactor: 0.3,
                widthFactor: 0.4,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0),
              width: size.width * 0.8,
              height: size.height * 0.8,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: loginFields.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TextFieldContainer(
                        child: TextFormField(
                      obscureText: loginFields[index].hidden,
                      decoration: new InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        //labelText: loginFields[index].hintText,
                        hintText: loginFields[index].hintText,
                        icon: loginFields[index].icon,
                      ),
                    ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
