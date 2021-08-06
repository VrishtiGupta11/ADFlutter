import 'package:adf2021/WebViewPage.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


Future<String> fetchNews() async{
  String apiKey = "5bd64f76020741b5b9abd6114877a79a";
  String url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey="+apiKey;

  var response = await http.get(Uri.parse(url));
  return response.body; // JSON DATA
}

class NewsPage extends StatelessWidget {
  const NewsPage({Key? key}) : super(key: key);

  parseNews(String response, BuildContext context){
    var mapAsData = convert.jsonDecode(response);
    List articles = mapAsData['articles'];
    // return Text("${articles.length}");

    List<Widget> widgets = [];

    articles.forEach((element) {
      widgets.add(ListTile(
        // title: Text(element['title']),
        subtitle: Text(element['publishedAt']),
        title: Column(
          children: [
            element['urlToImage']!= null? Image.network(element['urlToImage']) : Container(),
            Text(element['title']),
          ],
        ),

        onTap: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => WebViewPage(url: element['url'],),
          ));
        },
      ));
      widgets.add(Divider());
    });
    return ListView(
      padding: EdgeInsets.all(10),
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchNews(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return parseNews(snapshot.data.toString(), context);
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );
  }
}


