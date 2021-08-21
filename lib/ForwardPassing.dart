import 'package:flutter/material.dart';

class User{
  String? uid;
  String? name;

  User({this.uid, this.name});

  @override
  String toString() {
    return uid!+' '+name!+'\n';
  }
}

// Read the data on UI from Page1 and put it onto object user
// Pass Data from page1 into page2

// Forward and Backward Passing
// Use CASE

// Forward message on Whatsapp

// want to send Contact details
// Control goes from your page to contact page and details back to your page

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {

  var title = "Page1";
  TextEditingController controllerUID = TextEditingController();
  TextEditingController controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Enter Details of User"),
            SizedBox(height: 10,),
            TextField(
              controller: controllerUID,
            ),
            TextField(
              controller: controllerName,
            ),
            OutlinedButton(
              child: Text("SUBMIT"),
              onPressed: () async {
                var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => PageTwo(
                    user: User(
                        name: controllerName.text,
                        uid: controllerUID.text
                    )
                ),
                ));

                setState(() {
                  title = result.toString();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}


class PageTwo extends StatelessWidget {
  User? user;
  PageTwo({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page 2"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text(user.toString()),
            OutlinedButton(
              child: Text("Done"),
              onPressed: (){
                Navigator.pop(context, user);
              },
            ),
          ],
        ),
      ),
    );
  }
}