import 'dart:async';
import 'package:mobileprg/WelcomePage.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(LoginApp());
}
String? username= '';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: <String,WidgetBuilder>{
        '/AdminPage': (BuildContext context)=> WelcomePage(username: username,),
        '/LoginPage': (BuildContext context)=> LoginPage(),
      },
    );
  }
}
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();

  String message = '';

  Future<List?> login() async {
    final point = "http://192.168.1.104:8080/flutter/indexregister.php";
    final Uri url = Uri.parse(point);

    var response = await http.post(url, body:{
      "username":user.text,
      "password":pass.text,

    });

    var datauser = json.decode(response.body);
    if(datauser.length == 0){
      setState(() {
        message="Login Fail";
      });
    }else{

      Navigator.pushReplacementNamed(context, '/WelcomePage');

      /*if(datauser[0]['level']== 'admin'){
        Navigator.pushReplacementNamed(context, '/AdminPage');
      }else if(datauser[0]['level']== 'member'){
        Navigator.pushReplacementNamed(context, '/MemberPage');
      }*/

      setState(() {
        username= datauser[0]['username'];
      });
    }
    return datauser;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Login'),
        foregroundColor: Colors.black87,
        backgroundColor: Colors.deepPurpleAccent,),
        body: Column(
          children: <Widget>[
            TextField(
              controller: user,
              decoration: InputDecoration(
                icon: Icon(Icons.mail_outline),
                hintText: 'Username',
              ),
            ),
            TextField(
              controller: pass,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(Icons.vpn_key),
                hintText: 'Password',
              ),
            ),
            RaisedButton(
              color: Colors.deepPurpleAccent,
              child: Text('Enter'),
              onPressed: (){
                login();
                Navigator.pop(context);
              },
            ),
            Text(message,style: TextStyle(fontSize: 20.0,
                color: Colors.red),)
          ],
        )

    );
  }
}