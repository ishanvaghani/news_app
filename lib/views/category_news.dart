import 'package:flutter/material.dart';
import 'package:newspaper/helper/news.dart';
import 'package:newspaper/models/article_model.dart';

import 'article.dart';

class CategoryNews extends StatefulWidget {

  final String category;

  CategoryNews({this.category});

  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {

  List<ArticleModel> articles = List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoiesNews();
  }

  getCategoiesNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;

    setState(() {
      _loading = false;
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
      body: _loading ? Center(child: Container(child: CircularProgressIndicator(),)) :
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 16),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: articles.length,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index){
                      return BlogTile(
                        imageurl: articles[index].urlToImage,
                        title: articles[index].title,
                        desc: articles[index].description,
                        content: articles[index].content,
                        url: articles[index].url,
                      );
                    }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {

  final String imageurl, title, desc, content, url;

  BlogTile({@required this.imageurl, @required this.title, @required this.desc, @required this.content, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ArticleView(title: title, imageUrl: imageurl, content: content, url: url,)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          children: <Widget>[
            ClipRRect(
              child: Image.network(imageurl),
              borderRadius: BorderRadius.circular(6),
            ),
            SizedBox(height: 8,),
            Text(title, style: TextStyle(fontSize: 17, color: Colors.black87, fontWeight: FontWeight.bold),),
            SizedBox(height: 8,),
            Text(desc, style: TextStyle(fontSize: 17, color: Colors.black54),),
          ],
        ),
      ),
    );
  }
}
