import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:news_app/models/carousel_model.dart';
import '../api_key.dart';
import 'package:http/http.dart' as http;

class CarouselData{
  List<CarouselModel> carouselNews = [];
  String? articleUrl;
  CarouselData({this.articleUrl});


  Future<void> getCarouselData() async{
    final apiKey = ApiKey.apiKey;
    String apiUrl = 'https://newsapi.org/v2/top-headlines?category=general&apiKey=$apiKey';

    try {
      var response = await http.get(Uri.parse(apiUrl));
      //jsonData
      var responseJson = jsonDecode(response.body);

      if (responseJson['status'] == "ok" && responseJson['articles'] != null) {
        responseJson["articles"].forEach((element) {
          if (["urlToImage"] != null && element["description"] != null && element["title"] != null && element["url"] != null) {

            CarouselModel carouselModel = CarouselModel(
              sliderHeading: element['title'] ?? 'No title available',
              sliderAuthor: element['author']?? 'Unknown author',
              sliderDescription: element['description']?? '',
              sliderArticleUrl: element['url']?? '',
              sliderImageUrl: element['urlToImage']?? '',
              sliderContent: element['content']?? '',

            );
            carouselNews.add(carouselModel);
          }else{
            print('Article image and description is not available');
          }
        }
        );
      }
    }catch (e){
      debugPrint("Error fetching carousel data $e");
    }
  }
}