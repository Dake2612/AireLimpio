import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Zonas extends StatefulWidget {
  @override
  _ZonasState createState() => _ZonasState();
}

class _ZonasState extends State<Zonas> {
  GoogleMapController _mapController;

  SharedPreferences sharedPreferences;

  int districtId = 0;

  datos() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("id") == null){
      //Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
      print("aea");
    }
    else{
      setState(() {
        districtId = sharedPreferences.getInt("distrito");
      });
      print(districtId);
      await zonaBus();
      await cargarVariables();
    }
  }

  List<dynamic> jsonData = [
    {"id": "h","name": "h","coordX": -12.04540163053219,"coordY":  -77.04709349309384, "districId": 0},
    {"id": "h","name": "h","coordX": -12.047192101826735, "coordY":  -77.0496721093279, "districId": 0},
    {"id": "h","name": "h","coordX": -12.048356771705961, "coordY":  -77.0447046587278, "districId": 0},
    {"id": "h","name": "h","coordX": -12.040381957406353, "coordY":  -77.04607891132686, "districId": 0},
    {"id": "h","name": "h","coordX": -12.039770579807888, "coordY":  -77.05038831231484, "districId": 0}
  ];

  //List<dynamic> jsonData = null;

  zonaBus() async{
    var response = await http.get(Uri.parse("https://radiant-wildwood-90716.herokuapp.com/api/zones/district/"+districtId.toString()));
    if(response.statusCode == 200){
      setState(() {
        jsonData = json.decode(response.body);
      });
      print(jsonData[0]["coordX"]);
      print(jsonData[1]["coordX"]);
      print(jsonData[2]["coordX"]);
      print(jsonData[3]["coordX"]);
      print(jsonData[4]["coordX"]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    datos();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        //mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(-12.046008377676447, -77.03031347857444),
          zoom: 12,
        ),
        markers: _createMarkers(),
        onMapCreated: _onMapCreated,
        zoomControlsEnabled: false,

      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.zoom_out_map),
        onPressed: _centerView,
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
  /*var json = null;
  variables() async {
    var response = await http.get("https://radiant-wildwood-90716.herokuapp.com/api/measurements/zone/"+jsonData[0][""]);
    if(response.statusCode == 200){
      setState(() {
        json[0] = json.decode(response.body);
      });

    }
  }*/

  List<dynamic> zone1 = [{"id": 0, "ecaValue":"h", "nombreZona":"h", "nombreVariable":"h"},{"id": 0, "ecaValue":"h", "nombreZona":"h", "nombreVariable":"h"}];
  List<dynamic> zone2 = [{"id": 0, "ecaValue":"h", "nombreZona":"h", "nombreVariable":"h"},{"id": 0, "ecaValue":"h", "nombreZona":"h", "nombreVariable":"h"}];
  List<dynamic> zone3 = [{"id": 0, "ecaValue":"h", "nombreZona":"h", "nombreVariable":"h"},{"id": 0, "ecaValue":"h", "nombreZona":"h", "nombreVariable":"h"}];
  List<dynamic> zone4 = [{"id": 0, "ecaValue":"h", "nombreZona":"h", "nombreVariable":"h"},{"id": 0, "ecaValue":"h", "nombreZona":"h", "nombreVariable":"h"}];
  List<dynamic> zone5 = [{"id": 0, "ecaValue":"h", "nombreZona":"h", "nombreVariable":"h"},{"id": 0, "ecaValue":"h", "nombreZona":"h", "nombreVariable":"h"}];

  cargarVariables() async{
    var response = await http.get(Uri.parse("https://radiant-wildwood-90716.herokuapp.com/api/measurements/zone/"+jsonData[0]["id"].toString()));
    if(response.statusCode == 200){
      setState(() {
        zone1 = json.decode(response.body);
      });
      print(zone1[0]["id"]);
      print(zone1[1]["id"]);
    }
    var response1 = await http.get(Uri.parse("https://radiant-wildwood-90716.herokuapp.com/api/measurements/zone/"+jsonData[1]["id"].toString()));
    if(response.statusCode == 200){
      setState(() {
        zone2 = json.decode(response1.body);
      });
      print(zone2[0]["id"]);
      print(zone2[1]["id"]);
    }
    var response2 = await http.get(Uri.parse("https://radiant-wildwood-90716.herokuapp.com/api/measurements/zone/"+jsonData[2]["id"].toString()));
    if(response.statusCode == 200){
      setState(() {
        zone3 = json.decode(response2.body);
      });
      print(zone3[0]["id"]);
      print(zone3[1]["id"]);
    }
    var response3 = await http.get(Uri.parse("https://radiant-wildwood-90716.herokuapp.com/api/measurements/zone/"+jsonData[3]["id"].toString()));
    if(response.statusCode == 200){
      setState(() {
        zone4 = json.decode(response3.body);
      });
      print(zone4[0]["id"]);
      print(zone4[1]["id"]);
    }
    var response4 = await http.get(Uri.parse("https://radiant-wildwood-90716.herokuapp.com/api/measurements/zone/"+jsonData[4]["id"].toString()));
    if(response.statusCode == 200){
      setState(() {
        zone5 = json.decode(response4.body);
      });
      print(zone5[0]["id"]);
      print(zone5[1]["id"]);
    }
  }

  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();



    tmp.add(Marker(
        markerId: MarkerId("zona1"),
        position: LatLng(jsonData[0]["coordX"], jsonData[0]["coordY"]),
        infoWindow: InfoWindow(title: zone1[0]["nombreZona"],
            snippet: "Variable "+zone1[0]["nombreVariable"].toString() + ": "+zone1[0]["ecaValue"].toString()+"\nVariable "+zone1[1]["nombreVariable"].toString() + ": "+zone1[1]["ecaValue"].toString()
        )
    ));
    tmp.add(Marker(
        markerId: MarkerId("zona2"),
        position: LatLng(jsonData[1]["coordX"], jsonData[1]["coordY"]),
        infoWindow: InfoWindow(title: zone2[0]["nombreZona"],
            snippet: "Variable "+zone2[0]["nombreVariable"].toString() + ": "+zone2[0]["ecaValue"].toString()+"\nVariable "+zone2[1]["nombreVariable"].toString() + ": "+zone2[1]["ecaValue"].toString()
        )
    ));
    tmp.add(Marker(
      markerId: MarkerId("zona3"),
      position: LatLng(jsonData[2]["coordX"], jsonData[2]["coordY"]),
      infoWindow: InfoWindow(title: zone3[0]["nombreZona"],
          snippet: "Variable "+zone3[0]["nombreVariable"].toString() + ": "+zone3[0]["ecaValue"].toString()+"\nVariable "+zone3[1]["nombreVariable"].toString() + ": "+zone3[1]["ecaValue"].toString()
      )
    ));
    tmp.add(Marker(
        markerId: MarkerId("zona4"),
        position: LatLng(jsonData[3]["coordX"], jsonData[3]["coordY"]),
        infoWindow: InfoWindow(title: zone4[0]["nombreZona"],
            snippet: "Variable "+zone4[0]["nombreVariable"].toString() + ": "+zone4[0]["ecaValue"].toString()+"\nVariable "+zone4[1]["nombreVariable"].toString() + ": "+zone4[1]["ecaValue"].toString()
        )
    ));
    tmp.add(Marker(
        markerId: MarkerId("zona5"),
        position: LatLng(jsonData[4]["coordX"], jsonData[4]["coordY"]),
        infoWindow: InfoWindow(title: zone5[0]["nombreZona"],
            snippet: "Variable "+zone5[0]["nombreVariable"].toString() + ": "+zone5[0]["ecaValue"].toString()+"\nVariable "+zone5[1]["nombreVariable"].toString() + ": "+zone5[1]["ecaValue"].toString()
        )
    ));
    return tmp;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    _centerView();
  }

  _centerView() async {
    await _mapController.getVisibleRegion();

    double left1 = min(jsonData[0]["coordX"],jsonData[1]["coordX"]);
    double left2 = min(jsonData[2]["coordX"],jsonData[3]["coordX"]);
    double left3 = min(left1,left2);
    double left = min(left3,jsonData[4]["coordX"]);

    double right1 = max(jsonData[0]["coordX"],jsonData[1]["coordX"]);
    double right2 = max(jsonData[2]["coordX"],jsonData[3]["coordX"]);
    double right3 = max(right1,right2);
    double right = max(right3,jsonData[4]["coordX"]);

    double top1 = max(jsonData[0]["coordY"],jsonData[1]["coordY"]);
    double top2 = max(jsonData[2]["coordY"],jsonData[3]["coordY"]);
    double top3 = max(top1,top2);
    double top = max(top3,jsonData[4]["coordY"]);

    double botton1 = min(jsonData[0]["coordY"],jsonData[1]["coordY"]);
    double botton2 = min(jsonData[2]["coordY"],jsonData[3]["coordY"]);
    double botton3 = min(botton1,botton2);
    double botton = min(botton3,jsonData[4]["coordY"]);


    var bounds = LatLngBounds(
        southwest: LatLng(left,botton),
        northeast: LatLng(right,top)
    );

    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);

    _mapController.animateCamera(cameraUpdate);
  }

}
