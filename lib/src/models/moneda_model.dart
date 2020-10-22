// To parse this JSON data, do
//
//     final moneda = monedaFromJson(jsonString);

import 'dart:convert';

List<Moneda> monedaFromJson(String str) => List<Moneda>.from(json.decode(str).map((x) => Moneda.fromJson(x)));

String monedaToJson(List<Moneda> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Moneda {
    Moneda({
        this.id,
        this.tipo,
        this.valor,
        this.fecha,
    });

    int id;
    String tipo;
    double valor;
    DateTime fecha;

    factory Moneda.fromJson(Map<String, dynamic> json) => Moneda(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"].toDouble(),
        fecha: DateTime.parse(json["fecha"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
        "fecha": fecha.toIso8601String(),
    };
}
