# masked_text

A package for masked texts, so if you want a mask for phone, or zip code or any kind of mask, just use it :D

## Getting Started

It's very simple, it's a Widget as all the other ones.

    new MaskedTextField
    (
        maskedTextFieldController: _textCPFController,
        mask: "xxx.xxx.xxx-xx",
        maxLength: 14,
        keyboardType: TextInputType.number,
        inputDecoration: new InputDecoration(
        hintText: "Write you Document here", labelText: "CPF"),
    );

'x' is the normal char that your text will have.

this sample reproduces something like this in the end: `111.111.111-11` (if you type all '1' of course, hehehe).

You can also change the escape character you want to use.

If you want to change it, you just need to fill the property `escapeCharacter` with the character you want.

Example:

    new MaskedTextField
    (
        maskedTextFieldController: _textCPFController,
        escapeCharacter: '#',
        mask: "###.###.###-##",
        maxLength: 14,
        keyboardType: TextInputType.number,
        inputDecoration: new InputDecoration(
        hintText: "Write you Document here", labelText: "CPF"),
    );

'x' is the default escape character.