import 'package:aroundix_task/constants/global_variables.dart';
import 'package:aroundix_task/features/auth/screens/auth_screen.dart';
import 'package:aroundix_task/features/auth/services/auth_service.dart';
import 'package:aroundix_task/features/home/screens/home_screen.dart';
import 'package:aroundix_task/features/home/services/product_service.dart';
import 'package:aroundix_task/providers/productsProvider.dart';
import 'package:aroundix_task/providers/user_provider.dart';
import 'package:aroundix_task/shared/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Color(0xFF13054E), // status bar color
  ));
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
    ChangeNotifierProvider(create: (context) => ProductsProvider())
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  bool tokenExist = false;

  @override
  void initState() {
    super.initState();

    _getToken();

    authService.getUserData(
      context,
    );
  }

  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('x-auth-token') == null) {
      prefs.setString('x-auth-token', '');
    } else {
      setState(() {
        tokenExist = prefs.getString('x-auth-token')!.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        appBarTheme: const AppBarTheme(
            elevation: 0, iconTheme: IconThemeData(color: Colors.black)),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        primarySwatch: Colors.blue,
      ),
      home: Builder(builder: (BuildContext context) {
        return tokenExist ? const BottomBar() : const AuthScreen();
      }),
    );
  }
}
