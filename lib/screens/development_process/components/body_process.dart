import 'package:flutter/material.dart';

class BodyDevelopmentProcess extends StatelessWidget {
  const BodyDevelopmentProcess({super.key});

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
              'Desarrollo',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'El desarrollo de DigiScan fue un proceso complejo que requiere conocimientos avanzados de programación, visión por computadora y aprendizaje automático.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            Text(
                "A continuación, se presenta una descripción general de los pasos necesarios para desarrollar una aplicación de este tipo:"),
            Row(
              children: [
                Icon(
                  Icons.check,
                  color: Colors.purple.shade700,
                ),
                Text(
                    "Recopilación de datos: Es necesario contar con un conjunto de datos que contenga imágenes de números escritos a mano. Estos datos se utilizarán para entrenar un modelo de aprendizaje automático que reconozca los números. Existen varios conjuntos de datos públicos disponibles en línea, como MNIST o SVHN, que pueden ser utilizados para este fin."),
              ],
            )
          ],
        ),
      )),
    );
  }
}
