import 'package:news_app/models/categoryDetails.dart';

List<CategoryDetails> getCategoryDetails(){

  List<CategoryDetails> category = List.generate(0, (index) => CategoryDetails());
  CategoryDetails categoryDetails = CategoryDetails();

  //giving news categories
  categoryDetails.categoryName = "Politics";
  category.add(categoryDetails);

  categoryDetails = CategoryDetails();
  categoryDetails.categoryName = "Business";
  category.add(categoryDetails);

  categoryDetails = CategoryDetails();
  categoryDetails.categoryName = "Entertainment";
  category.add(categoryDetails);

  categoryDetails = CategoryDetails();
  categoryDetails.categoryName = "Sports";
  category.add(categoryDetails);

  categoryDetails = CategoryDetails();
  categoryDetails.categoryName = "Weather";
  category.add(categoryDetails);

  categoryDetails = CategoryDetails();
  categoryDetails.categoryName = "Health";
  category.add(categoryDetails);

  categoryDetails = CategoryDetails();
  categoryDetails.categoryName = "Science";
  category.add(categoryDetails);

  return category;
}