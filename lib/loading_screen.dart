// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:good_space/dashboard_page.dart';
import 'package:good_space/sign_in_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPreferences;
String? userToken;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getAuthToken();
    splash();
  }

  Future<void> getAuthToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 2));
    userToken = sharedPreferences.getString("token");
    if (userToken == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignInPage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const DashBoard()));
    }
  }

  bool showLogo = false;
  void splash() async {
    await Future.delayed(const Duration(seconds: 1));
    showLogo = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 159, 255),
      body: Center(
          child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Image(
                width: MediaQuery.of(context).size.width * 0.4,
                image: const AssetImage("Assets/Images/loading-1.gif")),
          ),
          if (showLogo)
            Positioned(
              bottom: 0,
              child: Image(
                  width: MediaQuery.of(context).size.width * 0.4,
                  image: const AssetImage("Assets/Images/goodspace.png")),
            )
        ],
      )),
    );
  }
}
