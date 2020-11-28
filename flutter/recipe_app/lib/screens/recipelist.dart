import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/util/dbhelper.dart';
import 'package:recipe_app/screens/recipedetail.dart';

class RecipeList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RecipeListState();
}

class RecipeListState extends State {
  DbHelper dbHelper = DbHelper();
  List<Recipe> recipes;
  int count = 0;

  void getData() {
    final dbFuture = dbHelper.initializeDb();
    dbFuture.then((result) {
      final recipesFuture = dbHelper.getRecipes();
      recipesFuture.then((result) {
        List<Recipe> recipeList = List<Recipe>();
        count = result.length;

        for (int i = 0; i < count; i++) {
          recipeList.add(Recipe.fromObject(result[i]));
          debugPrint(recipeList[i].title);
        }

        setState(() {
          recipes = recipeList;
          count = count;
        });
        debugPrint("Items " + count.toString());
      });
    });
  }

  ListView recipeListItems() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                  backgroundColor: getColor(this.recipes[position].difficulty),
                  child: Text(this.recipes[position].difficulty.toString())),
              title: Text(this.recipes[position].title),
              subtitle: Text(this.recipes[position].date),
              onTap: () {
                debugPrint("Tapped on " + this.recipes[position].id.toString());
                navigateToDetail(this.recipes[position]);
              },
            ),
          );
        });
  }

  Color getColor(int difficulty) {
    switch (difficulty) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.red;
      default:
        return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (recipes == null) {
      recipes = List<Recipe>();
      getData();
    }

    return Scaffold(
      body: recipeListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetail(Recipe('', '', '', 1));
        },
        tooltip: "Add new recipe",
        child: new Icon(Icons.add),
      ),
    );
  }

  void navigateToDetail(Recipe recipe) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecipeDetail(recipe)));

    if (result) {
      getData();
    }
  }
}
