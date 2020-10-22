import 'package:flutter/material.dart';
import 'package:converpak/src/pages/pagina.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ConverPak',
      home: Scaffold(
        appBar: AppBar(
          title: Text('ConverPak'),
        ),
        body: Pagina(),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.blue,
        textSelectionHandleColor: Colors.blue,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        // TEMA OSCURO SEGUN SISTEMA
        brightness: Brightness.dark,
        // canvasColor: Colors.black,
        accentColor: Colors.blue,
        textSelectionHandleColor: Colors.blue,
        primarySwatch: Colors.blue,
      ),
    );

    
  }
}
