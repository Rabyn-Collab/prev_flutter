import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



class DetailPage extends StatefulWidget {

  final String link;
  DetailPage(this.link);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              LinearProgressIndicator(
                color: Colors.red,
                value: progress,
              ),
              Expanded(
                child: WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: widget.link,
                  onProgress: (val){
                     setState((){
                        progress = val / 100;
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
