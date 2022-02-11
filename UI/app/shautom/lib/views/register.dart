import 'package:flutter/material.dart';
import 'package:shautom/views/components/logo.dart';
import 'package:shautom/views/containers.dart';
import 'package:shautom/views/navbar_container.dart';
import 'package:shautom/views/registration_fields.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NavBarContainer(
        child: Container(
      height: size.height,
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(child: LogoWidget()),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: formItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TextFieldContainer(
                        child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: formItems[index].hintText,
                        hintText: formItems[index].hintText,
                        icon: formItems[index].icon,
                      ),
                    ));
                  }),
            ),
          ]),
    ));
  }
}
