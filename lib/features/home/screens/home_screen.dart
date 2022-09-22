import 'package:aroundix_task/features/home/screens/all_products_screen.dart';
import 'package:aroundix_task/providers/productsProvider.dart';
import 'package:aroundix_task/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;
    return Scaffold(
      body: Center(
        child: Text(user.email),
      ),
    );
  }
}
