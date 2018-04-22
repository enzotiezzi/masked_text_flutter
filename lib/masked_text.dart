library masked_text;

import 'package:flutter/material.dart';

class MaskedTextField extends StatefulWidget {
  String mask;
  TextEditingController maskedTextFieldController;

  int maxLength = 100;
  TextInputType keyboardType = TextInputType.text;
  InputDecoration inputDecoration = new InputDecoration();

  MaskedTextField(
      {this.mask,
      this.maskedTextFieldController,
      this.maxLength,
      this.keyboardType,
      this.inputDecoration});

  @override
  State<StatefulWidget> createState() => new _MaskedTextFieldState(
      mask: this.mask,
      maskedTextFieldController: this.maskedTextFieldController,
      maxLength: this.maxLength,
      keyboardType: this.keyboardType,
      inputDecoration: this.inputDecoration);
}

class _MaskedTextFieldState extends State<MaskedTextField> {
  String mask;
  TextEditingController maskedTextFieldController;

  int maxLength;
  TextInputType keyboardType;
  InputDecoration inputDecoration;

  _MaskedTextFieldState(
      {this.mask,
      this.maskedTextFieldController,
      this.maxLength,
      this.keyboardType,
      this.inputDecoration});

  @override
  Widget build(BuildContext context) {
    var lastTextSize = 0;

    return new TextField(
      controller: maskedTextFieldController,
      maxLength: maxLength,
      keyboardType: keyboardType,
      decoration: inputDecoration,
      onChanged: (String text) {
        // its deleting text
        if (text.length < lastTextSize) {
          if (mask[text.length] != 'x')
            maskedTextFieldController.text = text.substring(0, text.length - 1);
        }

        // its typing
        if (text.length >= lastTextSize) {
          var position = text.length;

          if (mask[position] != 'x')
            maskedTextFieldController.text =
                "${maskedTextFieldController.text}${mask[position]}";
        }

        // Android on change resets cursor position(cursor goes to 0)
        // so you have to check if it reseted, then put in the end(just on android)
        // as IOS bugs if you simply put it in the end
        if (maskedTextFieldController.selection.start <
            maskedTextFieldController.text.length) {
          maskedTextFieldController.selection = new TextSelection.fromPosition(
              new TextPosition(offset: maskedTextFieldController.text.length));
        }

        // update cursor position
        lastTextSize = text.length;
      },
    );
  }
}
