import 'package:adf2021/JohnJack/JohnJack.dart';
import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key}) : super(key: key);

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {

  var initialValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 40,
      child: (initialValue==0) ? OutlinedButton(
        // style: OutlinedButton.styleFrom(backgroundColor: Colors.blueGrey[200]),
          onPressed: (){
            setState(() {
              initialValue++;
            });
          },
          child: Text("ADD", style: TextStyle(color: Colors.black, ),),

      ) : Container(
        height: 40,
        width: 140,
        // color: Colors.blueGrey[200],
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(Radius.circular(3)),
        ),
        child: Row(
          children: [
            TextButton(
              onPressed: (){
                setState(() {
                  if(initialValue<0){
                    initialValue = 0;
                  }else{
                    initialValue--;
                  }
                });
              },
              child: Container(
                height: 50,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text("-", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),],
                ),
              ),
            ),
            Text(initialValue.toString()),
            TextButton(
              onPressed: (){
                setState(() {
                  initialValue++;
                });
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text("+", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),),],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
