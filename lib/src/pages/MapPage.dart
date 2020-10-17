import 'package:flutter/material.dart';
import 'package:map_box/src/utils/MapToken.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapboxMapController mapController;
  final center = LatLng(5.513942, -73.363878);
  String selectedStyle = "mapbox://styles/julianfrancoalvarado/ckgd8z3hb1lxi1aqnrx46w4p7";
  final String monocromeMap = "mapbox://styles/julianfrancoalvarado/ckgd8z3hb1lxi1aqnrx46w4p7";
  final String streetsMap = "mapbox://styles/julianfrancoalvarado/ckgd91o9c4roi19misymlf7cd";

  void _onMapCreate(MapboxMapController mapController) {
    this.mapController = mapController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _renderMap(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add_to_home_screen),
            onPressed: (){
              if(selectedStyle == monocromeMap){
                selectedStyle = streetsMap;
              }else{
                selectedStyle = monocromeMap;
              }
              setState(() {

              });
            },
          )
        ],
      ),
    );
  }

  Widget _renderMap(){
    return MapboxMap(
      styleString: selectedStyle,
      accessToken: MAP_TOKEN,
      onMapCreated: _onMapCreate,
      initialCameraPosition: CameraPosition(target: center, zoom: 14),
    );
  }
}
