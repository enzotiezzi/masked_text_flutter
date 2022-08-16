import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:masked_text/masked_text.dart';

void main() {
  testWidgets("Checking if the mask is working", (widgetTester) async {
    TextEditingController textEditingController = TextEditingController();

    await widgetTester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MaskedTextField(
          key: Key("maskedText"),
          controller: textEditingController,
          mask: "###.###.###-##",
        ),
      ),
    ));

    expect(find.byKey(Key("maskedText")), findsOneWidget);

    await widgetTester.enterText(find.byKey(Key("maskedText")), "43819771816");
    await widgetTester.pump();

    expect(textEditingController.text, "438.197.718-16");
  });
}