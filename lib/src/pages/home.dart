import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import 'package:converpak/src/services/datos.dart';
import 'package:converpak/src/widgets/botones.dart';
import 'package:converpak/src/widgets/campo_monto.dart';
import 'package:converpak/src/widgets/cotizacion.dart';
import 'package:converpak/src/widgets/packs.dart';
import 'package:converpak/src/widgets/total_bitcoin.dart';
import 'package:converpak/src/widgets/total_moneda.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final datos = Provider.of<Datos>(context);

    datos.width = MediaQuery.of(context).size.width;
    datos.height = MediaQuery.of(context).size.height;
    datos.bloque = datos.width / 100;
    datos.fontSize = datos.bloque * 6;

    datos.color = Theme.of(context).accentColor;

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CampoMonto(),
            Cotizacion(),
            SizedBox(height: 10.0),
            TotalMoneda(),
            TotalBitcoin(),
            Packs(),
            Botones(),
          ],
        ),
      ),
    );
  }

  static double dp(double val, int places) {
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  static void calcular(datos) {
    if (datos.monto != null) {
      if (datos.pesoAEuro) {
        datos.monedaConvertida = dp((datos.monto / datos.valorEuro), 2);
        datos.bitcoinConvertido = dp((datos.monto / datos.valorBitcoin), 8);

        datos.packs64 = datos.monedaConvertida / 64.20;
        datos.packs107 = datos.monedaConvertida / 107;
        datos.packs535 = datos.monedaConvertida / 535;
        datos.packs1070 = datos.monedaConvertida / 1070;
      } else if(datos.bitAPeso) {
        datos.monedaConvertida = dp((datos.monto * datos.valorEuro), 2);
        datos.bitcoinConvertido =
            dp(((datos.monto * datos.valorEuro) / datos.valorBitcoin), 6);

        datos.packs64 = datos.monto / 64.20;
        datos.packs107 = datos.monto / 107;
        datos.packs535 = datos.monto / 535;
        datos.packs1070 = datos.monto / 1070;
      } else {
        datos.monedaConvertida = dp((datos.monto * datos.valorEuro), 2);
        datos.bitcoinConvertido =
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
