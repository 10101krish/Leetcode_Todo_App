import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:html/parser.dart' as parser;

class ScrapeDate extends StatefulWidget {
  const ScrapeDate({
    super.key,
    required this.link,
  });

  final String link;

  @override
  State<ScrapeDate> createState() => _ScrapeDateState();
}

class _ScrapeDateState extends State<ScrapeDate> {
  String _title = "";
  String _description = "";
  String _difficulty = "";

  void getWebsiteDate(String rawHtml) {
    var html = parser.parse(rawHtml);
    final headData = html.getElementsByTagName('head')[0];
    final flexClassData = html.getElementsByTagName('body')[0];
    String title = headData.children[7].text;
    String description = headData.children[10].attributes['content']!;
    final difficultyData = flexClassData
        .firstChild!
        .children[2]
        .firstChild!
        .firstChild!
        .children[3]
        .firstChild!
        .children[1]
        .firstChild!
        .firstChild!
        .firstChild!
        .children[1];
    String difficulty = difficultyData.firstChild!.text.toString();
    setState(() {
      _title = title;
      _description = description;
      _difficulty = difficulty;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WebViewWidget webViewWidget() {
      WebViewController webViewController = WebViewController();
      webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
      webViewController.loadRequest(Uri.parse(widget.link));
      webViewController.setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            Future.delayed(
              const Duration(seconds: 2, milliseconds: 500),
              () async {
                final html =
                    await webViewController.runJavaScriptReturningResult(
                        'new XMLSerializer().serializeToString(document)');
                getWebsiteDate(json.decode(html.toString()));
                // After extracting the title, pop the screen
              },
            );
          },
        ),
      );
      return WebViewWidget(controller: webViewController);
    }

    if (_title == "") {
      return Scaffold(
        appBar: AppBar(),
        floatingActionButton: Offstage(
          offstage: true,
          child: webViewWidget(),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            strokeAlign: 1,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.of(context).pop([
              _title,
              _description,
              _difficulty,
            ]),
            child: const Text("Done, Click Here"),
          ),
        ),
      );
    }
  }
}
