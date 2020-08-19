import 'package:flutter/material.dart';
import 'package:tccapp/dto/AccountDto.dart';
import 'package:tccapp/ui/home_page.dart';
import 'package:tccapp/ui/register_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 45.0)),
                Image(
                  image: AssetImage('assets/logo.png'),
                ),
                Padding(padding: EdgeInsets.only(bottom: 35.0),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Email"
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0),),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: "Senha"
                      ),
                      obscureText: true,
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0),),
                    RaisedButton(
                      child: Text('Entrar'),
                      color: Colors.blueAccent,
                      onPressed: _login,
                    ),
                    FlatButton(
                      child: Text('Não possui conta ainda? Clique aqui para se cadastrar.'),
                      onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterPage())); },
                    )
                  ],
                ),
              ],
            ),
          )
      )
    );
  }

  Future<void> _login() async {
    Map<String, String> header = Map();
    header['Content-Type'] = 'application/json';

    var json = jsonEncode({'email': emailController.text.trim(), 'password': passwordController.text.trim()});

    http.Response response = await http.post('http://192.168.0.13:8081/tcc/v1/account/login', headers: header, body: json);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);

      var accountDto = AccountDto(body['id'], body['role']);

      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage(accountDto: accountDto,)));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Autenticação'),
            content: Text('Usuário e/ou senha incorretos.'),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
    }
  }
}
