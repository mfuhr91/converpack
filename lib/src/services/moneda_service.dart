import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:converpak/src/models/moneda_model.dart';

class MonedaService {
  String _url = 'converpak.herokuapp.com';

  List<Moneda> monedas = new List();
  Future<List<Moneda>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);

    if (resp.statusCode == 200) {
      final decodedData = json.decode(resp.body);
      for (var item in decodedData) {
        Moneda moneda = Moneda.fromJson(item);
        monedas.add(moneda);
      }

      return monedas;
    } else {
      throw Exception('No se puede acceder al servidor');
    }
  }

  Future<List<Moneda>> getCotizaciones() async {
    final url = Uri.https(_url, 'api/moneda/listarUltimos');
   
    try {
      final resp = await _procesarRespuesta(url);
      return resp;
    } catch (Exception) {
      print(Exception);
      return Exception;
    }
    
  }
}
