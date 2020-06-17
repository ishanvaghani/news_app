import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FullArticle extends StatefulWidget {

  String url;

  FullArticle({this.url});

  @override
  _FullArticleState createState() => _FullArticleState();
}

class _FullArticleState extends State<FullArticle> {

  num position = 1;
  final key = UniqueKey();

  loading(String a) {
    setState(() {
      position = 1;
    });
  }

  doneLoading(String a) {
    setState(() {
      position = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('News'),
            SizedBox(width: 5,),
            Text('Paper', style: TextStyle(color: Colors.white),)
          ],
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: IndexedStack(
          index: position,
          children: <Widget>[
            WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              key: key,
              onPageStarted: loading,
              onPageFinished: doneLoading,
            ),
            Container(
              child: Center(
                  child: CircularProgressIndicator()),
            ),
          ],
        )
      ),
    );
  }
}
