import 'package:flutter/material.dart';

Route getAnimatedRoute(Widget page){
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {  // Child <= page
      var tween = Tween(begin: Offset(0, 1), end: Offset.zero);
      var curveTween = CurveTween(curve: Curves.ease);

      return SlideTransition(
        position: animation.drive(curveTween).drive(tween),
        child: child,
      );
    },
  );
}

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PageOne'),
      ),
      body: Center(
        child: TextButton(
            child: Text('Navigate to Page 2'),
            onPressed: (){},
          ),
      ),
    );
  }
}
