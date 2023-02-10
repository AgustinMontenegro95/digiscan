import 'package:animate_do/animate_do.dart';
import 'package:digit_predictor/screens/habinak_carlos/components/constant_data_hc.dart';
import 'package:digit_predictor/utils/social_media_button.dart';
import 'package:flutter/material.dart';

class BodyHabinakCarlos extends StatelessWidget {
  const BodyHabinakCarlos({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black), //style for all textspan
                      children: [
                        const TextSpan(
                            text: "Hola, soy ", style: TextStyle(fontSize: 25)),
                        TextSpan(
                            text: "Carlos",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800)),
                        const TextSpan(
                            text:
                                ", el\nencargado de la\ninteligencia artificial.",
                            style: TextStyle(fontSize: 25)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ZoomIn(
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey.shade400,
                  child: Padding(
                    padding: const EdgeInsets.all(3), // Border radius
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/not-image.jpg',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                occupationHC,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Text(
                descriptionHC,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Text(
                "¿Quieres saber más?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    SocialMediaButton(
                        socialMedia: "linkedin",
                        url:
                            "https://www.linkedin.com/in/carlos-alberto-habi%C3%B1ak-a21b144b/"),
                    /* SocialMediaButton(
                        socialMedia: "github",
                        url: "https://github.com/AgustinMontenegro95"), */
                    SocialMediaButton(
                        socialMedia: "gmail", email: "carloshabinak@gmail.com"),
                    SocialMediaButton(
                        socialMedia: "instagram",
                        url: "https://www.instagram.com/carloshabinak/"),
                    SocialMediaButton(
                        socialMedia: "whatsapp",
                        url: "https://wa.me/3856879520"),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}