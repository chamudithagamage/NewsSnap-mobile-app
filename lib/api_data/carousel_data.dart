import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app/models/carousel_model.dart';


List<CarouselModel> getCarouselModel() {

  //const String apiUrl = ''
  List<CarouselModel> carousel = List.generate(0, (index) => CarouselModel());
  CarouselModel carouselModel = CarouselModel();

  //giving news categories
  carouselModel = CarouselModel();
  carouselModel.sliderHeading = "Business";
  carouselModel.sliderImageUrl = "assets/images/playstore.png";
  carousel.add(carouselModel);

  carouselModel = CarouselModel();
  carouselModel.sliderHeading = "Entertainment";
  carouselModel.sliderImageUrl = "assets/images/playstore.png";
  carousel.add(carouselModel);

  carouselModel = CarouselModel();
  carouselModel.sliderHeading = "Health";
  carouselModel.sliderImageUrl = "assets/images/playstore.png";
  carousel.add(carouselModel);


  return carousel;
}