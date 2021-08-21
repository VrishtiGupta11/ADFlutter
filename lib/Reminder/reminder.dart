import 'package:flutter/material.dart';

class Reminder extends StatefulWidget {
  const Reminder({Key? key}) : super(key: key);

  @override
  _ReminderState createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 35,),
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(17, 0, 17, 28),
                height: 30,
                width: 326,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 26, 26, 26),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(17, 0, 8, 16),
                    height: 75,
                    width: 155,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 26, 26, 26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(8, 0, 17, 16),
                    height: 75,
                    width: 155,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 26, 26, 26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(17, 0, 8, 16),
                    height: 75,
                    width: 155,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 26, 26, 26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(8, 0, 17, 16),
                    height: 75,
                    width: 155,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 26, 26, 26),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              )
            ],
          ),
          // Text("My Lists", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          // Row(
          //   children: [
          //     // ListView(
          //     //   children: [
          //     //     ListTile(
          //     //       title: Text("Reminders"),
          //     //       leading: Icon(Icons.view_list, color: Colors.orangeAccent,),
          //     //       trailing: Icon(Icons.keyboard_arrow_right),
          //     //     ),
          //     //     ListTile(
          //     //       title: Text("Reminders"),
          //     //       leading: Icon(Icons.view_list, color: Colors.yellowAccent,),
          //     //       trailing: Icon(Icons.keyboard_arrow_right),
          //     //     ),
          //     //   ],
          //     // )
          //   ],
          // ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Icon(Icons.add_circle, color: Colors.blue,),
                SizedBox(width: 10,),
                Text("New Reminder", style: TextStyle(color: Colors.blue),)
              ],
            ),
          ),
              label: '',
          ),
          BottomNavigationBarItem(icon: Container(
            padding: EdgeInsets.all(15),
            alignment: Alignment.bottomRight,
            child: Text("Add List", style: TextStyle(color: Colors.blue),),
          ),
              label: ''
          ),
        ],
        unselectedItemColor: Colors.blue,
        unselectedFontSize: 14,
      ),
    );
  }
}

