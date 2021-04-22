import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Perfil extends StatefulWidget {

  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  var jsonData = null;

  String id = '';
  String nombres = 'H';
  String apellido = '';
  int districtId = 0;
  String correo = '';
  String distrito = 's';

  //String url = "https://radiant-wildwood-90716.herokuapp.com/api/districts/"+ districtId.toString();

  SharedPreferences sharedPreferences;
  distritoBusqueda() async{

    var respuesta = await http.get(Uri.parse("https://radiant-wildwood-90716.herokuapp.com/api/districts/"+ districtId.toString()));
    if (respuesta.statusCode == 200) {
      setState(() {
        jsonData = json.decode(respuesta.body);
      });
      print(jsonData["name"]);
      distrito = jsonData["name"];
    }
  }

  datos() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("id") == null){
      //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
      print("aea");
    }
    else{
      setState(() {
        id = sharedPreferences.getString("id");
        nombres = sharedPreferences.getString("nombres");
        apellido = sharedPreferences.getString("apellido");
        districtId = sharedPreferences.getInt("distrito");
        correo = sharedPreferences.getString("correo");
      });
      print(id);
      print(nombres);
      print(apellido);
      print(districtId);
      print(correo);
      distritoBusqueda();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datos();
    //distritoBusqueda();
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(

        children: <Widget>[
          Center(
            child: Divider(height: 50, thickness: 0.2,),
          ),
          Center(
            child: CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.green,
              child: Text(
                  nombres[0],
                  style: TextStyle(fontSize: 65, color: Colors.white)
              ),
            ),

          ),
          Center(
            child: Divider(height: 50, thickness: 0.2,),
          ),
          Center(
            child: Text(
              "Nombre completo: "+nombres+" "+apellido,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: Divider(height: 20, thickness: 0.2,),
          ),
          Center(
            child: Text(
              "Correo: "+correo,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Center(
            child: Divider(height: 20, thickness: 0.2,),
          ),
          Center(
            child: Text(
              "Distrito: "+ distrito,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

