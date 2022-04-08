import 'package:flutter/material.dart';
import 'package:maps_view/home/home_page.dart';
import 'package:maps_view/home/mapa_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => MapaProvider(),
        child: HomePage(),
      ),
    );
  }
}
