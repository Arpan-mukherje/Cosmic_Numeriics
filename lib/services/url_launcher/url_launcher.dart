import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static Future<void> email() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: "babuvochay112@gmail.com",
      query: encodeQueryParameters(<String, String>{
        'subject': 'Support',
      }),
    );

    final String urlString = emailLaunchUri.toString();

    if (await canLaunchUrl(Uri.parse(urlString))) {
      await launchUrl(Uri.parse(urlString));
    } else {
      throw 'Could not launch $urlString';
    }
  }
}
