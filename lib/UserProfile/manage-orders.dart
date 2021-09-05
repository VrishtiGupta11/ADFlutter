import 'package:flutter/material.dart';

class ManageOrdersPage extends StatelessWidget {
  const ManageOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade100,
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index){
              return Stack(
                children: [
                  Card(
                    child: Container(height: 170, width: 170, color: Colors.grey.shade200,),
                  ),
                  Positioned(
                    child: CircleAvatar(backgroundImage: AssetImage('hamburger.png'), radius: 22,),
                    left: 70,
                  ),
                ],
              );
            },
            childCount: 10,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
          ),
          // SliverGrid.count(
          //   crossAxisCount: 2,
          //   crossAxisSpacing: 10,
          //   mainAxisSpacing: 10,
          //   childAspectRatio: 1.5,
          //   children: [
          //     Container(
          //       height: 30,
          //       width: 30,
          //       color: Colors.redAccent,
          //     ),
          //     Container(
          //       height: 30,
          //       width: 30,
          //       color: Colors.deepPurple,
          //     ),
          //     Container(
          //       height: 30,
          //       width: 30,
          //       color: Colors.green,
          //     ),
          //     Container(
          //       height: 30,
          //       width: 30,
          //       color: Colors.grey,
          //     ),
          //     Container(
          //       height: 30,
          //       width: 30,
          //       color: Colors.grey,
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
