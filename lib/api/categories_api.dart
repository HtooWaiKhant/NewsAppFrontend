import 'package:frontend/api/api_util.dart';
import 'package:frontend/models/category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesApi {

  Future<List<Category>> fetchAllCategories() async{
    String allCategories = ApiUtil.MAIN_API_URL + ApiUtil.All_CATEGORIES;

    const Map<String, String> headers = {
    'Accept': 'application/json',
    };

    var response = await http.get(allCategories, headers: headers );
    List<Category> categories = [];

    if(response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      for(var item in body['data']) {
        Category category = Category.fromJson(item);
        categories.add(category);
      }
    }
    return categories;

  }

}