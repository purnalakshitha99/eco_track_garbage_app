import 'package:ecotrack/screen/User/firstPage.dart';
import 'package:ecotrack/style/button.dart';
import 'package:ecotrack/style/text.dart';
import 'package:flutter/material.dart';
class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 70,left: 20,right: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "asset/images/startImage.jpg",
              ),
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily:"Poppins-Bold"
                ),
              ),
              const SizedBox(height: 20,),
              const Text("simply dummy text of the printing and typesetting industry"
               "Lorem Ipsum has been the industry's standard dummy text ever",
               style: TextStyle(
                fontSize: 15,
                fontFamily: "Poppins-Bold",
                color: Color(0xff46A74A),
               ),
              ),
              const SizedBox(height: 60,),
              ElevatedButton(
                style: mainButtton,
                onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const FirstPage()));
                },
                child: const Text(
                  "Start here",
                  style: MainbuttonText,
                )
                )
            ],
          ),
        ),
      ),
    );
  }
}