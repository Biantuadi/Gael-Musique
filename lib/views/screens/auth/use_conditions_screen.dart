import 'package:Gael/utils/theme_variables.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UseConditionsScreen extends StatefulWidget {
  UseConditionsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return UseConditionsScreenState();
  }
}
class UseConditionsScreenState extends State<UseConditionsScreen>{
  final WebViewController controller = WebViewController();
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
      NavigationDelegate(
      onProgress: (int progress) {
      // Update loading bar.
      },
      onPageStarted: (String url) {},
      onPageFinished: (String url) {},
      onWebResourceError: (WebResourceError error) {},
      onNavigationRequest: (NavigationRequest request) {
      if (request.url.startsWith('https://gael-cgu.vercel.app')) {
      return NavigationDecision.prevent;
      }
      return NavigationDecision.navigate;
      },
      ),
      )
      ..loadRequest(Uri.parse('https://gael-cgu.vercel.app'));
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Conditions d'utilisation",style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),),
        backgroundColor:ThemeVariables.thirdColorBlack,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}