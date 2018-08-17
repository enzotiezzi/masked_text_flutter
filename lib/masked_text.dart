library masked_text;

import 'package:flutter/material.dart';

class MaskedTextField extends StatefulWidget {
  final TextEditingController maskedTextFieldController;

  final String mask;
  final String escapeCharacter;

  final int maxLength;
  final TextInputType keyboardType;
  final InputDecoration inputDecoration;
  final FocusNode focusNode;

  final ValueChanged<String> onChange;

  const MaskedTextField({this.mask,
    this.escapeCharacter: "x",
    this.maskedTextFieldController,
    this.maxLength: 100,
    this.keyboardType: TextInputType.text,
    this.inputDecoration: const InputDecoration(),
    this.focusNode,
    this.onChange});

  @override
  State<StatefulWidget> createState() => new _MaskedTextFieldState();
}

class _MaskedTextFieldState extends State<MaskedTextField> {
  @override
  Widget build(BuildContext context) {
    var lastTextSize = 0;

    return new TextField(
      controller: widget.maskedTextFieldController,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      decoration: widget.inputDecoration,
      focusNode: widget.focusNode,
      onChanged: (String text) {
        // its deleting text
        if (text.length < lastTextSize) {
          if (widget.mask[text.length] != widget.escapeCharacter) {
            widget.maskedTextFieldController.selection =
            new TextSelection.fromPosition(new TextPosition(
                offset: widget.maskedTextFieldController.text.length));
          }
        } else {
          // its typing
          if (text.length >= lastTextSize) {
            var position = text.length;

            if ((widget.mask[position - 1] != widget.escapeCharacter) &&
                (text[position - 1] != widget.mask[position - 1])) {
              widget.maskedTextFieldController.text = _buildText(text);
            }

            if (widget.mask[position] != widget.escapeCharacter)
              widget.maskedTextFieldController.text =
              "${widget.maskedTextFieldController.text}${widget
                  .mask[position]}";
          }

          // Android on change resets cursor position(cursor goes to 0)
          // so you have to check if it reset, then put in the end(just on android)
          // as IOS bugs if you simply put it in the end
          if (widget.maskedTextFieldController.selection.start <
              widget.maskedTextFieldController.text.length) {
            widget.maskedTextFieldController.selection =
            new TextSelection.fromPosition(new TextPosition(
                offset: widget.maskedTextFieldController.text.length));
          }
        }

        // update cursor position
        lastTextSize = widget.maskedTextFieldController.text.length;

        if(widget.onChange != null) widget.onChange(widget.maskedTextFieldController.text);
      },
    );
  }

  String _buildText(String text) {
    var result = "";

    for (int i = 0; i < text.length - 1; i++) {
      result += text[i];
    }

    result += widget.mask[text.length - 1];
    result += text[text.length - 1];

    return result;
  }
}