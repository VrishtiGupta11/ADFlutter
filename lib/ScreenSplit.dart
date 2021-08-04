import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: MyWidget(),
  ));
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  var appBarBackgroundColor;
  var appBackgroundColor = Colors.blueAccent;
  String src = 'https://images.unsplash.com/photo-1528493695782-15c16f2c42f9?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8YmVhdXRpZnVsfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60';

  Map listOfFriends = {
    'Samta': ['Violet', Colors.purple, Colors.purpleAccent, 'https://images.unsplash.com/photo-1528758054211-22aa4c5300db?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dmlvbGV0fGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'],
    'Priyanka': ['Indigo', Colors.indigo, Colors.indigoAccent, 'https://images.unsplash.com/photo-1559255267-8f9c0b8df08f?ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8aW5kaWdvfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'],
    'Amanjot': ['Blue', Colors.blue, Colors.blueAccent, 'https://images.unsplash.com/photo-1520690214124-2405c5217036?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Ymx1ZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'],
    'Priya': ['Green', Colors.green, Colors.greenAccent, 'https://images.unsplash.com/photo-1589691962030-8d2b7f2a1ffe?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8Z3JlZW58ZW58MHx8MHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'],
    'Jack': ['Yellow', Colors.yellow, Colors.yellowAccent, 'https://images.unsplash.com/photo-1442528010304-834a5d4f3925?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHllbGxvd3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'],
    'Jinny': ['Orange', Colors.orange, Colors.orangeAccent, 'https://images.unsplash.com/photo-1442458017215-285b83f65851?ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8b3JhbmdlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'],
    'Joe': ['Red', Colors.red, Colors.redAccent, 'https://images.unsplash.com/photo-1530128118208-89f6ce02b37b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cmVkfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60']
  };

  getWidgets(){
    var listOfWidgets = <Widget>[];
    listOfFriends.forEach((key, value) {
      listOfWidgets.add(
        InkWell(
          hoverColor: appBackgroundColor,
          child: Row(
            children: [Text(key, style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),),
              Text('\n'),
              SizedBox(width: 20,),
              Text(value[0], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Divider(),
            ],
          ),

          onTap: (){
            setState(() {
              appBarBackgroundColor = value[1];
              appBackgroundColor = value[2];
              src = value[3];
            });
          },
        ),
      );
    });
    return listOfWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBackgroundColor,
      ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height/2,
            child: Column(
              children: getWidgets(),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height/2,
            color: appBackgroundColor,
            child: Column(
              children: <Widget>[
                Image.network(src, height: 100, width: 100, fit: BoxFit.contain,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
