import 'package:flutter/material.dart';
import 'package:news_app/api_data/carousel_data.dart';
import 'package:news_app/api_data/data.dart';
import 'package:news_app/models/categoryDetails.dart';
import 'package:news_app/screens/article_view.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../api_data/apiResponse.dart';
import '../models/articles.dart';
import '../models/carousel_model.dart';
import 'category_articles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryDetails> category = List.generate(7, (index) => CategoryDetails());
  List<Articles> articles = List.generate(0, (index) => Articles());
  List<CarouselModel> carouselSlider = [];
  bool isLoading = true;
  String image = "assets/image/playstore.png";
  int activeIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = getCategoryDetails();
    carouselSlider = getCarouselModel();
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
        shadowColor: Colors.black26,
        elevation: 10,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            //category ribbon on the top
            Container(
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(vertical: 10),
              height: 60.0,
              child: ListView.builder(
                itemCount: category.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index){
                    return CategoryCard(
                      categoryName: category[index].categoryName!,
                    );
                  }
              ),
            ),

            //carousel of trending news
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'Top News',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                  fontFamily: 'DMSerif',
                  fontSize: 20.0,
                ),
              ),
            ),
            CarouselSlider.builder(
                itemCount: carouselSlider.length, itemBuilder: (context,index, realIndex){
                    String? res = carouselSlider[index].sliderImageUrl;
                    String? res1 = carouselSlider[index].sliderHeading;
                    return carouselImage(res! , index, res1!);
                }, options: CarouselOptions(
                    height: 270,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index,reason){
                      setState(() {
                        activeIndex = index;
                      });
                  }
                ),
            ),


            //news articles
            SizedBox(height: 10,),

            Container(
              //color: Colors.white,
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
  Widget carouselImage(String imageUrl, int index, String title)=>Container(
    margin: EdgeInsets.symmetric(horizontal: 5),
    // color: Colors.grey,
    child: Stack(
      children: <Widget>[
         ClipRRect(
          borderRadius: BorderRadius.circular(20),
           child: Image.asset(
            imageUrl,
            height: 270,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Container(
          height: 250,
          padding: EdgeInsets.only(left: 10),
          margin: EdgeInsets.only(top: 150.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.circular(20)),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    ),
  );
}


class CategoryCard extends StatelessWidget {
  final String categoryName;
  const CategoryCard({super.key, required this.categoryName});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context, MaterialPageRoute(
              builder: (context)=> CategoryArticles(
               categoryTitle: categoryName,
              ),
            ),
        );
      },
        child: Container(
          margin: const EdgeInsets.only(right: 7),
          decoration: BoxDecoration(
            //color: Colors.grey[300],
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
        child: Material(
          elevation: 3,
          borderRadius: BorderRadius.circular(7),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
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

