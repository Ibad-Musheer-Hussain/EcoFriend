import 'package:animate_do/animate_do.dart';
import 'package:ecofriend/Login.dart';
import 'package:ecofriend/SignupContinue.dart';
import 'package:ecofriend/Objects/Signupdata.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isFocusedEmail = false;
  bool isFocusedName = false;
  bool isFocusedPassword = false;
  bool isFocusedRepass = false;
  var focusNodeEmail = FocusNode();
  var focusNodeName = FocusNode();
  var focusNodePassword = FocusNode();
  var focusNodeRepass = FocusNode();
  bool _isObscured = true;
  bool _isObscured2 = true;

  @override
  void initState() {
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    focusNodeRepass.addListener(() {
      setState(() {
        isFocusedRepass = focusNodeRepass.hasFocus;
      });
    });
    focusNodeName.addListener(() {
      setState(() {
        isFocusedName = focusNodeName.hasFocus;
      });
    });
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFDDE255),
      body: Container(
        color: Color(0xFFDDE255),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
                    "Join Us Today",
                    style: TextStyle(
                        color: Color(0xFF264414),
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
                    "Start Your EcoJourney",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'CenturyGothic',
                        color: Color(0xFF393E46)),
                  ),
                ),
                FadeInDown(
                  child: Text(
                    "Let's Grow Together",
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'CenturyGothic',
                        color: Color(0xFF393E46)),
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
                    '  Name',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF393E46),
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
                          color:
                              isFocusedName ? Colors.white : Color(0xFFF1F0F5),
                          border:
                              Border.all(width: 1, color: Color(0xFFD2D2D4)),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            if (isFocusedName)
                              BoxShadow(
                                  color: Color(0xFF1A2F0E).withOpacity(.3),
                                  blurRadius: 4.0,
                                  spreadRadius: 0.5)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          name: 'name',
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: "Name cannot be empty"),
                            FormBuilderValidators.minLength(3,
                                errorText:
                                    "Name cannot be less than 3 characters")
                          ]),
                          style: TextStyle(fontWeight: FontWeight.w400),
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: 'Your Name'),
                          focusNode: focusNodeName,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    '  Email',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF393E46),
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
                          validator: FormBuilderValidators.email(
                              errorText: "Invalid email"),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    '  Password',
                    style: TextStyle(
                      color: Color(0xFF393E46),
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
                                style: TextStyle(fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Enter Password',
                                ),
                                obscureText:
                                    _isObscured, // Use the _isObscured variable
                                focusNode: focusNodePassword, name: 'pass',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.minLength(6,
                                      errorText: "Password must be longer"),
                                  FormBuilderValidators.hasUppercaseChars(
                                      atLeast: 1,
                                      errorText:
                                          "Password must have an uppercase letter"),
                                  FormBuilderValidators.hasSpecialChars(
                                      atLeast: 1,
                                      errorText:
                                          "Password must have a special character")
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
                                _isObscured =
                                    !_isObscured; // Toggle the obscure text state
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                FadeInDown(
                  from: 40,
                  delay: const Duration(milliseconds: 700),
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    '  Re-type Password',
                    style: TextStyle(
                      color: Color(0xFF393E46),
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
                        color:
                            isFocusedRepass ? Colors.white : Color(0xFFF1F0F5),
                        border: Border.all(width: 1, color: Color(0xFFD2D2D4)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          if (isFocusedRepass)
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
                                style: TextStyle(fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Re-type Password',
                                ),
                                obscureText:
                                    _isObscured2, // Use the _isObscured variable
                                focusNode: focusNodeRepass, name: 'repass',
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              _isObscured2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscured2 =
                                    !_isObscured2; // Toggle the obscure text state
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
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
                              onPressed: () {
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  final password = _formKey
                                      .currentState?.fields['pass']?.value;
                                  final repass = _formKey
                                      .currentState?.fields['repass']?.value;

                                  // Check if they match
                                  if (password != repass) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          backgroundColor: Color(0xFF1A2F0E),
                                          content: Text(
                                            'Passwords do not match',
                                            style: TextStyle(
                                                color: Color(0xFFDDE255)),
                                          )),
                                    );
                                  } else {
                                    final name = _formKey
                                        .currentState?.fields['name']?.value;
                                    final email = _formKey
                                        .currentState?.fields['email']?.value;

                                    final signupData = SignupData(
                                      name: name!,
                                      email: email!,
                                      password: password!,
                                    );
                                    print("Passing Data");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Signupcontinue(
                                          signupData: signupData,
                                        ),
                                      ),
                                    );
                                  }
                                }
                              },
                              child: FadeInUp(
                                  from: 40,
                                  delay: const Duration(milliseconds: 700),
                                  duration: const Duration(milliseconds: 500),
                                  child: Text(
                                    'Continue',
                                    style: TextStyle(color: Color(0xFFDDE255)),
                                  )),
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  textStyle: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'CenturyGothic'),
                                  backgroundColor: Color(0xFF264414),
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
                                'Already a member?',
                                style: TextStyle(
                                  color: Color(0xFF264414),
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
                                      color: Color(0xFF264414),
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
