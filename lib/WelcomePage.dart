import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {

  WelcomePage({required this.username});
  final String? username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome"),),
      body: Column(
        children: <Widget>[
          Text('Hallo $username', style: TextStyle(fontSize: 20.0),),

          RaisedButton(
            child: Text("LogOUt"),
            onPressed: (){
              Navigator.pushReplacementNamed(context,'/LoginPage');
            },
          ),
        ],
      ),
    );
  }
}