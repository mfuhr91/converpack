import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:converpak/src/models/moneda_model.dart';
import 'package:converpak/src/services/datos.dart';
import 'package:converpak/src/services/moneda_service.dart';

class Cotizacion extends StatefulWidget with ChangeNotifier{
  @override
  _CotizacionState createState() => _CotizacionState();
}

class _CotizacionState extends State<Cotizacion> {
  Future<List<Moneda>> _cotizaciones;

  final _monedaService = new MonedaService();

  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context);

    _cotizaciones = _monedaService.getCotizaciones();

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
                      // comparo que el numero no termine en .0 o .n, de ser asi, le agrego un 0 al final para tener 2 decimales
                      ((datos.valorEuro * 10).toString().endsWith(".0"))
                          ? ' Euro Blue:  ${datos.valorEuro}0'
                          : ' Euro Blue:  ${datos.valorEuro}',
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
                      // comparo que el numero no termine en .0 o .n, de ser asi, le agrego un 0 al final para tener 2 decimales
                      ((datos.valorBitcoin * 10).toString().endsWith(".0"))
                          ? ' Bitcoin:       ${datos.valorBitcoin}0'
                          : ' Bitcoin:       ${datos.valorBitcoin}',
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
                    Icon(Icons.cloud_off, color: Colors.black, size: 34.0),
                    SizedBox(height: 5.0),
                    Text(
                      'No se puede acceder al servidor, \n' +
                      'vuelva a intentarlo mas tarde.\n'+
                      'Deslice hacia abajo para actualizar.',
                      style: TextStyle(
                          height: 1.3,
                          fontSize: 17.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
              
                      textAlign: TextAlign.center,
                    ),
                  ],
                ));
          } else {
            return CargandoCotizacion(datos: datos);
          }
        });
  }
}

class CargandoCotizacion extends StatelessWidget {
  const CargandoCotizacion({
    Key key,
    @required this.datos,
  }) : super(key: key);

  final Datos datos;

  @override
  Widget build(BuildContext context) {
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
            child: Row(
              children: [
                Text(
                  // comparo que el numero no termine en .0 o .n, de ser asi, le agrego un 0 al final para tener 2 decimales
                  ' Euro Blue:  ',
                  style: TextStyle(
                      fontSize: datos.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 25.0,
                  height: 25.0,
                  child: defaultTargetPlatform == TargetPlatform.iOS
                      ? const CupertinoActivityIndicator()
                      : const CircularProgressIndicator(strokeWidth: 2.0),
                )
              ],
            )),
        Container(
          padding: EdgeInsets.all(10.0),
          margin: EdgeInsets.only(bottom: 10.0),
          width: datos.width * 0.85,
          decoration: BoxDecoration(
            color: Colors.orange[300],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Row(
            children: [
              Text(
                  // comparo que el numero no termine en .0 o .n, de ser asi, le agrego un 0 al final para tener 2 decimales
                  ' Bitcoin:       ',
                  style: TextStyle(
                      fontSize: datos.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(
                width: 25.0,
                height: 25.0,
                child: defaultTargetPlatform == TargetPlatform.iOS
                    ? const CupertinoActivityIndicator()
                    : const CircularProgressIndicator(strokeWidth: 2.0),
              )
            ],
          ),
        ),
      ],
    );
  }
}
