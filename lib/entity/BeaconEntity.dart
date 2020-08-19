class BeaconEntity {
  String _id;
  String _identity;
  String _message;
  int range;

  String get id => _id;
  String get identity => _identity;
  String get message => _message;

  set id(String value) {
    _id = value;
  }

  set message(String value) {
    _message = value;
  }

  set identity(String value) {
    _identity = value;
  }

  BeaconEntity(this._id, this._identity, this._message, this.range);
}