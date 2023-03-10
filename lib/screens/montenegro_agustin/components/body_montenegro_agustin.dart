import 'package:animate_do/animate_do.dart';
import 'package:digiscan/screens/montenegro_agustin/components/constant_data_ma.dart';
import 'package:digiscan/utils/social_media_button.dart';
import 'package:flutter/material.dart';

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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    textAlign: TextAlign.end,
                    text: TextSpan(
                      style: const TextStyle(
                          color: Colors.black), //style for all textspan
                      children: [
                        TextSpan(
                            text: aWelcomeMA,
                            style: const TextStyle(fontSize: 25)),
                        TextSpan(
                            text: bWelcomeMA,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue.shade800)),
                        TextSpan(
                            text: cWelcomeMA,
                            style: const TextStyle(fontSize: 25)),
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
                        'assets/images/profile-agustin.jpg',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
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
              const Text(
                "??Quieres saber m??s?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
