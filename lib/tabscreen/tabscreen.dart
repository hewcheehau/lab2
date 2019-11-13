import 'package:flutter/material.dart';
 

 
class TabScreen extends StatelessWidget {

  final String email;

  TabScreen ({Key key, this.email}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade800,
          title: Text('Main Screen for MyRecycle'),
        ),
        body: BodyWidget(email: email),
        ),
      
    );
  }
}

class BodyWidget extends StatefulWidget {
  final String email;

  BodyWidget({Key key,this.email}):super(key:key);
  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Welcome,${widget.email}'),
      ),
    );
  }
}