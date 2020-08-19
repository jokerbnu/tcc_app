class AccountDto {
  String _id;
  int _role;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  int get role => _role;

  set role(int value) {
    _role = value;
  }

  AccountDto(this._id, this._role);
}