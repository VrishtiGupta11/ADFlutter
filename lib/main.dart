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
      "title": "India",
      "subTitle": "All headlines of India",
      "imageUrl": "https://images.unsplash.com/photo-1597058712635-3182d1eacc1e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW5kaWElMjBmbGFnfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
    },
    {
      "title": "United Kingdom",
      "subTitle": "All headlines of UK",
      "imageUrl": "https://images.unsplash.com/photo-1494419470281-65c2b001a42b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHVuaXRlZCUyMGtpbmdkb20lMjBmbGFnfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
    },
    {
      "title": "America",
      "subTitle": "All headlines of USA",
      "imageUrl": "https://images.unsplash.com/photo-1581024013650-28295fd60327?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YW1lcmljYW4lMjBmbGFnfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
    },
    {
      "title": "Argentina",
      "subTitle": "All headlines of Argentina",
      "imageUrl": "https://images.unsplash.com/photo-1592593640541-9363711fdb2c?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YXJnZW50aW5hJTIwZmxhZ3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
    },
    {
      "title": "South Africa",
      "subTitle": "All headlines of South Africa",
      "imageUrl": "https://images.unsplash.com/photo-1613244600331-ac72a1ee5256?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c291dGglMjBhZnJpY2ElMjBmbGFnfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
    },
    {
      "title": "Spain",
      "subTitle": "All headlines of Spain",
      "imageUrl": "https://images.unsplash.com/photo-1566232392379-afd9298e6a46?ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8c3BhaW4lMjBmbGFnfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
    },
    {
      "title": "France",
      "subTitle": "All headlines of France",
      "imageUrl": "https://images.unsplash.com/photo-1551866442-64e75e911c23?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8ZnJhbmNlJTIwZmxhZ3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
    },
    {
      "title": "Italy",
      "subTitle": "All headlines of Italy",
      "imageUrl": "https://images.unsplash.com/photo-1561456621-5058b4e08cac?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aXRhbHklMjBmbGFnfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
    }
  ];

  showWidgets(){
    var tiles = <Widget>[];
    newsData.forEach((element) {
      tiles.add(ListTile(
        contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        title: Text(element['title']),
        subtitle: Text(element['subTitle']),
        leading: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(element['imageUrl']),
              fit: BoxFit.cover,
            )
          ),
          // child: Center(
          //   child: Text(element['title'].substring(0,2)),
          // ),
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
      padding: EdgeInsets.all(5),
      children: showWidgets(),
    );
  }
}
