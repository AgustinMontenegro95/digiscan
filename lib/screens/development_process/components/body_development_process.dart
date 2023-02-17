import 'package:flutter/material.dart';
import 'package:digiscan/screens/development_process/components/constant_data_dp.dart';
import 'package:digiscan/screens/development_process/components/step_dp.dart';

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
            const Text(
              'Desarrollo',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              desarrolloDP,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 16.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 15),
            Text(pasosDP),
            const SizedBox(height: 20),
            StepDP(text: recopilacionDatosDP),
            const SizedBox(height: 10),
            StepDP(text: preprocesamientoImagenesDP),
            const SizedBox(height: 10),
            StepDP(text: entrenamientoModeloDP),
            const SizedBox(height: 10),
            StepDP(text: desarrolloAppDP),
            const SizedBox(height: 10),
            StepDP(text: evaluacionMejoraDP),
            const SizedBox(height: 20),
            Text(
              resumenDP,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      )),
    );
  }
}
