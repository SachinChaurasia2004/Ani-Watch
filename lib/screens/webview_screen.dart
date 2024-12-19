import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewScreen extends StatefulWidget {
  final String initialUrl;

  const WebViewScreen({super.key, required this.initialUrl});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${error.description}')),
            );
          },
          onNavigationRequest: (NavigationRequest request) async {
            final allowedDomains = [
              'anitaku.bz',
              's3embtaku.pro',
              'ggredi.info',
            ];

            if (allowedDomains.any((domain) => request.url.contains(domain))) {
              final Uri downloadUri = Uri.parse(request.url);

              if (await canLaunchUrl(downloadUri)) {
                await launchUrl(downloadUri,
                    mode: LaunchMode.externalApplication);
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Navigation to this URL is not allowed'),
                  duration: Duration(seconds: 2),
                ),
              );
              return NavigationDecision.prevent;
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  Future<bool> _handleBackPressed() async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: _handleBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            WebViewWidget(controller: _controller),
          ],
        ),
      ),
    );
  }
}
