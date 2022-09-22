import 'package:aroundix_task/constants/global_variables.dart';
import 'package:aroundix_task/features/auth/screens/login_screen.dart';
import 'package:aroundix_task/features/auth/screens/register_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          width: double.infinity,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Flexible(flex: 2, child: Container()),
            const Image(
              image: AssetImage('assets/images/logo.png'),
              height: 140,
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              width: 220,
              child: Text(
                'Open An Account And showcase your products ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(255, 134, 134, 134)),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
              child: Text(
                'Join For Free',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 80,
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
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));
                },
                child: Text(
                  'create an account',
                  style: TextStyle(
                      color: GlobalVariables.secondaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Flexible(flex: 3, child: Container()),
          ]),
        ),
      ),
    );
  }
}
