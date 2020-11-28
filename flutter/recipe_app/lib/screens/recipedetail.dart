import 'package:flutter/material.dart';
import 'package:recipe_app/model/recipe.dart';
import 'package:recipe_app/util/dbhelper.dart';
import 'package:intl/intl.dart';

DbHelper dbHelper = DbHelper();
final List<String> commands = const <String>[
  'Save Recipe & Back',
  'Delete Recipe',
  'Back to List'
];

const menuSave = 'Save Recipe & Back';
const menuDelete = 'Delete Recipe';
const menuBack = 'Back to List';

class RecipeDetail extends StatefulWidget {
  final Recipe recipe;
  RecipeDetail(this.recipe);

  @override
  State<StatefulWidget> createState() => RecipeDetailState(recipe);
}

class RecipeDetailState extends State {
  Recipe recipe;
  RecipeDetailState(this.recipe);

  final _difficulties = ["Simple", "Average", "Hard"];
  String _difficulty = "Average";

  TextEditingController titleController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  TextEditingController stepsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = recipe.title;
    ingredientsController.text = recipe.ingredients;
    stepsController.text = recipe.steps;

    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(recipe.title),
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: (value) => select(value),
                itemBuilder: (BuildContext context) {
                  return commands.map((String command) {
                    return PopupMenuItem<String>(
                      value: command,
                      child: Text(command),
                    );
                  }).toList();
                },
              ),
            ]),
        body: Padding(
            padding: EdgeInsets.only(top: 35.0, left: 10.0, right: 10.0),
            child: ListView(children: <Widget>[
              Column(
                children: <Widget>[
                  TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) => this.updateTitle(),
                    decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      child: TextField(
                        controller: ingredientsController,
                        style: textStyle,
                        maxLines: null,
                        onChanged: (value) => this.updateIngredients(),
                        decoration: InputDecoration(
                            labelText: "Ingredients",
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  Padding(
                      padding: EdgeInsets.only(bottom: 15.0),
                      child: TextField(
                        controller: stepsController,
                        style: textStyle,
                        maxLines: null,
                        onChanged: (value) => this.updateSteps(),
                        decoration: InputDecoration(
                            labelText: "Steps",
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      )),
                  ListTile(
                      title: DropdownButton<String>(
                    items: _difficulties.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    style: textStyle,
                    value: retrieveDifficulty(recipe.difficulty),
                    onChanged: (value) => convertDifficulty(value),
                  ))
                ],
              )
            ])));
  }

  void select(String value) async {

    switch (value) {
      case menuSave:
        save();
        break;
      case menuDelete:
        delete();
        break;
      case menuBack:
        Navigator.pop(context, true);
        break;
      default:
    }
  }

  void save() {

    recipe.date = new DateFormat.yMd().format(DateTime.now());

    if (recipe.id != null) {
      dbHelper.updateRecipe(recipe);
    } else {
      dbHelper.insertRecipe(recipe);
    }

    Navigator.pop(context, true);
  }

  void delete() async {

    int result;

    Navigator.pop(context, true);
    if (recipe.id == null) {
      return;
    }

    result = await dbHelper.deleteRecipe(recipe.id);

    if (result != 0) {
      AlertDialog alertDialog = AlertDialog(
        title: Text("Delete Recipe"),
        content: Text("The Recipe has been deleted"),
      );

      showDialog(context: context, builder: (_) => alertDialog);
    }
  }

  void convertDifficulty(String value) {
    switch (value) {
      case "Simple":
        recipe.difficulty = 1;
        break;
      case "Average":
        recipe.difficulty = 2;
        break;
      case "Hard":
        recipe.difficulty = 3;
        break;
    }

    setState(() {
      _difficulty = value;
    });
  }

  String retrieveDifficulty(int value) {
    return _difficulties[value - 1];
  }

  void updateTitle() {
    recipe.title = titleController.text;
  }

  void updateIngredients() {
    recipe.ingredients = ingredientsController.text;
  }

  void updateSteps() {
    recipe.steps = stepsController.text;
  }
}
