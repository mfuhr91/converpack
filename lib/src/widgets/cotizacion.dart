import 'package:converpak/src/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:converpak/src/models/moneda_model.dart';
import 'package:converpak/src/services/datos.dart';
import 'package:converpak/src/services/moneda_service.dart';

class Cotizacion extends StatelessWidget {
  Future<List<Moneda>> _cotizaciones;

  final _monedaService = new MonedaService();

  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context);

    _cotizaciones = (datos.valorEuro == 0.0 || datos.valorBitcoin == 0.0)
        ? _monedaService.getCotizaciones()
        : _cotizaciones;

    return FutureBuilder(
        future: _cotizaciones,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Moneda> monedas = snapshot.data;

            monedas.forEach((element) {
              if (element.tipo.contains('euro_blue')) {
                  
                datos.valorEuro = element.valor;
                
              } else {
                datos.valorBitcoin = element.valor;
              }
            });
            return Column(
              children: [
                Container(
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.only(bottom: 15.0),
                    width: datos.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Text(
                      (datos.valorEuro.toString().endsWith(".0")) ? 
                      'Euro Blue:  ${datos.valorEuro}0' :
                      'Euro Blue:  ${datos.valorEuro}',
                      style: TextStyle(
                          fontSize: datos.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(bottom: 10.0),
                  width: datos.width * 0.85,
                  decoration: BoxDecoration(
                    color: Colors.orange[300],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    (datos.valorBitcoin.toString().endsWith(".0")) ? 
                      'Bitcoin:   ${datos.valorBitcoin}0' :
                      'Bitcoin:   ${datos.valorBitcoin}',
                      style: TextStyle(
                          fontSize: datos.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Container(
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 10.0),
                width: datos.width * 0.85,
                height: 125.0,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_off, color: Colors.black, size: 45.0),
                    SizedBox(height: 5.0),
                    Text(
                      'No se puede acceder al servidor vuelva a intentarlo mas tarde.',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ));
          } else {
            return Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(bottom: 10.0),
              width: datos.width * 0.85,
              height: 125.0,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Cargando cotizaciones',
                    style: TextStyle(
                        fontSize: datos.fontSize,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
        });
  }
}
