import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newspaper/helper/data.dart';
import 'package:newspaper/helper/news.dart';
import 'package:newspaper/models/article_model.dart';
import 'package:newspaper/models/category_model.dart';
import 'package:newspaper/views/article.dart';
import 'package:newspaper/views/category_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = List<CategoryModel>();
  List<ArticleModel> articles = List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategoris();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
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
              //category
              Container(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },
                ),
              ),

              //blogs
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

class CategoryTile extends StatelessWidget {

  final imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryNews(category: categoryName.toString().toLowerCase(),)));
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 16, top: 16),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              child: CachedNetworkImage(imageUrl: imageUrl, width: 120, height: 60, fit: BoxFit.cover,),
              borderRadius: BorderRadius.circular(6),
            ),
            Container(
              width: 120,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),),
            )
          ],
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

