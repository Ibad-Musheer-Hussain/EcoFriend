import 'package:ecofriend/functions/Signup.dart';
import 'package:animate_do/animate_do.dart';
import 'package:ecofriend/Login.dart';
import 'package:ecofriend/Objects/Signupdata.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Signupcontinue extends StatefulWidget {
  final SignupData signupData;
  const Signupcontinue({super.key, required this.signupData});

  @override
  State<Signupcontinue> createState() => _SignupcontinueState();
}

class _SignupcontinueState extends State<Signupcontinue> {
  final _formKey = GlobalKey<FormBuilderState>();
  late String name;
  late String email;
  late String password;
  bool isFocusedAge = false;
  bool isFocusedLoc = false;
  bool isFocusedLang = false;
  var focusNodeAge = FocusNode();
  var focusNodeLoc = FocusNode();
  var focusNodeLang = FocusNode();
  String _selectedGender = 'Male';
  TextStyle commonTextStyle = TextStyle(
    fontSize: 24,
    fontFamily: 'CenturyGothic',
    color: Color(0xFF272A30),
  );

  @override
  void initState() {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    focusNodeAge.addListener(() {
      setState(() {
        isFocusedAge = focusNodeAge.hasFocus;
      });
    });
    focusNodeLoc.addListener(() {
      setState(() {
        isFocusedLoc = focusNodeLoc.hasFocus;
      });
    });
    focusNodeLang.addListener(() {
      setState(() {
        isFocusedLang = focusNodeLang.hasFocus;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SignupData signupData = widget.signupData;
    return Scaffold(
      backgroundColor: Color(0xFFDDE255),
      body: Container(
        color: Color(0xFFDDE255),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: FormBuilder(
            key: _formKey,
            child: ListView(
              children: [
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    "Almost Done!",
                    style: TextStyle(
                        color: Color(0xFF1A2F0E),
                        fontSize: 36,
                        fontFamily: 'CenturyGothic',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                FadeInDown(
                  child: Text(
                    "Personalize Account",
                    style: commonTextStyle,
                  ),
                ),
                FadeInDown(
                  child: Text(
                    "Just One More Step",
                    style: commonTextStyle,
                  ),
                ),
                SizedBox(height: 60),
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    '  Gender',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF272A30),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FadeInDown(
                      from: 40,
                      delay: const Duration(milliseconds: 700),
                      duration: const Duration(milliseconds: 500),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'Male',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                            activeColor: const Color(0xFF272A30),
                          ),
                          const Text(
                            'Male',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF272A30),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FadeInDown(
                      from: 40,
                      delay: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 500),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'Female',
                            groupValue: _selectedGender,
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value!;
                              });
                            },
                            activeColor: const Color(0xFF272A30),
                          ),
                          const Text(
                            'Female',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF272A30),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    '  Age',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF272A30),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 0.8),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: .3),
                      decoration: BoxDecoration(
                        color: isFocusedAge ? Colors.white : Color(0xFFF1F0F5),
                        border: Border.all(width: 1, color: Color(0xFFD2D2D4)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          if (isFocusedAge)
                            BoxShadow(
                              color: Color(0xFF1A2F0E).withOpacity(.3),
                              blurRadius: 4.0,
                              spreadRadius: 0.5,
                            )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: FormBuilderTextField(
                          name: "age",
                          style: TextStyle(fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Your Age',
                          ),
                          focusNode: focusNodeAge,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "Age cannot be empty"),
                            FormBuilderValidators.min(12,
                                errorText:
                                    "You cannot be less than 12 years of age")
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    '  Location',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF272A30),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 0.8),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: .3),
                      decoration: BoxDecoration(
                        color: isFocusedLoc ? Colors.white : Color(0xFFF1F0F5),
                        border: Border.all(width: 1, color: Color(0xFFD2D2D4)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          if (isFocusedLoc)
                            BoxShadow(
                              color: Color(0xFF1A2F0E).withOpacity(.3),
                              blurRadius: 4.0,
                              spreadRadius: 0.5,
                            )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: FormBuilderTextField(
                          name: 'location',
                          style: TextStyle(fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Your Location',
                          ),
                          focusNode: focusNodeLoc,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "Location cannot be empty"),
                            FormBuilderValidators.minLength(3,
                                errorText:
                                    "Location cannot be less than 3 characters")
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    '  Language',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF272A30),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 0.8),
                      padding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: .3),
                      decoration: BoxDecoration(
                        color: isFocusedLang ? Colors.white : Color(0xFFF1F0F5),
                        border: Border.all(width: 1, color: Color(0xFFD2D2D4)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          if (isFocusedLang)
                            BoxShadow(
                              color: Color(0xFF1A2F0E).withOpacity(.3),
                              blurRadius: 4.0,
                              spreadRadius: 0.5,
                            )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: FormBuilderTextField(
                          name: "language",
                          style: TextStyle(fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Preferred Language',
                          ),
                          focusNode: focusNodeLang,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "Language cannot be empty"),
                            FormBuilderValidators.minLength(3,
                                errorText:
                                    "Language cannot be less than 3 characters")
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    FadeInUp(
                      from: 40,
                      delay: const Duration(milliseconds: 700),
                      duration: const Duration(milliseconds: 500),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState?.saveAndValidate() ??
                                    false) {
                                  Signup(
                                      signupData.name,
                                      signupData.email,
                                      signupData.password,
                                      _selectedGender,
                                      _formKey.currentState);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                } else {
                                  print("fk you");
                                }
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(color: Color(0xFFDDE255)),
                              ),
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                textStyle: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'CenturyGothic'),
                                backgroundColor: Color(0xFF1A2F0E),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    FadeInUp(
                      from: 40,
                      delay: const Duration(milliseconds: 700),
                      duration: const Duration(milliseconds: 500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already a member?',
                            style: TextStyle(
                              color: Color(0xFF272A30),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Login(),
                                ),
                              );
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Color(0xFF1A2F0E),
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
