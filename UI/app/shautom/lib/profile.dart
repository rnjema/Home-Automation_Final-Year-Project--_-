import 'package:flutter/material.dart';
import 'package:shautom/views/home.dart';

import 'models/user.dart';

class ProfilePage extends StatelessWidget {
  //final GlobalKey<_HomePageState> homeKey = GlobalKey<_HomePageState>();
  UserModel? user;

  ProfilePage({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Column(
        children: [
          CircleAvatar(
              minRadius: size.width * 0.15,
              child: Text(
                user == null
                    ? "AZ"
                    : "${user?.firstName![0].toUpperCase()}${user?.lastName![0].toUpperCase()}",
                style: TextStyle(fontSize: 60),
              ))
        ],
      ),
    );
  }
}
