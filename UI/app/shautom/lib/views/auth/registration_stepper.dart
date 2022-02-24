import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import 'package:shautom/constants.dart';
import 'package:shautom/views/auth/form_fields.dart';

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
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
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
                                            child: Text('Next',
                                                style: kStepperNext)),
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
                                        TextFormField(
                                            controller: _firstName,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please provide first name!";
                                              } else {
                                                return null;
                                              }
                                            },
                                            textCapitalization:
                                                TextCapitalization.words,
                                            obscureText:
                                                registrationFields[0].hidden,
                                            decoration: new InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              //labelText: RegistrationFields[index].hintText,
                                              labelText: registrationFields[0]
                                                  .hintText,
                                              //icon: registrationFields[0].icon,
                                            )),
                                        SizedBox(height: size.height * 0.01),
                                        TextFormField(
                                            controller: _lastName,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please provide last name!";
                                              } else {
                                                return null;
                                              }
                                            },
                                            textCapitalization:
                                                TextCapitalization.words,
                                            obscureText:
                                                registrationFields[1].hidden,
                                            decoration: new InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              //labelText: RegistrationFields[index].hintText,
                                              labelText: registrationFields[1]
                                                  .hintText,
                                              //icon: registrationFields[1].icon,
                                            ))
                                      ]),
                                      title: Text('Personal Details',
                                          style: kStepperTitle)),
                                  Step(
                                      isActive: widget.index == 1,
                                      content: Column(children: [
                                        TextFormField(
                                            controller: _email,
                                            validator: validateEmail,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            obscureText: false,
                                            decoration: new InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              //labelText: RegistrationFields[index].hintText,
                                              labelText: registrationFields[2]
                                                  .hintText,
                                              //icon: registrationFields[2].icon,
                                            )),
                                        SizedBox(height: size.height * 0.01),
                                        IntlPhoneField(
                                            keyboardType: TextInputType.phone,
                                            initialCountryCode: 'MW',
                                            readOnly: false,
                                            controller: _phoneNumber,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please specify mobile number!";
                                              } else {
                                                return null;
                                              }
                                            },
                                            obscureText: false,
                                            decoration: new InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              //labelText: RegistrationFields[index].hintText,
                                              labelText: registrationFields[3]
                                                  .hintText,
                                              //icon: registrationFields[3].icon,
                                            ))
                                      ]),
                                      title: Text(
                                        'Contact Details',
                                        style: kStepperTitle,
                                      )),
                                  Step(
                                      isActive: widget.index == 2,
                                      title: Text(
                                        'Password Settings',
                                        style: TextStyle(
                                            textBaseline:
                                                TextBaseline.alphabetic),
                                      ),
                                      content: Column(children: [
                                        TextFormField(
                                            controller: _password,
                                            obscureText:
                                                registrationFields[4].hidden,
                                            decoration: new InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              //labelText: RegistrationFields[index].hintText,
                                              labelText: registrationFields[4]
                                                  .hintText,
                                              //icon: registrationFields[4].icon,
                                            )),
                                        SizedBox(height: size.height * 0.01),
                                        TextFormField(
                                            controller: _confirmPassword,
                                            obscureText:
                                                registrationFields[5].hidden,
                                            decoration: new InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              //labelText: RegistrationFields[index].hintText,
                                              labelText: registrationFields[5]
                                                  .hintText,
                                              //icon: registrationFields[5].icon,
                                            ))
                                      ])),
                                  Step(
                                      content: Container(
                                        child: Text('Registration complete'),
                                      ),
                                      title: Text('Register'))
                                ]),
                            ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    final firstName = _firstName.text.trim();
                                    final lastName = _lastName.text.trim();

                                    print("Welcome $firstName $lastName");
                                  }
                                },
                                child: Text('Register New User')),
                          ],
                        ),
                      )
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
                                    border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                    enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                    focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                    errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20)),
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