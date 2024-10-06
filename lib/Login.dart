import 'package:ecofriend/Homescreen.dart';
import 'package:ecofriend/Objects/JSONData.dart';
import 'package:ecofriend/Signup.dart';
import 'package:ecofriend/functions/Authenticate.dart';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hive/hive.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormBuilderState>();
  var focusNodeEmail = FocusNode();
  var focusNodePassword = FocusNode();
  bool isFocusedEmail = false;
  bool isFocusedPassword = false;
  bool _isObscured = true;
  late JsonStorage _jsonStorage;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    focusNodeEmail.addListener(() {
      setState(() {
        isFocusedEmail = focusNodeEmail.hasFocus;
      });
    });
    focusNodePassword.addListener(() {
      setState(() {
        isFocusedPassword = focusNodePassword.hasFocus;
      });
    });
    final box = Hive.box('UserInfo');
    _jsonStorage = JsonStorage(box);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDDE255),
      body: Container(
        color: Color(0xFFDDE255),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: FormBuilder(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: ListView(
              children: [
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    "Let's Sign You In",
                    style: TextStyle(
                        color: Color(0xFF1A2F0E),
                        fontSize: 36,
                        fontFamily: 'CenturyGothic',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FadeInDown(
                  child: Text(
                    "Welcome Back",
                    style: TextStyle(
                        fontSize: 27,
                        fontFamily: 'CenturyGothic',
                        color: Color(0xFF272A30)),
                  ),
                ),
                FadeInDown(
                  child: Text(
                    "You've Been Missed!",
                    style: TextStyle(
                        fontSize: 27,
                        fontFamily: 'CenturyGothic',
                        color: Color(0xFF272A30)),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    '  Email',
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
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                          color:
                              isFocusedEmail ? Colors.white : Color(0xFFF1F0F5),
                          border:
                              Border.all(width: 1, color: Color(0xFFD2D2D4)),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            if (isFocusedEmail)
                              BoxShadow(
                                  color: Color(0xFF1A2F0E).withOpacity(.3),
                                  blurRadius: 4.0,
                                  spreadRadius: 0.5)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: FormBuilderTextField(
                          style: TextStyle(fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Your Email'),
                          focusNode: focusNodeEmail,
                          name: 'email',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.email(
                                errorText: "Invalid Email")
                          ]),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    '  Password',
                    style: TextStyle(
                      color: Color(0xFF272A30),
                      fontSize: 16,
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
                        color: isFocusedPassword
                            ? Colors.white
                            : Color(0xFFF1F0F5),
                        border: Border.all(width: 1, color: Color(0xFFD2D2D4)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          if (isFocusedPassword)
                            BoxShadow(
                              color: Color(0xFF1A2F0E).withOpacity(.3),
                              blurRadius: 4.0,
                              spreadRadius: 0.5,
                            ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 6.0),
                              child: FormBuilderTextField(
                                name: 'pass',
                                style: TextStyle(fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Your Password',
                                ),
                                obscureText:
                                    _isObscured, // Use the _isObscured variable
                                focusNode: focusNodePassword,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.hasUppercaseChars(
                                      atLeast: 1,
                                      errorText: "Invalid Password"),
                                ]),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isObscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscured = !_isObscured;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
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
                              onPressed: () async {
                                // if (_formKey.currentState!.validate()) {
                                //   print("validated");
                                //   Map<String, dynamic>? result =
                                //       await authenticate(
                                //           _formKey.currentState, context);
                                //   _jsonStorage.storeJsonData(result!);
                                //   Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //           builder: (context) => HomeScreen()));
                                // } else {
                                //   print("not");
                                // }
                                Map<String, dynamic>? result =
                                    await authenticate(
                                        _formKey.currentState, context);
                                _jsonStorage.storeJsonData(result!);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              },
                              child: FadeInUp(
                                  from: 40,
                                  delay: const Duration(milliseconds: 700),
                                  duration: const Duration(milliseconds: 500),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(color: Color(0xFFDDE255)),
                                  )),
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  textStyle: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'CenturyGothic'),
                                  backgroundColor: Color(0xFF1A2F0E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 16)),
                            ),
                          )
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
                                'Don\'t have an account?',
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
                                        builder: (context) => Signup(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Color(0xFF1A2F0E),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ))
                            ])),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
