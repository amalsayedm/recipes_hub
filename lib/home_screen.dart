
import 'package:flutter/material.dart';
import 'package:recipes_hub/api_config/recipe_api.dart';
import 'package:recipes_hub/public_var.dart';
import 'package:recipes_hub/recipe_details_screen.dart';
import 'package:recipes_hub/widgets/recipe_card.dart';

import 'models/recipe.dart';

class HomeScreen extends StatefulWidget {
   List<Recipe> recipes;
  @override
  HomeScreenState createState() => HomeScreenState(recipes);

  HomeScreen(this.recipes, {super.key});
}

class HomeScreenState extends State<HomeScreen> {

  bool _isLoading = false;
 int currentPageIndex = 0;
  List<Recipe> recipes;


  HomeScreenState(this.recipes);
  @override
  void initState() {
    super.initState();
   // getRecipes();
  }

  Future<void> getFavRec() async {
    //if(pref.getString("UserId") != null){
      //String userId =pref.getString("UserId").toString();
      recipes = await RecipeApi.getFavourites('2');
      setState(() {
        _isLoading = false;
      });
    //}


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.restaurant_menu),
              SizedBox(width: 10),
              Text('Recipes Hub')
            ],
          ),
        ),
        body:<Widget>[listviewBuilder(recipes, context)
           ,_isLoading
              ? const Center(child: CircularProgressIndicator()):listviewBuilder(recipes, context)
        ][currentPageIndex],
      bottomNavigationBar: NavigationBar(destinations:const <Widget> [
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.home),
          label: 'Home',
        ), NavigationDestination(
          icon: Badge(child: Icon(Icons.favorite_sharp)),
          label: 'Favourites',
        ),
      ],
        onDestinationSelected: (int index) {
          setState(() {
            if (index ==1){
              getFavRec();
              _isLoading = true;
            }
            currentPageIndex = index;
          });
        },indicatorColor: Colors.blueGrey,
        selectedIndex: currentPageIndex,

      ),);
  }

  Widget listviewBuilder(List list, context){
    if(list.isEmpty){
      return Center(child:Text("Nothing Found"));
    }
    return  ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap:(){ Navigator.push(context, MaterialPageRoute(builder:  (context) => RecipeDetailsScreen(reciepeLink: list[index].linkUrl)));},
          child: RecipeCard(
              title: list[index].name,
              cookTime: list[index].totalTime,
              rating: list[index].rating.toString(),
              thumbnailUrl: list[index].images),
        );
      },
    );
  }
}