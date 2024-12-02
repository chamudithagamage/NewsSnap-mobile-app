
import 'package:flutter/material.dart';
import 'package:news_app/api_data/data.dart';
import 'package:news_app/models/categoryDetails.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryDetails> category = List.generate(0, (index) => CategoryDetails());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    category = getCategoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(

              width: 70, // Set a reasonable width for the image
              height: 70,
              child: Image.asset(
                'assets/images/playstore.png',
                fit: BoxFit.fill,
              ),
            ),
             Text("News"),
             Text(
              "Snap",
                style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 40.0,
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
          margin: EdgeInsets.only(right: 7),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),

                 child: Text(
                   categoryName,
                    style: TextStyle(
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
  final String imageUrl, title, desc;
  const newsCard({super.key,required this.imageUrl,required this.title,required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.network(imageUrl),
          Text(title),
          Text(desc),
        ],
      ),
    );
  }
}

