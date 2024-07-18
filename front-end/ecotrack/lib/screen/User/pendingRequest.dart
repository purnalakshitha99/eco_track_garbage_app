import 'package:ecotrack/style/colors.dart';
import 'package:ecotrack/style/text.dart';
import 'package:flutter/material.dart';

class PendingRequestPage extends StatefulWidget {
  const PendingRequestPage({Key? key}) : super(key: key);

  @override
  State<PendingRequestPage> createState() => _PendingRequestPageState();
}

class _PendingRequestPageState extends State<PendingRequestPage> {
  var items = List.generate(100, (index) => 'item $index');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text("Pending",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Poppins-Bold"),),
            SizedBox(width: 5,),
            Text("Request",style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontFamily: "Poppins-Bold"),)
          ],
        ),
      ),
      body:  Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",style: TextStyle(fontWeight: FontWeight.bold,fontFamily: "Poppins-Bold"),),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    width: 350,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10,top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date: 2024/feb/02",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                              Text("Time: 12.32pm",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                              Text("Item: Food",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ElevatedButton(
                            onPressed: (){
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> LocationPage()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainButtonColor
                            ),
                            child: const Text(
                              "Track Pickup",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    width: 350,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10,top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date: 2024/feb/02",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                              Text("Time: 12.32pm",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                              Text("Item: Food",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ElevatedButton(
                            onPressed: (){
                               //Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationPage()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainButtonColor
                            ),
                            child: const Text(
                              "Track Pickup",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    width: 350,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10,top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Date: 2024/feb/02",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                              Text("Time: 12.32pm",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                              Text("Item: Food",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15))
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ElevatedButton(
                            onPressed: (){
                             // Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationPage()));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainButtonColor
                            ),
                            child: const Text(
                              "Track Pickup",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )
          )
        ],
      ),
    );
  }
}
