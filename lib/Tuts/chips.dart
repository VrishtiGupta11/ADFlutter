import 'package:flutter/material.dart';

class ChipWidgetPage extends StatelessWidget {
  const ChipWidgetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chip tutorial'),
      ),
      body: Center(
        child: Chip(
          label: Text('John Watson'),
          avatar: CircleAvatar(
            backgroundColor: Colors.white,
            child: Text('JW'),
          ),
        ),
      ),
    );
  }
}
