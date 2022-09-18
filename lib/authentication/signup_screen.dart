import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/splashScreen/splash_screen.dart';

import '../global/global.dart';
import '../widgets/progress_dialog.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm(){
    if(nameTextEditingController.text.length < 3){
      Fluttertoast.showToast(msg: "Name must be atleast 3 characters");
    }
    else{
      saveUserInfo();
    }
  }

  saveUserInfo() async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c){
          return ProgressDialog(message: "Processing, Please Wait...",);
        });

    final User? firebaseUser = (
    await firebaseAuth.createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(), 
        password: passwordTextEditingController.text.trim()
    ).catchError((msg){
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    })
    ).user;

    if(firebaseUser != null){
      Map userMap = {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim()
      };

      DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users");
      usersRef.child(firebaseUser.uid).set(userMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created");
      Navigator.push(context, MaterialPageRoute(builder: (c)=> SplashScreen()));
    }
    else{
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/logo.png"),
              ),
              const SizedBox(height: 10,),
              const Text(
                  "Register",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold
                ),
              ),
              TextField(
                controller: nameTextEditingController,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  color: Colors.grey
                ),
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    )
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 10
                  ),
                  labelStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
                  )
                ),
              ),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                    labelText: "Email",
                    hintText: "xyz@gmail.com",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                    ),
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                    )
                ),
              ),
              TextField(
                controller: phoneTextEditingController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                    labelText: "Phone",
                    hintText: "1234567890",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                    ),
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                    )
                ),
              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                    color: Colors.grey
                ),
                decoration: const InputDecoration(
                    labelText: "Password",
                    hintText: "***********",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.grey
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        )
                    ),
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10
                    ),
                    labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14
                    )
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    validateForm();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white54
                  ),
                  child: const Text(
                      "Create Account",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18
                    ),
                  )
              ),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (c)=> LoginScreen()));
              }, child: const Text(
                  "Already have an account? Login Here"
              ))
            ],
          ),
        ),
      ),
    );
  }
}
