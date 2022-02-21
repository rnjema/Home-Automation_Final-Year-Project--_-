import 'package:flutter/material.dart';
import 'package:shautom/views/registration_stepper.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  int _index = 0;

  void manageStepContinued() {
    if (_index != 3) {
      setState(() {
        _index++;
      });
    }
  }

  void manageStepCancelled() {
    if (_index > 0) {
      setState(() {
        _index--;
      });
    }
  }

  void manageStepTapped(int newIndex) {
    setState(() {
      _index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return RegistrationStepper(
        index: _index,
        stepCancelled: manageStepCancelled,
        stepTapped: manageStepTapped,
        stepContinued: manageStepContinued);
  }
}
