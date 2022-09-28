import 'dart:convert';

import 'package:aroundix_task/constants/error_handling.dart';

import 'package:aroundix_task/models/user.dart';
import 'package:aroundix_task/providers/user_provider.dart';
import 'package:aroundix_task/shared/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  // sign up user
  void signUpUser(
      {required BuildContext context,
      required String fullName,
      required String email,
      required String password}) async {
    try {
      User user = User(
          id: '',
          fullName: fullName,
          email: email,
          password: password,
          token: '',
          products: []);

      http.Response res = await http.post(
        Uri.parse(
            'https://aroundix-flutter-test-backend.herokuapp.com/API/register-user'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            //showSnackBar(context, 'account created!');
          });
    } catch (err) {
      //showSnackBar(context, err.toString());
    }
  }

  // sign in user
  Future<String> signInUser(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      http.Response res = await http.post(
        Uri.parse(
            'https://aroundix-flutter-test-backend.herokuapp.com/API/login-user'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () async {
            //SharedPreferences.setMockInitialValues({});

            Map result = {
              'id': (jsonDecode(res.body)['user'])['_id'],
              'fullName': (jsonDecode(res.body)['user'])['fullName'],
              'email': (jsonDecode(res.body)['user'])['email'],
              'password': (jsonDecode(res.body)['user'])['password'],
              'token': (jsonDecode(res.body)['token']),
              'products': (jsonDecode(res.body)['user'])['products'],
            };

            SharedPreferences prefs = await SharedPreferences.getInstance();

            // ignore: use_build_context_synchronously
            Provider.of<UserProvider>(context, listen: false)
                .setUser(jsonEncode(result));
            // print(Provider.of<UserProvider>(context, listen: false)
            //     .currentUser
            //     .token);

            await prefs.setString(
                'x-auth-token',
                Provider.of<UserProvider>(context, listen: false)
                    .currentUser
                    .token);

            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const BottomBar()),
                (route) => false);
          });
      return res.statusCode.toString();
    } catch (err) {
      //showSnackBar(context, err.toString());
      return err.toString();
    }
  }

  // get user data

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      } else {
        http.Response res = await http.get(
          Uri.parse(
              'https://aroundix-flutter-test-backend.herokuapp.com/API/get-user-info'),
          headers: <String, String>{
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        );

        Map result = {
          'id': (jsonDecode(res.body)['user'])['_id'],
          'fullName': (jsonDecode(res.body)['user'])['fullName'],
          'email': (jsonDecode(res.body)['user'])['email'],
          'password': (jsonDecode(res.body)['user'])['password'],
          'token': token,
          'products': (jsonDecode(res.body)['user'])['products'],
        };

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(jsonEncode(result));
      }
    } catch (err) {
      //showSnackBar(context, err.toString());
    }
  }

  void logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('x-auth-token', '');
  }
}
