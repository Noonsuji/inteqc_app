
import 'package:flutter/material.dart';
import 'package:inteqc_app/utility/app_constant.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BodyWebviewpage extends StatefulWidget {
  final String url;
  const BodyWebviewpage({super.key, required this.url});

  @override
  State<BodyWebviewpage> createState() => _BodyWebviewpageState();
}

class _BodyWebviewpageState extends State<BodyWebviewpage> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => setState(() => isLoading = true),
          onPageFinished: (url) => setState(() => isLoading = false),
          onWebResourceError: (error) {
            debugPrint('Web error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ระบบลาออนไลน์"),titleTextStyle: AppConstant.headStyle(),),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
