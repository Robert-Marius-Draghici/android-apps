class Recipe {
  int _id;
  String _title;
  String _ingredients;
  String _steps;
  int _difficulty;
  String _date;

  Recipe(this._title, this._ingredients, this._steps, this._difficulty, [this._date]);
  Recipe.withId(this._id, this._title, this._ingredients, this._steps, this._difficulty,
      [this._date]);

  int get id => _id;
  String get title => _title;
  String get ingredients => _ingredients;
  String get steps => _steps;
  int get difficulty => _difficulty;
  String get date => _date;

  set title(String value) {
    if (value.length <= 100) {
      _title = value;
    }
  }

  set ingredients(String value) {
    _ingredients = value;
  }

  set steps(String value) {
    _steps = value;
  }

  set difficulty(int value) {
    _difficulty = value;
  }

  set date(String value) {
    _date = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["title"] = _title;
    map["ingredients"] = _ingredients;
    map["steps"] = _steps;
    map["difficulty"] = _difficulty;
    map["date"] = _date;

    if (_id != null) {
      map["id"] = _id;
    }

    return map;
  }

  Recipe.fromObject(dynamic o) {
    this._id = o["id"];
    this._title = o["title"];
    this._ingredients = o["ingredients"];
    this._steps = o["steps"];
    this._difficulty = o["difficulty"];
    this._date = o["date"];
  }
}
