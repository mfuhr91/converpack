import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:converpak/src/pages/home.dart';
import 'package:converpak/src/services/datos.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return ChangeNotifierProvider(
      create: (context) => Datos(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ConverPack',
        home: GestureDetector(
          onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            FocusManager.instance.primaryFocus?.unfocus(); // saca el foco al textField y oculta el teclado
          }
          },
          child: Scaffold(
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
            body: Home(),
          ),

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
      ),
    );

    
  }
}
