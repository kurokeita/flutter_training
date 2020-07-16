import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../configs/Consts.dart' as Consts;
import '../components/BottomBar.dart';

class HeroWidget extends StatefulWidget {
  @override
  _HeroWidgetState createState() => _HeroWidgetState();
}

class _HeroWidgetState extends State<HeroWidget> {
  @override
  Widget build(BuildContext context) {
//    timeDilation = 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Widget'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Hero(
          tag: 'imageHero',
          child: GestureDetector(
            child: ClipOval(
              child: Image.asset(
                'assets/icons/icon.jpg',
                width: 100,
              ),

            ),
            onTap: () => Navigator.pushNamed(context, Consts.HERO2_ROUTE)
          ),
          transitionOnUserGestures: true,
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Widget 2'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: Hero(
            tag: 'imageHero',
            child: GestureDetector(
              child: ClipRRect(
                child: Image.asset(
                  'assets/icons/icon.jpg',
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
              onTap: () => Navigator.pushNamed(context, Consts.HERO_ROUTE)
            ),
            transitionOnUserGestures: true,
          ),
        )
      ),
      bottomNavigationBar: BottomBar(),
//      backgroundColor: Colors.black,
    );
  }
}

