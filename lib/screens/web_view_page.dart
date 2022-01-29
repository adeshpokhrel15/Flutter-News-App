import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';





class WebDetailPage extends StatefulWidget {

  final String link;
  WebDetailPage(this.link);

  @override
  State<WebDetailPage> createState() => _WebDetailPageState();
}

class _WebDetailPageState extends State<WebDetailPage> {

double progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              LinearProgressIndicator(
                color: Colors.blue,
                backgroundColor: Colors.black,
                value: progress,
                minHeight: 7,
              ),
              Expanded(
                child: WebView(
                  initialUrl: widget.link,
                  javascriptMode: JavascriptMode.unrestricted,
                  onProgress: (val){
                   setState(() {
                     progress = val/100;
                   });
                  },
                ),
              ),
            ],
          ),
        )
    );
  }
}
