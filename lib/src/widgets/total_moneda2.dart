import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:converpak/src/services/datos.dart';

class TotalMoneda2 extends StatefulWidget {
  @override
  _TotalMoneda2State createState() => _TotalMoneda2State();
}

class _TotalMoneda2State extends State<TotalMoneda2> {
  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context);
    String moneda2;
    Icon icon;
    
    if(datos.bitAPeso){
      moneda2 = datos.moneda2Convertida.toStringAsFixed(2);
      icon = Icon(
        FontAwesomeIcons.euroSign,
        size: datos.fontSize + 3.0,
        color: Color.fromRGBO(1,1,1,1.0),
      );
    } else {
      moneda2 = datos.moneda2Convertida.toStringAsFixed(8);
      icon = Icon(
        FontAwesomeIcons.bitcoin,
        size: datos.fontSize + 3.0,
        color: Color.fromRGBO(239, 143, 43, 1.0),
      );

    }
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 15.0),
      width: datos.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15.0),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          icon,
          Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Text('    $moneda2 ',
                style: TextStyle(
                    fontSize: datos.fontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
