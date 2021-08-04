import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("My App"),
      ),
      body: MyWidget(),
    ),
  ));
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

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

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: newsData.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(newsData[index]['title']),
          subtitle: Text(newsData[index]['subTitle']),
          leading: Container(
            height: 50,
            width: 50,
            child: Center(
              child: Text(newsData[index]['title'].substring(0, 2)),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){},
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );

  }
}
