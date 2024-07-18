import 'package:ecotrack/screen/User/firstPage.dart';
import 'package:ecotrack/screen/User/sellItems.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  final String? token;
  final Map<String, dynamic>? userDetails;

  const UserProfile({Key? key, required this.token, required this.userDetails}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dilsha Madushanka"),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstPage()));
              },
              icon: const Icon(Icons.login_outlined))
          )
        ],
      ),
      body:ListView(
        scrollDirection: Axis.vertical,
        children:  [
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit_attributes,color: Colors.blue,),
            title: const Text('Edit Profile'),
            subtitle: const Text("change youe personal details"),
            trailing: const Icon(Icons.menu),
            onTap: (){

            },
          ),
          const Divider(),
           ListTile(
            leading: const Icon(Icons.sell,color: Colors.green,),
            title: const Text('Sell'),
            subtitle: const Text("Sell Your Iteams"),
            trailing: const Icon(Icons.menu,),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => SellItems(token: widget.token, userDetails: widget.userDetails)));
            },
          ),
           const Divider(),
           ListTile(
            leading: const Icon(Icons.report,color: Colors.red,),
            title: const Text('Report'),
            subtitle: const Text("Check your selling details"),
            trailing: const Icon(Icons.menu),
            onTap: (){
            },
          ),
          const Divider(),
           ListTile(
            leading: const Icon(Icons.message,color: Colors.lime,),
            title: const Text('Complain'),
            subtitle: const Text("submit your complain "),
            trailing: const Icon(Icons.menu),
            onTap: (){
            },
          ),
         
        ],
      ) ,
    );
  }
}