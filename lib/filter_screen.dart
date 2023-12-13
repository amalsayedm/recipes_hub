import 'package:flutter/material.dart';
import 'package:recipes_hub/home_screen.dart';
import 'package:recipes_hub/models/category.dart';
import 'package:recipes_hub/public_var.dart';
import 'api_config/recipe_api.dart';
import 'models/recipe.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';


class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  bool _isLoading = false;
  bool isLoadingCategory = true;
  int mealindex = 1;


  _FilterScreenState(){
    getCategories();
    getUserInfo();
  }

  late List<Category> diets ;

  late  String meal;

  @override
  Future<void> searchMeal(int index) async {
    List<Recipe> recipes;
    recipes = await RecipeApi.getRecipe(index);
    setState(() {
      _isLoading = false;
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => HomeScreen(recipes),
      ));

    });

  }

  Future<void> getCategories() async {
    List<Category> categories;
    categories = await RecipeApi.getCategories();
    setState(() {
      isLoadingCategory = false;
      diets=categories;
      meal=categories[0].name;

    });

  }
  void getUserInfo() async {
    if(pref.getString("UserId") == null){
      String? result = await PlatformDeviceId.getDeviceId;
      print("amal $result");
      //send to server
      // save in sharerd
    }
  }
@override
  Widget build(BuildContext context) {
    /*
    Our build method returns Scaffold Container, which has a decoration
    image using a Network Image. The image loads and is the background of
    the page
    */
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
        'https://foolproofliving.com/wp-content/uploads/2020/05/Easy-Dinner-Recipes.jpg'),
            fit: BoxFit.cover,
          ),
        ),

        //Center widget and a container as a child, and a column widget
        child: Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: MediaQuery
                .of(context)
                .size
                .height * 0.55,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Text widget for our app's title
                const Text(
                  'Recipes Hub',
                  style: TextStyle(fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,color: Colors.black),
                ),
                SizedBox(height: 30),

                isLoadingCategory
                    ? const Center(child: CircularProgressIndicator()): Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //A RichText to style the target calories
                    //Simple drop down to select the type of diet
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: DropdownButtonFormField(
                        items: diets.map((data) {
                          return DropdownMenuItem(
                            value: data.name,
                            child: Text(
                              data.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18
                              ),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          labelText: 'Choose Meal',
                          labelStyle: TextStyle(fontSize: 18),
                        ),
                        onChanged: (value) {
                          setState(() {
                            (value) as String;
                            mealindex= diets.firstWhere((element) => element.name==value).catId;


                          });
                        },
                        value: meal,

                      ),
                    ),
                    //Space
                    SizedBox(height: 30),
                    //FlatButton where onPressed() triggers a function called _searchMealPlan
                    _isLoading
                        ? const Center(child: CircularProgressIndicator()):TextButton(style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                        // Set the padding
                        backgroundColor: Theme
                            .of(context)
                            .primaryColor,
                        // Set the background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              15), // Set the border radius
                        )),
                      child: Text(
                        'Search', style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                      //_searchMealPlan function is above the build method
                      onPressed:(){
                        setState(() {
                          _isLoading = true;
                          searchMeal(mealindex);
                        });
                      },
                    ),
                  ],
                ),

                //space

              ],
            ),
          ),
        ),
      ),
    );
  }
}