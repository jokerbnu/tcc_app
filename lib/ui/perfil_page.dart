import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tccapp/dto/RegisterDto.dart';
import 'package:tccapp/entity/UF.dart';
import 'package:tccapp/ui/widget/TextFormFieldTCC.dart';
import 'package:tccapp/utils/parameters.dart';

final Parameters parameters = Parameters();

class PerfilPage extends StatefulWidget {
  final String id;

  PerfilPage({@required this.id});

  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  final _formKey = GlobalKey<FormState>();

  final maskFone = MaskTextInputFormatter(mask: "(##) #####-####", filter: {"#": RegExp(r'[0-9]')});
  final maskDataNascimento = MaskTextInputFormatter(mask: "##/##/####", filter: {"#": RegExp(r'[0-9]')});

  TextEditingController nomeController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController dataNascimentoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController cidadeController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Perfil"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check, color: Colors.white,),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _completeRegister();
                }
              },
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(10.0),
            child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Dados Pessoais:',
                            style: (TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                            ),),
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10.0),),
                      TextFormFieldTCC('Nome *', nomeController),
                      TextFormFieldTCC (
                          'Telefone *',
                          telefoneController,
                          textInputType: TextInputType.phone,
                          mask: maskFone
                      ),
                      TextFormFieldTCC (
                          'Data de Nascimento *',
                          dataNascimentoController,
                          textInputType: TextInputType.datetime,
                          mask: maskDataNascimento
                      ),
                      TextFormFieldTCC (
                          'Email *',
                          emailController,
                          textInputType: TextInputType.emailAddress
                      ),
                      TextFormFieldTCC('Senha *', senhaController, obscureText: true),
                      Padding(padding: EdgeInsets.only(top: 6.0),),
                      Divider(color: Colors.black,),
                      Padding(padding: EdgeInsets.only(top: 10.0),),
                      Row(
                        children: <Widget>[
                          Text('Endereço:',
                            style: (TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
                            ),),
                        ],
                      ),
                      TextFormFieldTCC('Cidade *', cidadeController),
                      TextFormFieldTCC('Bairro *', bairroController),
                      TextFormFieldTCC('Rua *', ruaController),
                      TextField(
                        controller: complementoController,
                        decoration: InputDecoration(
                            labelText: "Complemento"
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: .0),),
                      TextField(
                        keyboardType: TextInputType.number,
                        controller: numeroController,
                        decoration: InputDecoration(
                            labelText: "Número"
                        ),
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }

  void initState() {
    super.initState();
    _loadPerfil();
  }

  Future<void> _loadPerfil() async {
    Map<String, String> header = Map();
    header['Content-Type'] = 'application/json';

    http.Response response = await http.get('${parameters.basePath}/tcc/v1/user/${widget.id}',
        headers: header);

    if (response.statusCode == 200) {
      Map<String, dynamic> user = jsonDecode(response.body);

      setState(() {
        nomeController.text = user['name'];
        dataNascimentoController.text = user['birthDate'];
        telefoneController.text = user['phone'];
        emailController.text = user['email'];
        cidadeController.text = user['address']['city'];
        ruaController.text = user['address']['street'];
        complementoController.text = user['address']['complement'];
        bairroController.text = user['address']['neighborhood'];
        numeroController.text = user['address']['number'].toString();
      });
    }
  }

  Future<void> _completeRegister() async {
    if (_formKey.currentState.validate()){
      RegisterDto registerDto = RegisterDto(nomeController.text.trim(),
          telefoneController.text.trim().replaceAll('-', '').replaceAll(' ', '').replaceAll('(', '').replaceAll(')', ''),
          dataNascimentoController.text.trim(), emailController.text.trim(), senhaController.text.trim(),
          cidadeController.text.trim(), ruaController.text.trim(), bairroController.text.trim(), int.parse(numeroController.text.isEmpty ? 0 : numeroController.text),
          complementoController.text.trim(), UF(1, '', ''));

      Map<String, String> header = Map();
      header['Content-Type'] = 'application/json';
      var json = jsonEncode(registerDto.toMap());

      http.Response response = await http.put('${parameters.basePath}/tcc/v1/user/${widget.id}',
          headers: header, body: json);

      if (response.statusCode == HttpStatus.created) {
        print('registro finalizado');
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Cadastro'),
                content: Text('Cadastro realizado com sucesso!'),
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

        Navigator.of(context).pop();
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Cadastro'),
                content: Text('Não foi possível finalizar o cadastro, tente novamente mais tarde!'),
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
}
