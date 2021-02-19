import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:converpak/src/services/datos.dart';
import 'package:converpak/src/pages/home.dart';

class CampoMonto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context);

    return Container(
      width: datos.width * 0.85,
      margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey[300],
      ),
      padding: EdgeInsets.only(left: 10.0),
      child: TextField(
        inputFormatters: [
          FilteringTextInputFormatter(RegExp(',*-* *'), allow: false),
        ],
        style: TextStyle(
            fontSize: datos.fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black),
        autofocus: true,
        keyboardType: TextInputType.numberWithOptions(signed: false),
        decoration: InputDecoration(
          icon: Icon(datos.iconMonto, size: datos.fontSize + 3.0, color: datos.color),
          hintStyle: TextStyle(fontSize: datos.fontSize, color: Colors.black),
          hintText: ' Ingrese un monto',
          border: InputBorder.none,
        ),
        showCursor: true,
        cursorWidth: 4.0,
        cursorColor: Color.fromRGBO(42, 197, 183, 1.0),
        cursorRadius: Radius.circular(15.0),
        onChanged: (valor) {
          if (valor == '') {
            datos.monedaConvertida = 0.00;
            datos.moneda2Convertida = 0.00;
            datos.packs64 = 0.00;
            datos.packs107 = 0.00;
            datos.packs535 = 0.00;
            datos.packs1070 = 0.00;
            datos.monto = 0.00;
            datos.actualizar();
          }
          datos.monto = double.parse(valor);
          Home.calcular(datos);
        },
      ),
    );
  }
}
