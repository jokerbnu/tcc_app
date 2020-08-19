import 'package:flutter/material.dart';
import 'package:tccapp/dto/AccountDto.dart';
import 'package:tccapp/ui/beacon_page.dart';
import 'package:tccapp/ui/perfil_page.dart';
import 'package:tccapp/ui/sugestion_page.dart';

Widget MenuTCC(BuildContext context, { AccountDto accountDto }) {
  var listaWidgets = List<Widget>();

  listaWidgets.add(
      ListTile(
        title: Text('Perfil'),
        trailing: Icon(Icons.person),
        onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => PerfilPage(id: accountDto.id,))); },
      )
  );

  listaWidgets.add(
      ListTile(
        title: Text('Sugestão'),
        trailing: Icon(Icons.receipt),
        onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => SugestionPage())); },
      )
  );

  if (accountDto.role == 1) {
    listaWidgets.add(
        ListTile(
          title: Text('Beacon'),
          trailing: Icon(Icons.wifi_tethering),
          onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => BeaconPage())); },
        )
    );
  }

  return ListView(
    children: listaWidgets
  );
}