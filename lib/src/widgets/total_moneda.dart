import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:converpak/src/services/datos.dart';


class TotalMoneda extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final datos = Provider.of<Datos>(context);

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
          Icon(datos.iconTotal, size: datos.fontSize + 3.0, color: Colors.black),
          Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Text('    ${datos.monedaConvertida.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: datos.fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black
              )
            ),
          ),
        ],
      ),
    );
  }
}
