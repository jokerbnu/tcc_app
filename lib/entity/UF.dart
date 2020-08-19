class UF {
  int _id;
  String _federativeUnit;
  String _description;

  int get id => _id;
  String get federativeUnit => _federativeUnit;
  String get description => _description;

  UF(int id, String federativeUnit, String description) {
    _id = id;
    _federativeUnit = federativeUnit;
    _description = description;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'federativeUnit': _federativeUnit,
      'description': _description
    };
  }
}