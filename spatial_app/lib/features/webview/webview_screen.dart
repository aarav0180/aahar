import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../core/theme/app_theme.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String? title;

  const WebViewScreen({super.key, required this.url, required this.title});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  double loadingProgress = 0.0;

  late final WebViewController webViewController;

  @override
  void initState() {
    webViewController = WebViewController()
      ..setBackgroundColor(AppTheme.whiteColor)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (mounted) {
              setState(() {
                loadingProgress = progress.toDouble() / 100;
              });
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title != null ? Text(widget.title!) : null,
        //leading: const CrossIconButton(),
      ),
      body: Column(
        children: [
          if (loadingProgress < 1)
            LinearProgressIndicator(value: loadingProgress),
          Expanded(child: WebViewWidget(controller: webViewController)),
        ],
      ),
    );
  }
}
