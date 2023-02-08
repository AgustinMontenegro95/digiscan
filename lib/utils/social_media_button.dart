import 'package:digit_predictor/utils/url_launcher_utils.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialMediaButton extends StatelessWidget {
  final String socialMedia;
  final String? url;
  final bool? isEmail;
  final String? email;

  const SocialMediaButton(
      {super.key,
      required this.socialMedia,
      this.url,
      this.email = "",
      this.isEmail = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (email == "") {
          launchUrlString(url!, mode: LaunchMode.externalApplication);
        } else {
          UrlLauncherUtils.emailOpen(email!);
        }
      },
      child: Image.asset(
        "assets/images/social_media/$socialMedia.png",
        width: 40,
        height: 40,
      ),
    );
  }
}
