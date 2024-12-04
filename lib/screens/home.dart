
import 'package:flutter/material.dart';
import 'package:news_app/api_data/data.dart';
import 'package:news_app/models/categoryDetails.dart';

import '../api_data/apiResponse.dart';
import '../models/articles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryDetails> category = List.generate(7, (index) => CategoryDetails());
  List<Articles> articles = List.generate(7, (index) => Articles());
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 70,
              height: 70,
              child: Image.asset(
                'assets/images/playstore.png',
                fit: BoxFit.fill,
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
            //category ribbon
            Container(
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
            ListView.builder(
              padding: EdgeInsets.only(top: 5),
              itemCount: articles.length,
                shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){
                  return newsCard(
                    imageUrl: articles[index].urlToImg,
                    title: articles[index].title,
                    desc: articles[index].description,
                  );
                }
            )
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
        //for later
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
  final String? imageUrl, title, desc;
  const newsCard({super.key, required this.imageUrl,required this.title,required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      // decoration: BoxDecoration(
      //   color: Colors.grey[300],
      //   borderRadius: BorderRadius.circular(15),
      // ),
      child: Column(
        children: <Widget>[
          Image.network(imageUrl!),
          Text(title!,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              height: 1
            ),
          ),
          Text(desc!),
        ],
      ),
    );
  }
}

