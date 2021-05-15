import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:converpak/src/pages/home.dart';
import 'package:converpak/src/services/datos.dart';

class Botones extends StatelessWidget {
  final double varAncho = 0.005;

  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context);
    double alturaBoton = 0.0;
    if (datos.height < 600 && datos.width < 350) {
      alturaBoton = datos.height * 0.075;
    } else if (datos.height < 350 && datos.width < 600) {
      alturaBoton = datos.height * 0.2;
    } else if (datos.height < 800 && datos.width < 450) {
      alturaBoton = datos.height * 0.075;
    } else if (datos.height < 450 && datos.width < 800) {
      alturaBoton = datos.height * 0.2;
    } else if (datos.height < 960 && datos.width <= 600) {
      alturaBoton = datos.height * 0.075;
    } else if (datos.height <= 600 && datos.width <= 960) {
      alturaBoton = datos.height * 0.2;
    } else if (datos.height < 1300 && datos.width <= 800) {
      alturaBoton = datos.height * 0.075;
    } else if (datos.height <= 800 && datos.width <= 1300) {
      alturaBoton = datos.height * 0.2;
    } else if (Platform.isIOS && datos.height >= 1300) {
      alturaBoton = datos.height * 0.08;
    } else {
      alturaBoton = datos.height * 0.2;
    }

    return Container(
        margin: EdgeInsets.only(bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            SizedBox(width: 12.0),
            _convertirAEuro(datos, alturaBoton),
            _convertirBitAPeso(datos, alturaBoton),
            _convertirAPeso(datos, alturaBoton),
            SizedBox(width: 12.0),
            
          ],
        ));
  }

  FlatButton _convertirAEuro(Datos datos, double alturaBoton) {
    return FlatButton(
        height: alturaBoton,
        color: (datos.pesoAEuro) ? datos.color : Colors.grey[300],
        child: Row(
          children: [
            SizedBox(width: datos.width * varAncho),
            Icon(FontAwesomeIcons.dollarSign,
                size: datos.fontSize,
                color: (datos.pesoAEuro) ? Colors.white : datos.color),
            SizedBox(width: datos.width * varAncho),
            Icon(FontAwesomeIcons.arrowRight,
                size: datos.fontSize - 10.0,
                color: (datos.pesoAEuro) ? Colors.white : datos.color),
            SizedBox(width: datos.width * varAncho),
            Icon(FontAwesomeIcons.euroSign,
                size: datos.fontSize,
                color: (datos.pesoAEuro) ? Colors.white : datos.color),
            SizedBox(width: datos.width * varAncho),
          ],
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () {
          datos.iconMonto = FontAwesomeIcons.dollarSign;
          datos.iconTotal = FontAwesomeIcons.euroSign;
          datos.pesoAEuro = true;
          datos.bitAPeso = false;
          datos.euroAPeso = false;
          Home.calcular(datos);
        });
  }

  FlatButton _convertirBitAPeso(Datos datos, double alturaBoton) {
    return FlatButton(
        height: alturaBoton, //(datos.height < 350.0) ? datos.height * 0.2 : datos.height * 0.075,
        color: (datos.bitAPeso) ? datos.color : Colors.grey[300],
        child: Row(
          children: [
            SizedBox(width: datos.width * varAncho),
            Icon(FontAwesomeIcons.bitcoin,
                size: datos.fontSize + 0.0,
                color: (datos.bitAPeso) ? Colors.white : datos.color),
            SizedBox(width: datos.width * varAncho),
            Icon(FontAwesomeIcons.arrowRight,
                size: datos.fontSize - 10.0,
                color: (datos.bitAPeso) ? Colors.white : datos.color),
            SizedBox(width: datos.width * varAncho),
            Icon(FontAwesomeIcons.dollarSign,
                size: datos.fontSize,
                color: (datos.bitAPeso) ? Colors.white : datos.color),
            SizedBox(width: datos.width * varAncho),
          ],
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () {
          datos.iconMonto = FontAwesomeIcons.bitcoin;
          datos.iconTotal = FontAwesomeIcons.dollarSign;
          datos.pesoAEuro = false;
          datos.bitAPeso = true;
          datos.euroAPeso = false;
          Home.calcular(datos);
        });
  }

  FlatButton _convertirAPeso(Datos datos, double alturaBoton) {
    return FlatButton(
        height: alturaBoton, //(datos.height < 350.0) ? datos.height * 0.2 : datos.height * 0.075,
        color: (datos.euroAPeso) ? datos.color : Colors.grey[300],
        child: Row(
          children: [
            SizedBox(width: datos.width * varAncho),
            Icon(FontAwesomeIcons.euroSign,
                size: datos.fontSize,
                color: (datos.euroAPeso) ? Colors.white : datos.color),
            SizedBox(width: datos.width * varAncho),
            Icon(FontAwesomeIcons.arrowRight,
                size: datos.fontSize - 10.0,
                color: (datos.euroAPeso) ? Colors.white : datos.color),
            SizedBox(width: datos.width * varAncho),
            Icon(FontAwesomeIcons.dollarSign,
                size: datos.fontSize,
                color: (datos.euroAPeso) ? Colors.white : datos.color),
            SizedBox(width: datos.width * varAncho),
          ],
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () {
          datos.iconMonto = FontAwesomeIcons.euroSign;
          datos.iconTotal = FontAwesomeIcons.dollarSign;
          datos.pesoAEuro = false;
          datos.bitAPeso = false;
          datos.euroAPeso = true;
          Home.calcular(datos);
        });
  }

 
}
