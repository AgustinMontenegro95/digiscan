import 'package:digiscan/screens/digit_predictor/components/common_buttons.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class BodyHelp extends StatelessWidget {
  const BodyHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
          child: Theme(
            data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent),
            child: Column(
              children: [
                const Text(
                  'Centro de ayuda',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'El propósito es atender solicitudes e incidentes internos y externos relacionados a la aplicación.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                Divider(color: Colors.grey.withOpacity(0.5)),
                const ExpansionTile(
                  title: Text(
                    "Predecir un dígito",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  children: [
                    Text(
                      "Para predecir un dígito lo que tienes que hacer es seguir los siguientes pasos:",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "1) En pantalla principal, debes seleccionar \"Agregar imagen\" para luego abrir la galería o tomar una foto (en caso de no haber concedido antes los permisos, concederlos).\n2) Editar la imagen de modo que el dígito quede centrado dentro del recuadro y confirmar la selección.\n3) Por último, presionar el botón \"Predecir\" que nos brindará el resultado de la predicción.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(color: Colors.grey.withOpacity(0.5)),
                ExpansionTile(
                  title: const Text(
                    "No abre cámara y/o galería",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                  ),
                  children: [
                    const Text(
                      "Debes conceder los permisos de uso a la aplicación. Como modificar estos permisos:",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "1) Ingresar a \"Modificar permisos\".\n2) En la pantalla de información de la aplicación, seleccionar la opción \"Permisos\".\n3) Elegir el gadget a modificar los permisos.\n4) Seleccionar la opción \"Permitir\" y ¡Listo!",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CommonButtons(
                      onTap: () => openAppSettings(),
                      backgroundColor: Colors.purple,
                      textColor: Colors.white,
                      textLabel: "Modificar permisos",
                    ),
                  ],
                ),
                Divider(color: Colors.grey.withOpacity(0.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
