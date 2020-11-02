import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:converpak/src/pages/home.dart';
import 'package:converpak/src/services/datos.dart';

class Botones extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _convertirAEuro(datos),
          _convertirAPeso(datos),
        ],
      )
    );
  }

  FlatButton _convertirAEuro(Datos datos) {
    return FlatButton(
      height: datos.height * 0.075,
      color: (datos.pesoAEuro) ? datos.color : Colors.grey[300],
      child: Row(
        children: [
          SizedBox(width: datos.width * 0.025),
          Icon(FontAwesomeIcons.dollarSign,
              size: 25.0, color: (datos.pesoAEuro) ? Colors.white : datos.color),
          SizedBox(width: datos.width * 0.025),
          Icon(FontAwesomeIcons.arrowRight,
              size: 15.0, color: (datos.pesoAEuro) ? Colors.white : datos.color),
          SizedBox(width: datos.width * 0.025),
          Icon(FontAwesomeIcons.euroSign,
              size: 25.0, color: (datos.pesoAEuro) ? Colors.white : datos.color),
          SizedBox(width: datos.width * 0.025),
        ],
      ),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      onPressed: () {
        datos.iconMonto = FontAwesomeIcons.dollarSign;
        datos.iconTotal = FontAwesomeIcons.euroSign;
        datos.pesoAEuro = true;
        Home.calcular(datos);
      }
    );
  }

  FlatButton _convertirAPeso(Datos datos) {
    return FlatButton(
      height: datos.height * 0.075,
      color: (!datos.pesoAEuro) ? datos.color : Colors.grey[300],
      child: Row(
        children: [
          SizedBox(width: datos.width * 0.025),
          Icon(FontAwesomeIcons.euroSign,
              size: 25.0, color: (!datos.pesoAEuro) ? Colors.white : datos.color),
          SizedBox(width: datos.width * 0.025),
          Icon(FontAwesomeIcons.arrowRight,
              size: 15.0, color: (!datos.pesoAEuro) ? Colors.white : datos.color),
          SizedBox(width: datos.width * 0.025),
          Icon(FontAwesomeIcons.dollarSign,
              size: 25.0, color: (!datos.pesoAEuro) ? Colors.white : datos.color),
          SizedBox(width: datos.width * 0.025),
        ],
      ),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      onPressed: () {
      
        datos.iconMonto = FontAwesomeIcons.euroSign;
        datos.iconTotal = FontAwesomeIcons.dollarSign;
        datos.pesoAEuro = false;
        Home.calcular(datos);
      }
    );    
  }
}