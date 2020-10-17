import 'package:flutter/material.dart';
import 'package:map_box/src/routes/routes.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MapBox",
      initialRoute: '/',
      routes: routes,
    )
  );
}