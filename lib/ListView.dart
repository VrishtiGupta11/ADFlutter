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

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(12),
      children: [
        ListTile(
          title: Text('TextCrunch'),
          subtitle: Text('All headlines from techCrunch'),
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('TC'),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){},
    ),
        ListTile(
          title: Text('WallStreet Journal'),
          subtitle: Text('All headlines from WallStreet'),
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('WJ'),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){},
        )
      ],
    );
  }
}
