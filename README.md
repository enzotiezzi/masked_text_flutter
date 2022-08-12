# masked_text

A package for masked texts, so if you want a mask for phone, or zip code or any kind of mask, just use it :D

## Getting Started

It's very simple, it's a Widget as all the other ones.

    MaskedTextField
    (
        maskedTextFieldController: _textCPFController,
        mask: "###.###.###-###",
        maxLength: 14,
        keyboardType: TextInputType.number,
        inputDecoration: new InputDecoration(
        hintText: "Write you Document here", labelText: "CPF"),
    );