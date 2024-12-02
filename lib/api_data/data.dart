import 'package:news_app/models/categoryDetails.dart';

List<CategoryDetails> getCategoryDetails(){

  List<CategoryDetails> category = List.generate(0, (index) => CategoryDetails());
  CategoryDetails categoryDetails = new CategoryDetails();

  //giving news categories
  categoryDetails.categoryName = "Politics";
  category.add(categoryDetails);

  categoryDetails = new CategoryDetails();
  categoryDetails.categoryName = "Business";
  category.add(categoryDetails);

  categoryDetails = new CategoryDetails();
  categoryDetails.categoryName = "Entertainment";
  category.add(categoryDetails);

  categoryDetails = new CategoryDetails();
  categoryDetails.categoryName = "Sports";
  category.add(categoryDetails);

  categoryDetails = new CategoryDetails();
  categoryDetails.categoryName = "Weather";
  category.add(categoryDetails);

  categoryDetails = new CategoryDetails();
  categoryDetails.categoryName = "Health";
  category.add(categoryDetails);

  categoryDetails = new CategoryDetails();
  categoryDetails.categoryName = "Science";
  category.add(categoryDetails);

  return category;
}