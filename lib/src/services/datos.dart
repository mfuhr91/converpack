
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Datos with ChangeNotifier {
  IconData iconMonto = FontAwesomeIcons.dollarSign;
  IconData iconTotal = FontAwesomeIcons.euroSign;

  Color _color;
  bool _pesoAEuro = true;
  double _monto = 0.00;
  double _valorEuro = 0.00;
  double _valorBitcoin = 0.00;
  double _monedaConvertida = 0.00;
  double _bitcoinConvertido = 0.00;
  double _packs64 = 0.00;
  double _packs107 = 0.00;
  double _packs535 = 0.00;
  double _packs1070 = 0.00;

  double _width;
  double _height;
  double _bloque;
  double _fontSize;

  Color get color => _color;

  set color(Color color) {
    this._color = color;
  }

  bool get pesoAEuro => _pesoAEuro;

  set pesoAEuro(bool pesoAEuro) {
    this._pesoAEuro = pesoAEuro;
  }

  double get monto => _monto;

  set monto(double value) {
    _monto = value;
  }

  double get valorEuro => _valorEuro;

  set valorEuro(double value) {
    _valorEuro = value;
  }

  double get valorBitcoin => _valorBitcoin;

  set valorBitcoin(double value) {
    _valorBitcoin = value;
  }

  double get monedaConvertida => _monedaConvertida;

  set monedaConvertida(double value) {
    _monedaConvertida = value;
   
  }

  double get bitcoinConvertido => _bitcoinConvertido;

  set bitcoinConvertido(double value) {
    _bitcoinConvertido = value;
    
  }

  double get packs64 => _packs64;

  set packs64(double value) {
    _packs64 = value;
  }

  double get packs107 => _packs107;

  set packs107(double value) {
    _packs107 = value;
  }

  double get packs535 => _packs535;

  set packs535(double value) {
    _packs535 = value;
  }

  double get packs1070 => _packs1070;

  set packs1070(double value) {
    _packs1070 = value;
  }

  double get width => _width;

  set width(double width) {
    _width = width;
  }

  double get height => _height;

  set height(double height) {
    _height = height;
  }

  double get bloque => _bloque;

  set bloque(double bloque) {
    _bloque = bloque;
  }

  double get fontSize => _fontSize;

  set fontSize(double fontSize) {
    _fontSize = fontSize;
  }

  void actualizar() {
    notifyListeners();
  }
}
