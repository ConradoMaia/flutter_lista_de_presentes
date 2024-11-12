import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'package:flutter_lista_de_presentes/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chá de Panelas',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: HomePage(),
    );
  }
}
