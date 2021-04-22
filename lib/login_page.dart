import 'dart:convert';
//import 'dart:js';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aire_limpio/main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.blue,
                  Colors.lightBlueAccent,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter
            ),
          ),
          child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
            children: <Widget>[
              headerSection(),
              textSection(),
              buttonSection(),
            ],
          ),
        )
    );
  }

  signIn(String email, password) async{
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await http.get(Uri.parse('https://radiant-wildwood-90716.herokuapp.com/api/users/email/'+email));
    if(response.statusCode == 200) {
      jsonData = json.decode(response.body);
      print(jsonData['password']);
      print(jsonData['id']);
      print(jsonData['firstName']);
      print(jsonData['lastName']);
      print(jsonData['districtId']);
      print(jsonData['email']);
      if (password == jsonData['password']) {
        setState((){
          _isLoading = false;
          sharedPreferences.setString("id", jsonData['id']);
          sharedPreferences.setString("nombres", jsonData['firstName']);
          sharedPreferences.setString("apellido", jsonData['lastName']);
          sharedPreferences.setInt("distrito", jsonData['districtId']);
          sharedPreferences.setString("correo", jsonData['email']);
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => MainPage()), (Route<dynamic> route) => false);
        });
      }
      else {
        //print(jsonData['pass']);
      }
    }
    else{
      print(response.body);
    }
  }

  Container buttonSection(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: RaisedButton(
        onPressed: (){
          setState((){
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
        elevation: 0.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Text("Sign In", style: TextStyle(color: Colors.black)),
      ),
    );
  }

  Container textSection(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      //margin: EdgeInsets.only(top: 30.0),
      child: Column (
        children: <Widget>[
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white70,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
                hintText: "Email",
                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
                hintStyle: TextStyle(color: Colors.white70),
                icon: Icon(Icons.email, color: Colors.white70)
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(color: Colors.white70),
            decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white70),
                icon: Icon(Icons.lock, color: Colors.white70),
                border: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white70))
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();


  Container headerSection(){
    return Container(
      margin: EdgeInsets.only(top: 50.0),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Text("Aire Limpio", style: TextStyle(
          color: Colors.white,
          fontSize: 40.0,
          fontWeight: FontWeight.bold
      )
      ),
    );
  }

}