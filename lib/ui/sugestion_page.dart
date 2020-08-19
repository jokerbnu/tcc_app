import 'package:flutter/material.dart';
import 'package:tccapp/ui/list_sugestion_page.dart';
import 'package:tccapp/ui/widget/TextFormFieldTCC.dart';

class SugestionPage extends StatefulWidget {
  @override
  _SugestionPageState createState() => _SugestionPageState();
}

class _SugestionPageState extends State<SugestionPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController cidadeController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova sugestão"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check, color: Colors.white,),
            onPressed: _completeRegister,
          ),
          IconButton(
            icon: Icon(Icons.list, color: Colors.white,),
            onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListSugestionPage())); },
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
                      Text('Sugestão:',
                        style: (TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10.0),),
                  TextFormFieldTCC('Descrição *', cidadeController),
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
                  Padding(padding: EdgeInsets.only(top: 4.0),),
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
        ),
      ),
    );
  }

  void _completeRegister() {

  }
}
