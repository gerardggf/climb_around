import 'package:url_launcher/url_launcher.dart';

Future<void> launchThisUrl(String url) async {
  final uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}
