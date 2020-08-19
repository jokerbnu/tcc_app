import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Widget TextFormFieldTCC(String label, TextEditingController controller,
    {TextInputType textInputType = TextInputType.text, bool obscureText = false,
    MaskTextInputFormatter mask = null, bool autovalidate = true}){
  if (mask != null)
    return Column(
      children: <Widget>[
        TextFormField(
          enabled: true,
          obscureText: obscureText,
          keyboardType: textInputType,
          validator: (value) { return validateField(value); },
          inputFormatters: [mask],
          controller: controller,
          decoration: InputDecoration(
              labelText: label
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 4.0),),
      ],
    );
  else
    return Column(
      children: <Widget>[
        TextFormField(
          enabled: true,
          obscureText: obscureText,
          keyboardType: textInputType,
          validator: (value) { return validateField(value); },
          controller: controller,
          decoration: InputDecoration(
              labelText: label
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 3.0),),
      ],
    );
}

String validateField(value) {
  if (value.isEmpty)
    return 'Campo obrigatório';

  return null;
}