import 'package:ecotrack/screen/User/signInPage.dart';
import 'package:ecotrack/screen/User/signUpPage.dart';
import 'package:ecotrack/style/button.dart';
import 'package:ecotrack/style/text.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         body: Center(
           child: Container(
            margin: const EdgeInsets.all(15.0),
            width: 350,
            child: Column(
              children: [
                Image.asset(
                  "asset/images/appicon.png",
                  width: 350,
                  height: 100,
                ),
                const SizedBox(
                  height: 300,
                ),
                OutlinedButton(
                    style: secondMainButton,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contect) => const SignUpPage()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: OutlinedText,
                    )),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()));
                  },
                  style: mainButtton,
                  child: const Text(
                    "Sign In",
                    style: MainbuttonText,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
