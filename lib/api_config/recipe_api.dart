import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipes_hub/models/category.dart';
import 'package:recipes_hub/models/recipe.dart';

class RecipeApi {

  static Future<List<Recipe>> getRecipe(int type) async {
    var uri = Uri.http('theamalsayed.tech','/Reciepes_hub/api/v1/recipes/$type',);
    final response = await http.get(uri);
    List data = jsonDecode(response.body);
    return Recipe.recipesFromSnapshot(data);
  }

  static Future<List<Category>> getCategories() async {
    var uri = Uri.http('theamalsayed.tech','/Reciepes_hub/api/v1/categories',);
    final response = await http.get(uri);
    List data = jsonDecode(response.body);
    return Category.CategoryFromSnapshot(data);
  }

  static Future<List<Recipe>> getFavourites(String userId) async {
    var uri = Uri.http('theamalsayed.tech','/Reciepes_hub/api/v1/recipes/$userId',);
    final response = await http.get(uri);
    List data = jsonDecode(response.body);
    return Recipe.recipesFromSnapshot(data);
  }
}