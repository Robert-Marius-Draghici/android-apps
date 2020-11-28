import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app/model/recipe.dart';

class DbHelper {
  static final DbHelper _dbhelper = DbHelper._internal();
  String tblRecipe = "recipe";
  String colId = "id";
  String colTitle = "title";
  String colIngredients = "ingredients";
  String colSteps = "steps";
  String colDifficulty = "difficulty";
  String colDate = "date";

  DbHelper._internal();

  factory DbHelper() {
    return _dbhelper;
  }

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "recipes.db";
    var dbRecipes = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbRecipes;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $tblRecipe($colId INTEGER PRIMARY KEY, $colTitle TEXT, "
            "$colIngredients TEXT, $colSteps TEXT, $colDifficulty INTEGER, $colDate TEXT)");
  }

  void dropDb() async {
    await _db.execute("DROP TABLE $tblRecipe");
  }

  Future<int> insertRecipe(Recipe recipe) async {
    Database db = await this.db;
    var result = await db.insert(tblRecipe, recipe.toMap());
    return result;
  }

  Future<List> getRecipes() async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM $tblRecipe");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.db;
    var result = Sqflite.firstIntValue(
      await db.rawQuery("SELECT COUNT (*) FROM $tblRecipe")
    );
    return result;
  }

  Future<int> updateRecipe(Recipe recipe) async {
    var db = await this.db;
    var result = await db.update(tblRecipe, recipe.toMap(),
      where: "$colId = ?", whereArgs: [recipe.id]);
    return result;
  }

  Future<int> deleteRecipe(int id) async {
    int result;
    var db = await this.db;
    result = await db.rawDelete("DELETE FROM $tblRecipe WHERE $colId = $id");
    return result;
  }
}
