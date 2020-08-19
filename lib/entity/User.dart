class User {
  String _id;
  String _email;
  String _name;
  int _role;

  String get id => _id;
  int get role => _role;
  String get email => _email;
  String get name => _name;

  set id(String value) {
    _id = value;
  }

  set email(String value) {
    _email = value;
  }

  set name(String value) {
    _name = value;
  }

  set role(int value) {
    _role = value;
  }

  User(this._id, this._email, this._name, this._role);
}