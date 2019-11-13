import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tabscreen/tabscreen.dart';
import 'tabscreen/tabscreen2.dart';
import 'tabscreen/tabscreen3.dart';
import 'tabscreen/tabscreen4.dart';

class MainScreen extends StatefulWidget {
  final String email;

  const MainScreen({Key key, this.email}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> tabs;

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    tabs = [
      TabScreen(email: widget.email,),
      TabScreen2(),
      TabScreen3(),
      TabScreen4(),
    ];
  }

  String $pagetitle = "My Recycle";

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: tabs[currentTabIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTapped,
          currentIndex: currentTabIndex,
          backgroundColor: Colors.greenAccent[700],
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('Find')),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Calendar'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('Inform')),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Profile'),
            ),
          ]),
    );
  }
}
