import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newspaper/views/full_article.dart';

class ArticleView extends StatefulWidget {

  final String title, imageUrl, content, url;
  ArticleView({this.title, this.imageUrl, this.content, this.url});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(widget.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),),
              SizedBox(height: 8,),
              AspectRatio(
                aspectRatio: 1/1,
                child: CachedNetworkImage(imageUrl: widget.imageUrl, fit: BoxFit.cover,),
              ),
              SizedBox(height: 8,),
              Text(widget.content, style: TextStyle(fontSize: 17, color: Colors.black54),),
              SizedBox(height: 8,),
              FlatButton(
                child: Text('Read full article', style: TextStyle(fontSize: 18),),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FullArticle(url: widget.url,)));
                },
              )
            ],
          ),
        )
      ),
    );
  }
}
