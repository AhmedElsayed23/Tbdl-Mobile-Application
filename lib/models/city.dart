class City {
  String _name;
  List<String> _districts;
  get name => this._name;

  set name(value) => this._name = value;

  get districts => this._districts;

  set districts(value) => this._districts = value;

  City({String name, List<String> districts})
      : _name = name,
        _districts = districts;
}
