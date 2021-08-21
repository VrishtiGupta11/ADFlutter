import 'package:flutter/material.dart';

class User{
  int? number;
  User({this.number});
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  TextEditingController controllerNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiplication Table"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Enter Number for Multiplication Table"),
            TextField(
              controller: controllerNumber,
              keyboardType: TextInputType.number,
            ),
            OutlinedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    Page2(
                      user: User(
                        number: int.parse(controllerNumber.text),
                      ),
                    ),
                  ));
                },
                child: Text("Generate Table"),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {

  User? user;
  Page2({Key? key, this.user}) : super(key: key);

  multiplication(){
    List<Widget> table = [];
    for(int i=0; i<=10;i++){
      table.add(Text('${user!.number} X ${i} = ${user!.number! * i}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),));
      table.add(SizedBox(height: 10,));
    }
    return table;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Multiplication Table"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: multiplication(),
        ),
      ),
    );
  }
}