import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/articles.dart';
 import '../api_data/apiResponse.dart';
import 'article_view.dart';

class CategoryArticles extends StatefulWidget {
  final String categoryTitle;
  CategoryArticles({super.key, required this.categoryTitle});

  @override
  State<CategoryArticles> createState() => _CategoryArticlesState();
}

class _CategoryArticlesState extends State<CategoryArticles> {

  List<Articles> categoryArticles = List.generate(0, (index) => Articles());
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async{
    SortByCategory categoryResponse = SortByCategory();
    await categoryResponse.getCategoryNews(widget.categoryTitle);
    debugPrint('up to here works');
    categoryArticles = categoryResponse.categoryNews;

    //to check whether the response has received
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 3,
        shadowColor: Colors.black26,
        centerTitle: true,
          title: Text(
             '${widget.categoryTitle}|snap',
             style: const TextStyle(
               color: Colors.teal,
             ),
         ),
      ),

      body: isLoading ? Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              SingleChildScrollView(
                child: ListView.builder(
                    padding: EdgeInsets.only(top: 5),
                    itemCount: categoryArticles.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context,index){
                      return newsCard(
                        imageUrl: categoryArticles[index].urlToImg,
                        title: categoryArticles[index].title,
                        desc: categoryArticles[index].description,
                        articleUrl: categoryArticles[index].articleUrl,
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class newsCard extends StatelessWidget {
  final String? imageUrl, title, desc, articleUrl;
  const newsCard({super.key, required this.imageUrl,required this.title,required this.desc, required this.articleUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, MaterialPageRoute(
            builder: (context)=>ArticleView(
              articleUrl: articleUrl!,
            )
        ),
        );
      },

      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(7),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.network(imageUrl!)
                ),
                SizedBox(height: 5,),
                Text(title!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      height: 1.2
                  ),
                ),
                SizedBox(height: 5,),
                Text(desc!,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
