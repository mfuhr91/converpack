import 'package:flutter/material.dart';
import 'package:converpak/src/pages/pagina.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ConverPack',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(42, 197, 183, 1.0),
          title: Row(
            children: [
              Text('ConverPack'),
              SizedBox(width: 5.0),
              Image(
                image: AssetImage('assets/bandera.png'),
                fit: BoxFit.cover,
                width: 25.0,
              ),
            ],
          ),
        ),
        body: Pagina(),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Color.fromRGBO(42, 197, 183, 1.0),
        textSelectionHandleColor: Colors.blue,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        // TEMA OSCURO SEGUN SISTEMA
        brightness: Brightness.dark,
        canvasColor: Colors.black,
        accentColor: Color.fromRGBO(42, 197, 183, 1.0),
        textSelectionHandleColor: Colors.blue,
        primarySwatch: Colors.blue,
      ),
    );

    
  }
}
