import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_ecommerce/constant/color_constraint.dart';
import 'package:multi_ecommerce/data/users.dart';
import 'package:multi_ecommerce/goggle.dart';
import 'package:multi_ecommerce/model_class/sign%20In.dart';
import 'package:multi_ecommerce/services/auth_services.dart';
import 'package:multi_ecommerce/widgets/sub_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthServices _auth = AuthServices();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form( // Wrap in a form widget
            key: _formKey, // Assign form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sign Up", style: myStyle(30)),
                  ],
                ),
                Gap(30),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email Address',
                        suffixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        if (!GetUtils.isEmail(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Gap(30),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible, // Toggle visibility
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                Gap(30),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
                  color: Colors.blue,
                  onPressed: () async {
                    User? user = await _auth.signUpWithEmailAndPassword(
                        _emailController.text, _passwordController.text);
                    if (_formKey.currentState?.validate() ?? false) {
                      userData.add(
                        Register(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                      Get.toNamed("/sign_in");
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Sign Up",
                        style: myStyle(20,Colors.white),),
                    ],
                  ),
                ),
                Gap(30),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RegularText(text: 'Or sign up with'),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Gap(30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.lightGrey,
                      ),
                      child: Icon(
                        Icons.facebook,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: AppColors.lightGrey,
                      padding: EdgeInsets.all(10),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/icon/google.png'),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      color: AppColors.lightGrey,
                      padding: EdgeInsets.all(10),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage('assets/images/icon/phone.png'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(40),
                InkWell(
                  onTap: () {
                    Get.toNamed('/sign_in');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RegularText(text: 'Already have an account ?'),
                      Gap(10),
                      RegularText(text: 'Sign in'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
