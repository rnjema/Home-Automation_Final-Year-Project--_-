import 'package:flutter/material.dart';
import 'package:shautom/constants.dart';
import 'package:shautom/views/containers.dart';
import 'package:shautom/views/form_fields.dart';
import 'package:shautom/views/components/logo.dart';

class RegistrationStepper extends StatelessWidget {
  RegistrationStepper(
      {Key? key,
      required this.index,
      required this.stepTapped,
      required this.stepCancelled,
      required this.stepContinued})
      : super(key: key);

  final int index;
  final Function(int) stepTapped;
  final VoidCallback stepCancelled;
  final VoidCallback stepContinued;

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
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    //alignment: Alignment.center,
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
                                    image: AssetImage(
                                        'assets/images/icons/back.png')),
                              ),
                              Text(
                                "Back",
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFFC0B01D)),
                              )
                            ]),
                            onTap: () => Navigator.pop(context),
                          )),
                      Stepper(
                          currentStep: index,
                          type: StepperType.vertical,
                          onStepTapped: (val) => stepTapped(val),
                          onStepCancel: stepCancelled,
                          onStepContinue: stepContinued,
                          controlsBuilder: (BuildContext context,
                                  {VoidCallback? onStepContinue,
                                  VoidCallback? onStepCancel}) =>
                              Row(
                                children: <Widget>[
                                  TextButton(
                                      onPressed: onStepContinue,
                                      child: Text('Next', style: kStepperNext)),
                                  TextButton(
                                      onPressed: onStepCancel,
                                      child: Text(
                                        'Back',
                                        style: kStepperBack,
                                      ))
                                ],
                              ),
                          steps: <Step>[
                            Step(
                                isActive: index == 0,
                                content: Text("This is it"),
                                title: Text('Personal Details',
                                    style: kStepperTitle)),
                            Step(
                                isActive: index == 1,
                                content: Text("This is it again!"),
                                title: Text(
                                  'Contact Details',
                                  style: kStepperTitle,
                                ))
                          ])
                    ]))));
  }
}

                
                    
                         
      


/*
Column(
                        children: [
                          ListView.separated(
                              //reverse: true,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: registrationFields.length,
                              separatorBuilder:
                                  (BuildContext context, int index) => SizedBox(
                                        height: size.height * 0.02,
                                      ),
                              itemBuilder: (BuildContext context, int index) {
                                return TextFieldContainer(
                                    child: TextFormField(
                                  obscureText: registrationFields[index].hidden,
                                  decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    //labelText: RegistrationFields[index].hintText,
                                    hintText:
                                        registrationFields[index].hintText,
                                    icon: registrationFields[index].icon,
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

 */