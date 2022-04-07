import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shautom/control_widget.dart';

class ControlPage extends StatefulWidget {
  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  late DatabaseReference _controlRef;
  late Stream<DatabaseEvent> _controlStream;

  /// Initializes Firebase realtime database configuration & state
  Future<void> initialize() async {
    _controlRef = FirebaseDatabase.instance
        .ref("Shautom/User/2vtcqvRNBVUPi0XtnxbUJRAy9GE2/appliance_control");
    _controlStream = _controlRef.onValue.asBroadcastStream();
    _controlStream.listen((event) {
      print(event.snapshot.value);
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(top: 15),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 10),
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return ControlWidget(
                applianceName: "Switch ${index + 1}", dbReference: _controlRef);
          },
          itemCount: 4,
        ),
      ),
    );
  }
}
