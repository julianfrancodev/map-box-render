import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:map_box/src/utils/MapToken.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapboxMapController mapController;
  final center = LatLng(5.513942, -73.363878);
  String selectedStyle =
      "mapbox://styles/julianfrancoalvarado/ckgd8z3hb1lxi1aqnrx46w4p7";
  final String monocromeMap =
      "mapbox://styles/julianfrancoalvarado/ckgd8z3hb1lxi1aqnrx46w4p7";
  final String streetsMap =
      "mapbox://styles/julianfrancoalvarado/ckgd91o9c4roi19misymlf7cd";

  void _onMapCreate(MapboxMapController mapController) {
    this.mapController = mapController;
    _onStyleLoaded();
  }

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/images/custom-icon.png");
    addImageFromUrl("networkImage", "https://via.placeholder.com/50");
  }

  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, String url) async {
    var response = await http.get(url);
    return mapController.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _renderMap(),
        floatingActionButton: _renderFloatingButtons());
  }

  Widget _renderFloatingButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Symbols
        FloatingActionButton(
          child: Icon(Icons.star_border),
          onPressed: (){
            mapController.addSymbol(SymbolOptions(
              geometry: center,
              iconImage: 'networkImage',
              textField: 'Mi rancho',
              textOffset: Offset(0,2)

            ));
          },
        ),
        SizedBox(height: 5,),

        // Zoom in

        FloatingActionButton(
          child: Icon(Icons.zoom_in),
          onPressed: (){
            mapController.animateCamera(CameraUpdate.zoomIn());
          },
        ),
        SizedBox(height: 5,),
        FloatingActionButton(
          child: Icon(Icons.zoom_out),
          onPressed: (){
            mapController.animateCamera(CameraUpdate.zoomOut());
          },
        ),
        SizedBox(height: 5,),

        FloatingActionButton(
          child: Icon(Icons.add_to_home_screen),
          onPressed: () {
            if (selectedStyle == monocromeMap) {
              selectedStyle = streetsMap;
            } else {
              selectedStyle = monocromeMap;
            }
            _onStyleLoaded();
            setState(() {});
          },
        )
      ],
    );
  }

  Widget _renderMap() {
    return MapboxMap(
      styleString: selectedStyle,
      accessToken: MAP_TOKEN,
      onMapCreated: _onMapCreate,
      initialCameraPosition: CameraPosition(target: center, zoom: 14),
    );
  }
}
