import 'package:flutter/material.dart';
import 'package:shautom/constants.dart';
import 'package:shautom/views/containers.dart';
import 'package:shautom/views/form_fields.dart';
import 'package:shautom/views/components/logo.dart';

class RegistrationStepper extends StatefulWidget {
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
  State<RegistrationStepper> createState() => _RegistrationStepperState();
}

class _RegistrationStepperState extends State<RegistrationStepper> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

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
                          currentStep: widget.index,
                          type: StepperType.vertical,
                          onStepTapped: (val) => widget.stepTapped(val),
                          onStepCancel: widget.stepCancelled,
                          onStepContinue: widget.stepContinued,
                          controlsBuilder: (BuildContext context,
                                  ControlsDetails details) =>
                              Row(
                                children: <Widget>[
                                  TextButton(
                                      onPressed: details.onStepContinue,
                                      child: Text('Next', style: kStepperNext)),
                                  TextButton(
                                      onPressed: details.onStepCancel,
                                      child: Text(
                                        'Back',
                                        style: kStepperBack,
                                      ))
                                ],
                              ),
                          steps: <Step>[
                            Step(
                                isActive: widget.index == 0,
                                content: Column(children: [
                                  TextFieldContainer(
                                    child: TextFormField(
                                        controller: _firstName,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText:
                                            registrationFields[0].hidden,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          //labelText: RegistrationFields[index].hintText,
                                          hintText:
                                              registrationFields[0].hintText,
                                          //icon: registrationFields[0].icon,
                                        )),
                                  ),
                                  TextFieldContainer(
                                    child: TextFormField(
                                        controller: _lastName,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        obscureText:
                                            registrationFields[1].hidden,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          //labelText: RegistrationFields[index].hintText,
                                          hintText:
                                              registrationFields[1].hintText,
                                          //icon: registrationFields[1].icon,
                                        )),
                                  )
                                ]),
                                title: Text('Personal Details',
                                    style: kStepperTitle)),
                            Step(
                                isActive: widget.index == 1,
                                content: Column(children: [
                                  TextFieldContainer(
                                    child: TextFormField(
                                        controller: _email,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        obscureText:
                                            registrationFields[0].hidden,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          //labelText: RegistrationFields[index].hintText,
                                          hintText:
                                              registrationFields[2].hintText,
                                          //icon: registrationFields[2].icon,
                                        )),
                                  ),
                                  TextFieldContainer(
                                    child: TextFormField(
                                        keyboardType: TextInputType.phone,
                                        controller: _phoneNumber,
                                        obscureText:
                                            registrationFields[1].hidden,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          //labelText: RegistrationFields[index].hintText,
                                          hintText:
                                              registrationFields[3].hintText,
                                          //icon: registrationFields[3].icon,
                                        )),
                                  )
                                ]),
                                title: Text(
                                  'Contact Details',
                                  style: kStepperTitle,
                                )),
                            Step(
                                isActive: widget.index == 2,
                                title: Text('_Password Settings'),
                                content: Column(children: [
                                  TextFieldContainer(
                                    child: TextFormField(
                                        controller: _password,
                                        obscureText:
                                            registrationFields[4].hidden,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          //labelText: RegistrationFields[index].hintText,
                                          hintText:
                                              registrationFields[4].hintText,
                                          //icon: registrationFields[4].icon,
                                        )),
                                  ),
                                  TextFieldContainer(
                                    child: TextFormField(
                                        controller: _confirmPassword,
                                        obscureText:
                                            registrationFields[5].hidden,
                                        decoration: new InputDecoration(
                                          border: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          //labelText: RegistrationFields[index].hintText,
                                          hintText:
                                              registrationFields[5].hintText,
                                          //icon: registrationFields[5].icon,
                                        )),
                                  )
                                ])),
                            Step(
                                content: Container(
                                  child: Text('Registration complete'),
                                ),
                                title: Text('Register'))
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