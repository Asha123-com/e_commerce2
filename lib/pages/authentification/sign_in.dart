import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:multi_ecommerce/constant/color_constraint.dart';
import 'package:multi_ecommerce/goggle.dart';
import 'package:multi_ecommerce/services/auth_services.dart';
import 'package:multi_ecommerce/widgets/sub_text.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthServices _auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Log In",style: myStyle(30),),
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
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Useremail',
                      suffixIcon: Icon(Icons.email_outlined,color: Colors.grey,),
                    ),
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
                  child: TextField(
                    obscureText: !_isPasswordVisible, // Toggle visibility
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Gap(30),
              MaterialButton(
                minWidth: double.infinity,
                height: 50,
                shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
                color:Colors.blue,
                onPressed: () async {
                  Get.offAllNamed('/home');
                  User? user = await _auth.signInWithEmailAndPassword(
                      _emailController.text, _passwordController.text);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sign In",
                      style: myStyle(20,Colors.white),),
                  ],
                ),
              ),
              Gap(30),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 1, // Adjust thickness if needed
                      color: Colors.grey,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: RegularText(text: 'Or sign up with'),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 1, // Adjust thickness if needed
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Gap(20),
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
                      size: 40, // Facebook icon size
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
                  Get.toNamed('/sign_up');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RegularText(text: 'Don\'t have an account ?'),
                    Gap(10),
                    RegularText(text: 'Sign Up'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
