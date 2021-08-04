import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Scaffold(
      body: HomePage(),
    ),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map colorPalette = {
    'Purple': [Colors.purple, Colors.purpleAccent],
    'Indigo': [Colors.indigo, Colors.indigoAccent],
    'Blue': [Colors.blue, Colors.blueAccent],
    'Green': [Colors.green, Colors.greenAccent],
    'Yellow': [Colors.yellow, Colors.yellowAccent],
    'Orange': [Colors.orange, Colors.orangeAccent],
    'Red': [Colors.red, Colors.redAccent]
  };

  var backgroundColor;
  var appBackgroundColor;

  getWidgets(){
    var listWIdgets = <Widget>[];
    colorPalette.forEach((key, value) {
      listWIdgets.add(
        InkWell(
          child: Column(
            children: [Text(key, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),), Divider(color: Colors.white,),],
          ),
          hoverColor: appBackgroundColor,
          onTap: (){
            setState(() {
              backgroundColor = value[1];
              appBackgroundColor = value[0];
            });
          },
        ),
      );
    });
    return listWIdgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App"),
        centerTitle: true,
        backgroundColor: appBackgroundColor,
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          children: getWidgets(),
        ),
      ),
    );
  }
}
