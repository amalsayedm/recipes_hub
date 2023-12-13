import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeDetailsScreen extends StatefulWidget {
  final String reciepeLink;

  const RecipeDetailsScreen({super.key,required this.reciepeLink});




  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState(reciepeLink);

}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen>{
  late final WebViewController controller;
  var loadingPercentage = 0;
  final String reciepeLink;


  _RecipeDetailsScreenState(this.reciepeLink);

  @override
  void initState() {
    controller = WebViewController()
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(reciepeLink),
      ) ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Recipes Hub')
            ],
          ),
        ),
        body:Stack(
    children: [
    WebViewWidget(
    controller: controller,
    ),
    if (loadingPercentage < 100)
    LinearProgressIndicator(
    value: loadingPercentage / 100.0,
    ),
    ],
    ),);
  }
}