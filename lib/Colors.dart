import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List color = [Colors.grey, Colors.brown, Colors.redAccent, Colors.blueAccent, Colors.deepPurple, Colors.greenAccent];

  var ind = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('This is My App'),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      backgroundColor: color[ind],
      body: Center(
        child: Column(
          children:[
            SizedBox(height: 100,),
            // Text(quotes[ind]),
            // SizedBox(height: 100,),
            // Divider(),
            InkWell(
              child: ElevatedButton(
                onPressed: (){
                  setState(() {
                    ind++;
                    ind = ind % color.length;
                  });
                },
                child: Text("Change Color",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

