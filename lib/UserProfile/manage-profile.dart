import 'package:flutter/material.dart';

class ManageProfilePage extends StatelessWidget {
  const ManageProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade100,
      ),
      body: Center(
        child: Dialog(),
      ),
    );
  }
}

class Dialog extends StatefulWidget {
  const Dialog({Key? key}) : super(key: key);

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<Dialog> {

  var selectedDate = DateTime.now();

 //  Text(username??"")
 // a= b??c

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101)
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          IconButton(
            icon: Icon(Icons.date_range, color: Colors.grey, size: 30,),
            onPressed: () {
              selectDate(context);
            },
          ),
          Text(selectedDate.toString()),
        ],
      )
    );
  }
}

