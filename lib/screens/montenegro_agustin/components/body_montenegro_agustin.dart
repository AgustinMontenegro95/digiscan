import 'package:flutter/material.dart';
import 'package:digit_predictor/utils/social_media_button.dart';
import 'package:digit_predictor/screens/montenegro_agustin/components/constant_data_ma.dart';

class BodyMontenegroAgustin extends StatelessWidget {
  const BodyMontenegroAgustin({super.key});

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
              Text(
                welcomeMA,
                textAlign: TextAlign.end,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.grey.shade400,
                child: Padding(
                  padding: const EdgeInsets.all(3), // Border radius
                  child: ClipOval(
                      child: Image.asset(
                    'assets/images/not-image.jpg',
                  )),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                occupationMA,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              Text(
                descriptionMA,
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              const Text("¿Quieres saber más?"),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    SocialMediaButton(
                        socialMedia: "linkedin",
                        url: "https://www.linkedin.com/in/montenegro-agustin/"),
                    SocialMediaButton(
                        socialMedia: "github",
                        url: "https://github.com/AgustinMontenegro95"),
                    SocialMediaButton(
                        socialMedia: "gmail",
                        email: "agustinmontenegroam10@gmail.com"),
                    SocialMediaButton(
                        socialMedia: "instagram",
                        url: "https://www.instagram.com/agu_montenegr"),
                    SocialMediaButton(
                        socialMedia: "whatsapp",
                        url: "https://wa.me/3854117816"),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
}
