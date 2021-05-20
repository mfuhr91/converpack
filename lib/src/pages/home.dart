import 'package:converpak/src/models/moneda_model.dart';
import 'package:converpak/src/services/moneda_service.dart';
import 'package:converpak/src/widgets/cotizacion.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:converpak/src/services/datos.dart';
import 'package:converpak/src/widgets/botones.dart';
import 'package:converpak/src/widgets/campo_monto.dart';
import 'package:converpak/src/widgets/packs.dart';
import 'package:converpak/src/widgets/total_moneda.dart';
import 'package:converpak/src/widgets/total_moneda2.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  static double dp(double val, int places) {
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  static void calcular(datos) {
    if (datos.monto != null) {
      if (datos.pesoAEuro) {
        datos.monedaConvertida = dp((datos.monto / datos.valorEuro), 2);
        datos.moneda2Convertida = dp((datos.monto / datos.valorBitcoin), 8);

        datos.packs64 = datos.monedaConvertida / 64.20;
        datos.packs107 = datos.monedaConvertida / 107;
        datos.packs535 = datos.monedaConvertida / 535;
        datos.packs1070 = datos.monedaConvertida / 1070;
      } else if (datos.bitAPeso) {
        datos.monedaConvertida = dp((datos.monto * datos.valorBitcoin), 2);
        datos.moneda2Convertida =
            dp(((datos.monto * datos.valorBitcoin) / datos.valorEuro), 6);

        datos.packs64 = datos.moneda2Convertida / 64.20;
        datos.packs107 = datos.moneda2Convertida / 107;
        datos.packs535 = datos.moneda2Convertida / 535;
        datos.packs1070 = datos.moneda2Convertida / 1070;
      } else {
        datos.monedaConvertida = dp((datos.monto * datos.valorEuro), 2);
        datos.moneda2Convertida =
            dp(((datos.monto * datos.valorEuro) / datos.valorBitcoin), 6);

        datos.packs64 = datos.monto / 64.20;
        datos.packs107 = datos.monto / 107;
        datos.packs535 = datos.monto / 535;
        datos.packs1070 = datos.monto / 1070;
      }
    }
    datos.actualizar();
  }
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context);

    datos.width = MediaQuery.of(context).size.width;
    datos.height = MediaQuery.of(context).size.height;
    datos.bloque = datos.width / 100;
    datos.fontSize = datos.bloque * 6;

    datos.color = Theme.of(context).accentColor;

    RefreshController _refreshController =
        RefreshController(initialRefresh: true);

    void _onRefresh() async {
      datos.valorEuro = 0.0;
      datos.valorBitcoin = 0.0;
      try {
        List<Moneda> monedas = await MonedaService().getCotizaciones();

        if (monedas != null && monedas.length > 0) {
          monedas.forEach((element) {
            if (element.tipo.contains('euro_blue')) {
              datos.valorEuro = element.valor;
            } else {
              datos.valorBitcoin = element.valor;
            }
          });

          datos.actualizar();
          _refreshController.refreshCompleted();
        } else {
          _refreshController.refreshFailed();
        }
      } catch (Exception) {
        datos.actualizar();
        _refreshController.refreshFailed();
      }
    }

    return SmartRefresher(
      enablePullDown: true,
      header: ClassicHeader(
        idleText: "Deslice para actualizar cotizaciones",
        releaseText: "Suelte para actualizar cotizaciones",
        refreshingText: "Actualizando cotizaciones",
        completeText: "Cotizaciones actualizadas!",
        failedText: "Cotizaciones no actualizadas!",
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CampoMonto(),
              Cotizacion(),
              SizedBox(height: 10.0),
              TotalMoneda(),
              TotalMoneda2(),
              Packs(),
              Botones(),
            ],
          ),
        ),
      ),
    );
  }
}
