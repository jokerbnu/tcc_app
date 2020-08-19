import 'package:tccapp/entity/UF.dart';

class RegisterDto{
  String _name;
  String _phone;
  String _birthDate;
  String _email;
  String _password;
  String _city;
  String _neighborhood;
  String _street;
  int _number;
  String _complement;
  UF _uf;

  String get name => _name;
  String get phone => _phone;
  String get birthDate => _birthDate;
  String get email => _email;
  String get password => _password;
  String get city => _city;
  String get neighborhood => _neighborhood;
  int get number => _number;
  UF get uf => _uf;
  String get complement => _complement;

  RegisterDto(String name, String phone, String birthDate, String email,
      String password, String city, String neighborhood, String street,
      int number, String complement, UF uf) {
    _name = name;
    _phone = phone;
    _birthDate = birthDate;
    _email = email;
    _password = password;
    _city = city;
    _neighborhood = neighborhood;
    _street = street;
    _number = number;
    _complement = complement;
    _uf = uf;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': _name,
      'phone': _phone,
      'birthDate': _birthDate,
      'email': _email,
      'password': _password,
      'city': _city,
      'neighborhood': _neighborhood,
      'number': _number,
      'complement': _complement,
      'street': _street,
      'uf': _uf.toMap()
    };
  }
}