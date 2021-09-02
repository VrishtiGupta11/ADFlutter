import 'package:flutter/material.dart';

class Expand extends StatelessWidget {
  const Expand({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
        Column(
          children: [
            Container(
              color: Colors.cyan,
              height: 100,
              width: 100,
            ),
            Expanded(
                child: Container(
                  color: Colors.amber,
                  width: 100,
                ),
            ),
            // Container(
            //   color: Colors.amber,
            //   width: 100,
            // ),
          ],
        ),
        ]
      ),
    );
  }
}
