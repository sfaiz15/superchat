import 'package:superchat/forms/loginform.dart';
import 'package:superchat/forms/registerform.dart';
import 'package:flutter/material.dart';
import 'package:superchat/pages/home.dart';
import 'package:superchat/style/style.dart';

class Authentication extends StatelessWidget {
  const Authentication({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = (screenWidth(context) < screenHeight(context) ? 0.95 : 0.5) *
        screenWidth(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Authentication Basics"),
      // ),
      body: Center(
        child: SizedBox(
          width: width,
          child: Card(
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RegisterForm(onTap: () => _sucessfulSignUp(context)),
              )),
        ),
      ),
    );
  }

  static void _sucessfulSignUp(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => HomePage()),
      ModalRoute.withName('/'),
    );
  }
}
