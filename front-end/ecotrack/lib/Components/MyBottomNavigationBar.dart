import 'package:ecotrack/screen/User/disposalRequest.dart';
import 'package:ecotrack/screen/User/homePage.dart';
import 'package:ecotrack/screen/User/requestPage.dart';
import 'package:ecotrack/screen/User/storePage.dart';
import 'package:ecotrack/screen/User/storePages.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
// ignore: camel_case_types
class MyBottomNavigationBar extends StatefulWidget {
  final String? token;
  final Map<String, dynamic>? userDetails;

  const MyBottomNavigationBar({Key? key, required this.token, required this.userDetails}) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBar();
}

class _MyBottomNavigationBar extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(token: widget.token, userDetails: widget.userDetails),
      DisposalRequest(token: widget.token, userDetails: widget.userDetails),
      StorePage(token: widget.token,userDetails: widget.userDetails,),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            onTabChange: (Index){
              setState(() {
                _selectedIndex = Index;
              });
            },
            padding: const EdgeInsets.all(16),
            tabs: const [
            GButton(
              icon:Icons.home,
              text: 'home',
            ),
            GButton(
              icon:Icons.recycling,
              text: 'request',
            ),
            // GButton(
            //   icon:Icons.location_on,
            //   text: 'location',
            // ),
            GButton(
              icon:Icons.store,
              text: 'store',
            ),
            
          ]),
        ),
      ),
    );
  }
}