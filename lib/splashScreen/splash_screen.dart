import 'dart:async';
import 'package:flutter/material.dart';

import '../assistants/assistant_methods.dart';
import '../authentication/login_screen.dart';
import '../global/global.dart';
import '../mainScreens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  //const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimer(){
    firebaseAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null;

    Timer(const Duration(seconds: 3), () async{
      if(await firebaseAuth.currentUser != null){
        currentFirebaseUser = firebaseAuth.currentUser;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => MainScreen()
            )
        );
      }
      else{
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => LoginScreen()
            )
        );
      }
    });
  }


  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png',
              ),
              const SizedBox(height: 10,),
              const Text(
                  "Uber Clone App",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
