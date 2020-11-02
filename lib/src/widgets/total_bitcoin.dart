import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:converpak/src/services/datos.dart';

class TotalBitcoin extends StatefulWidget {

  @override
  _TotalBitcoinState createState() => _TotalBitcoinState();
}

class _TotalBitcoinState extends State<TotalBitcoin> {
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
          Icon(
            FontAwesomeIcons.bitcoin,
            size: 25.0,
            color: Color.fromRGBO(239, 143, 43, 1.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Text('    ${datos.bitcoinConvertido.toStringAsFixed(8)} ',
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