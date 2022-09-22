import 'package:aroundix_task/constants/global_variables.dart';
import 'package:aroundix_task/features/auth/screens/login_screen.dart';
import 'package:aroundix_task/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        fullName: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35),
          width: double.infinity,
          child: Column(children: [
            SizedBox(
              height: 20,
            ),
            const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 140,
            ),
            const SizedBox(
              height: 50,
            ),
            Form(
                key: _signUpFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(hintText: "full name"),
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(hintText: "email"),
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(hintText: "password"),
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'enter your password';
                        }
                        return null;
                      },
                    ),
                  ],
                )),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: const Text(
                  "forgot password? ",
                  style: TextStyle(
                      color: GlobalVariables.secondaryColor, fontSize: 12),
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Container(
              width: 260,
              decoration: BoxDecoration(
                color: GlobalVariables.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(7)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () async {
                  if (_signUpFormKey.currentState!.validate()) {
                    signUpUser();
                  }
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: Container(
                  child: const Text.rich(
                TextSpan(
                  text: 'or ',
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Login',
                        style:
                            TextStyle(color: GlobalVariables.secondaryColor)),
                  ],
                ),
              )),
            )
          ]),
        ),
      )),
    );
  }
}
