import 'package:url_launcher/url_launcher.dart';

Future<void> launchAUrl(url) async {
  final Uri _url = Uri.parse(url, );
  try{
    await launchUrl(_url, mode: LaunchMode.externalApplication, );
  } on Exception{
    throw Exception('Could not launch $_url');
  }
}