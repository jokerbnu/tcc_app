
import 'package:flutter/material.dart';
import 'package:tccapp/ui/list_beacon_page.dart';
import 'package:tccapp/ui/widget/TextFormFieldTCC.dart';

class BeaconPage extends StatefulWidget {
  final String id;

  BeaconPage({this.id});

  @override
  _BeaconPageState createState() => _BeaconPageState();
}

class _BeaconPageState extends State<BeaconPage> {
  String _rangeValue = '1';
  final _formKey = GlobalKey<FormState>();

  TextEditingController identityController = TextEditingController();
  TextEditingController mensagemController = TextEditingController();

  TextEditingController cidadeController = TextEditingController();
  TextEditingController bairroController = TextEditingController();
  TextEditingController ruaController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController numeroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Beacon"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check, color: Colors.white,),
            onPressed: _completeRegister,
          ),
          IconButton(
            icon: Icon(Icons.list, color: Colors.white,),
            onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListBeaconPage())); },
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
                      Text('Beacon:',
                        style: (TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 10.0),),
                  TextFormFieldTCC('Identificador *', identityController),
                  TextFormFieldTCC('Mensagem *', mensagemController),
                  Row (
                    children: <Widget>[
                      Text(
                        "Range: ",
                        style: TextStyle(fontSize: 15),
                      ),
                      Padding(padding: EdgeInsets.only(left: 8.0),),
                      DropdownButton<String>(
                        value: _rangeValue,
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            _rangeValue = newValue;
                          });
                        },
                        items: <String>['1', '2', '3']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ],
                  ),
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
    if (widget.id.isEmpty) {

    } else {

    }
  }
}
