import 'package:flutter/material.dart';

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
            const Text(
              'Más DigiScan',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
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
            )
          ],
        ),
      )),
    );
  }
}
