import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// 3.0.2
class StripeWebView extends StatelessWidget {
  const StripeWebView({Key? key, required this.uri, required this.returnUri}) : super(key: key);

  final String uri;
  final Uri returnUri;

  @override
  Widget build(BuildContext context) {
    return WebView(
        initialUrl: uri,
        javascriptMode: JavascriptMode.unrestricted,
        navigationDelegate: (navigation) {
          final uri = Uri.parse(navigation.url);
          if (uri.scheme == returnUri.scheme &&
              uri.host == returnUri.host &&
              uri.queryParameters['requestId'] == returnUri.queryParameters['requestId']) {
            Navigator.pop(context, true);
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        });
  }
}

// 4.0.2
/*
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';

// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class StripeWebView extends StatefulWidget {
  const StripeWebView({Key? key, required this.uri, required this.returnUri}) : super(key: key);

  final String uri;
  final Uri returnUri;

  @override
  State<StripeWebView> createState() => _StripeWebViewState();
}

class _StripeWebViewState extends State<StripeWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
          ''');

          },
          onNavigationRequest: (request) {
            final uri = Uri.parse(request.url);
               if (uri.scheme == widget.returnUri.scheme &&
                   uri.host == widget.returnUri.host &&
                   uri.queryParameters['requestId'] == widget.returnUri.queryParameters['requestId']) {
                 Navigator.pop(context, true);
                 return NavigationDecision.prevent;
               }
               return NavigationDecision.navigate;
          },

        ),
      )
      ..loadRequest(Uri.parse(widget.uri));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}
*/
