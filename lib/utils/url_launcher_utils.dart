import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static Future<void> emailOpen(String email) async {
    final Uri uri = Uri.parse('mailto:$email?'
        'subject='
        '&'
        'body=');

    launchUrl(uri);
  }
}
