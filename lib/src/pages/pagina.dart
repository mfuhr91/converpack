import 'dart:math';

import 'package:converpak/src/models/moneda_model.dart';
import 'package:converpak/src/services/moneda_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Pagina extends StatefulWidget {
  @override
  _PaginaState createState() => _PaginaState();
}

class _PaginaState extends State<Pagina> {
  IconData iconMonto = FontAwesomeIcons.dollarSign;
  IconData iconTotal = FontAwesomeIcons.euroSign;


  bool pesoAEuro = true;
  double monto = 0.00;
  double _valorEuro = 0.00;
  double _valorBitcoin = 0.00;
  double _monedaConvertida = 0.00;
  double _bitcoinConvertido = 0.00;
  final monedaService = new MonedaService();
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).accentColor;
    return Container(
      child: Column(
        children: [
          _campoMonto(color),
          _cotizacion(color),
          Text(
            "TOTAL",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          _totalMoneda(color),
          _totalBitcoin(color),
          _selector(color),
        ],
      ),
    );
  }

  Widget _campoMonto(Color color) {
    return Container(
      margin: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0, bottom: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey[300],
      ),
      padding: EdgeInsets.only(left: 10.0),
      child: TextField(
        style: TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(iconMonto, size: 30.0),
          hintStyle: TextStyle(fontSize: 20, color: Colors.black),
          hintText: 'Ingrese un Monto',
          border: InputBorder.none,
        ),
        showCursor: false,
        onChanged: (valor) {
          double monto = double.tryParse(valor);
          setState(() {
            print(valor);
            print(monto);
            if (monto == null) {
              _monedaConvertida = 0.00;
              _bitcoinConvertido = 0.00;
            }
            _calcular(monto, _valorEuro, _valorBitcoin, pesoAEuro);
          });
        },
      ),
    );
  }

  Widget _cotizacion(Color color) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(bottom: 15.0),
            width: 350.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15.0),
            ),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /*  Icon(iconEuro,
                    size: 25.0, color: Colors.black), */
                FutureBuilder(
                  future: monedaService.getCotizaciones(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Moneda> monedas = snapshot.data;

                      monedas.forEach((element) {
                        if (element.tipo.contains('euro_blue')) {
                          _valorEuro = element.valor;
                        }
                      });
                      return Padding(
                          padding: const EdgeInsets.only(top: 1.0),
                          child: Text(
                            'Euro Blue:  ${monedas[0].valor}0',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ));
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.only(bottom: 10.0),
            width: 350.0,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(15.0),
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                /*  Icon(
                  FontAwesomeIcons.bitcoin,
                  size: 25.0,
                  color: Color.fromRGBO(239, 143, 43, 1.0),
                ), */
                FutureBuilder(
                  future: monedaService.getCotizaciones(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      List<Moneda> monedas = snapshot.data;
                      monedas.forEach((element) {
                        if (element.tipo.contains('bitcoin')) {
                          _valorBitcoin = element.valor;
                        }
                      });
                      return Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: Text('Bitcoin:   ${monedas[1].valor}',
                            style: TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _totalMoneda(Color color) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 15.0),
      width: 350.0,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15.0),
      ),
      alignment: Alignment.center,
      child: Row(
        children: [
          Icon(iconTotal, size: 25.0, color: Colors.black),
          Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: Text('  ${_monedaConvertida.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _totalBitcoin(Color color) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.only(bottom: 15.0),
      width: 350.0,
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
            child: Text('  ${_bitcoinConvertido.toStringAsFixed(8)}',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _selector(Color color) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _convertirAEuro(color),
        _convertirAPeso(color),
      ],
    ));
  }

  FlatButton _convertirAEuro(Color color) {
    return FlatButton(
        height: 50.0,
        color: (pesoAEuro) ? Colors.blue : Colors.grey[300],
        child: Row(
          children: [
            Icon(FontAwesomeIcons.dollarSign, size: 25.0, color: (pesoAEuro) ? Colors.white : Colors.blue),
            Icon(FontAwesomeIcons.arrowRight, size: 15.0, color: (pesoAEuro) ? Colors.white : Colors.blue),
            Icon(FontAwesomeIcons.euroSign, size: 25.0, color: (pesoAEuro) ? Colors.white : Colors.blue),
          ],
        ), // Text('   Peso > Euro   ',style: TextStyle(fontSize: 20.0))
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () {
          setState(() {
            iconMonto = FontAwesomeIcons.dollarSign;
            iconTotal = FontAwesomeIcons.euroSign;
            pesoAEuro = true;
          });
        });
  }

  FlatButton _convertirAPeso(Color color) {
    return FlatButton(
      
        height: 50.0,
        color: (!pesoAEuro) ? Colors.blue : Colors.grey[300],
        child: Row(
          children: [
            Icon(FontAwesomeIcons.euroSign, size: 25.0, color: (!pesoAEuro) ? Colors.white : Colors.blue),
            Icon(FontAwesomeIcons.arrowRight, size: 15.0, color: (!pesoAEuro) ? Colors.white : Colors.blue),
            Icon(FontAwesomeIcons.dollarSign, size: 25.0, color: (!pesoAEuro) ? Colors.white : Colors.blue),
          ],
        ), // Text('   Peso > Euro   ',style: TextStyle(fontSize: 20.0))
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        onPressed: () {
          setState(() {
            iconMonto = FontAwesomeIcons.euroSign;
            iconTotal = FontAwesomeIcons.dollarSign;
            pesoAEuro = false;
          });
        });
  }

  double dp(double val, int places) {
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  void _calcular(
      double monto, double _valorEuro, double _valorBitcoin, bool pesoAEuro) {
    if (pesoAEuro) {
      print('${(dp((monto / _valorEuro), 2)).toStringAsFixed(2)}');
      print('${(dp((monto / _valorEuro), 10))}');
      _monedaConvertida = dp((monto / _valorEuro), 2);
      _bitcoinConvertido = dp((monto / _valorBitcoin), 8);
    } else {
      print('${(dp((monto * _valorEuro), 2)).toStringAsFixed(2)}');
      _monedaConvertida = dp((monto * _valorEuro), 2);
      print('${(dp((monto * _valorEuro), 10))}');
      _bitcoinConvertido = dp(((monto * _valorEuro) / _valorBitcoin), 6);
    }
  }
}
