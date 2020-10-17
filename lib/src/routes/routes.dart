import 'package:flutter/material.dart';
import 'package:map_box/src/pages/MapPage.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  '/':(context) => MapPage()
};