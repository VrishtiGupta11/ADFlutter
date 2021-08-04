import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("My App"),
        ),
      ),
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

  var newsData = <Map>[
    {
      "title": "Tech Crunch",
      "subTitle": "All headlines from techCrunch"
    },
    {
      "title": "Top Business",
      "subTitle": "All headlines from USA Business"
    },
    {
      "title": "WallStreet Journal",
      "subTitle": "All headlines from WallStreet"
    }
  ];

  showWidgets(){
    var tiles = [];
    newsData.forEach((element) {
      tiles.add(ListTile(
        title: Text(element['title']),
        subtitle: Text(element['subTitle']),
        leading: Container(
          height: 50,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle
          ),
          child: Center(
            child: Text(element['title'].substring(0,2)),
          ),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right
        ),
        onTap: (){},
      ));
    });
    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: showWidgets(),
    );
  }
}
