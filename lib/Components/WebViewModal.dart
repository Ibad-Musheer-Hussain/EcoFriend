import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewModal extends StatefulWidget {
  @override
  _WebViewModalState createState() => _WebViewModalState();
  final String url;

  const WebViewModal({required this.url});
}

class _WebViewModalState extends State<WebViewModal> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: WebViewWidget(
        controller: _controller,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (String url) {
          print('Page finished loading: $url');
        },
      ));
  }
}
