import 'package:flutter/material.dart';
import 'package:news_app/api_data/data.dart';
import 'package:news_app/models/categoryDetails.dart';
import 'package:news_app/screens/article_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../api_data/apiResponse.dart';
import '../models/articles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryDetails> category = List.generate(7, (index) => CategoryDetails());
  List<Articles> articles = List.generate(0, (index) => Articles());
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = getCategoryDetails();
    getApiResponse();
  }

  //method to get api responses
  getApiResponse() async{
    ApiResponse apiResponse = ApiResponse();
    await apiResponse.getNews();
    debugPrint('up to here works');
    articles = apiResponse.news;

    //to check whether the response has received
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 70,
              height: 70,
              child: Image.asset(
                'assets/images/playstore.png',
                fit: BoxFit.contain,
              ),
            ),
             const Text(
              "News|snap",
                style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
      body: isLoading ? const Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10),

        child: Column(
          children: <Widget>[

            //category ribbon on the top
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 60.0,
              child: ListView.builder(
                itemCount: category.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                  return CategoryCard(
                    categoryName: category[index].categoryName,
                   );
                  }
              ),
            ),

            //news articles
            Container(
              color: Colors.white,
              child: SingleChildScrollView(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 5),
                      itemCount: articles.length,
                      shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                        return newsCard(
                          imageUrl: articles[index].urlToImg,
                          title: articles[index].title,
                          desc: articles[index].description,
                          articleUrl: articles[index].articleUrl,
                        );
                      }
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CategoryCard extends StatelessWidget {
  final String categoryName;
  const CategoryCard({super.key, required this.categoryName});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Navigator.push(
        //     context, MaterialPageRoute(
        //     builder: (context)=>ArticleView(
        //       articleUrl: ,
        //
        //   ))
        // );
      },
        child: Container(
          margin: const EdgeInsets.only(right: 7),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                child: Text(
                   categoryName,
                    style: const TextStyle(
                      fontSize: 15.0
                    ),
                 ),
              )
            ],
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
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
                child: Image.network(imageUrl!)
            ),
            SizedBox(height: 5,),
            Text(title!,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                height: 1.2
              ),
            ),
            SizedBox(height: 5,),
            Text(desc!),
          ],
        ),
      ),
    );
  }
}

