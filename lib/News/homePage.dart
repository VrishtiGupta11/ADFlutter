import 'dart:convert' as convert;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future fetchNews(idx) async{
    List urls = [
      'https://newsapi.org/v2/top-headlines?country=in&apiKey=5bd64f76020741b5b9abd6114877a79a',
      'https://newsapi.org/v2/top-headlines?country=gb&apiKey=5bd64f76020741b5b9abd6114877a79a',
      'https://newsapi.org/v2/top-headlines?country=nz&apiKey=5bd64f76020741b5b9abd6114877a79a'
    ];
    var response = await http.get(Uri.parse(urls[idx]));
    return response.body;
  }
  parseNews(response){
    // response.forEach((element){
      
      var mapAsData = convert.jsonDecode(response);
      List articles = mapAsData['articles'];
      List<Widget> tileWidgets = [];
      
      articles.forEach((element) {
        tileWidgets.add(ListTile(
          onTap: (){

          },
          title: Column(
            children: [
              Text(element['title']),
              SizedBox(height: 10,),
              element['urlToImage'] != null ? Image.network(element['urlToImage']) : Container(),
              SizedBox(height: 10,),
            ],
          ),
          subtitle: Column(
            children: [
              Text(element['publishedAt']),
              SizedBox(height: 10,),
              element['description'] != null ? Text(element['description']) : Container(),
            ],
          ),
        ));
        tileWidgets.add(Divider());
      });
    // });
    return ListView(
      padding: EdgeInsets.all(10),
      children: tileWidgets,
    );
  }

  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NEWS Book"),
        centerTitle: true,
        actions: [
          // IconButton(
          //   onPressed: (){
          //     Navigator.pushReplacementNamed(context, '/home');
          //   },
          //   icon: Icon(Icons.home),
          //   tooltip: 'Home Page',
          // ),
          IconButton(
              onPressed: (){
                // FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              },
              icon: Icon(Icons.logout),
              tooltip: "logout",
          ),
        ],
        backgroundColor: Colors.orange,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("india.png"),
                    ),
                ),
              ),
            label: "India",
          ),

          BottomNavigationBarItem(
            icon: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("united-kingdom.png"),
                ),
              ),
            ),
            label: "United Kingdom",
          ),

          BottomNavigationBarItem(
            icon: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("new-zealand.png"),
                  )
              ),
            ),
            label: "New Zealand",
          )
        ],
        onTap: (idx){
          setState(() {
            index = idx;
          });
        },
        currentIndex: index,
        selectedFontSize: 16,
        selectedItemColor: Colors.orange,

      ),
      body: FutureBuilder(
        future: fetchNews(index),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return parseNews(snapshot.data.toString());
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}