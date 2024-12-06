class CarouselModel{

  String? sliderHeading;
  String? sliderImageUrl;

  CarouselModel({this.sliderHeading, this.sliderImageUrl});

  factory CarouselModel.fromJson(Map<String, dynamic> json) {
    return CarouselModel(
      sliderHeading: json['title'],
      sliderImageUrl: json['urlToImage'],
    );
  }
}