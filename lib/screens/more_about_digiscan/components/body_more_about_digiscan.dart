import 'dart:io';

import 'package:digiscan/screens/digit_predictor/components/common_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BodyMoreAboutDigiScan extends StatelessWidget {
  const BodyMoreAboutDigiScan({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
        child: Column(
          children: [
            Text(
              'Más DigiScan',
              style: TextStyle(
                color: Colors.deepPurple[900],
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Stack(
              children: [
                Positioned(
                  top: 100,
                  child: Opacity(
                    opacity: 0.2,
                    child: Image.asset(
                      'assets/images/loupe.png',
                      width: MediaQuery.of(context).size.width * 0.85,
                    ),
                  ),
                ),
                const Text(
                  "DigitScan es una aplicación realizada por alumnos de la Facultad de Ciencias Exactas y Tecnologías de la Universidad Nacional de Santiago del Estero, para facilitar la comprensión de lo expuesto en el Trabajo Final de Graduación de uno de ellos, en donde se desarrollaron los conceptos de Redes Neuronales con una implementación en Tensorflow con el dataset de MNIST.\nDicha implementación es aplicada esta en app y permite la detección de los dígitos de un número escrito a mano usando la cámara de fotos. La app fue desarrollada por completo en Flutter por Agustín Montenegro y la red neuronal fue desarrollada en Python por Carlos Alberto Habiñak.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            CommonButtons(
              onTap: () async {
                ByteData imageData =
                    await rootBundle.load('assets/images/share.png');
                Uint8List bytes = imageData.buffer.asUint8List();
                File file =
                    File('${(await getTemporaryDirectory()).path}/image.png');
                await file.writeAsBytes(bytes);
                Share.shareXFiles([XFile(file.path)],
                    text:
                        'DigiScan, encontranos en Play Store https://play.google.com/store/apps/details?id=com.soludev.digiscan. SoluDev.');
              },
              backgroundColor: Colors.deepPurple,
              textColor: Colors.white,
              textLabel: "Compartir app",
            ),
          ],
        ),
      )),
    );
  }
}
