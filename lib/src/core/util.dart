// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// import 'dart:convert';

import 'package:arabicpuzzle/src/core/puzzle_proxy.dart';
import 'package:arabicpuzzle/src/flutter.dart';

void requireArgument(bool truth, String argName, [String? message]) {
  if (!truth) {
    if (message == null || message.isEmpty) {
      message = 'value was invalid';
    }
    throw ArgumentError('`$argName` - $message');
  }
}

void requireArgumentNotNull(argument, String argName) {
  if (argument == null) {
    throw ArgumentError.notNull(argName);
  }
}

// Logic from
// https://www.cs.bham.ac.uk/~mdr/teaching/modules04/java2/TilesSolvability.html
// Used with gratitude!
bool isSolvable(int width, List<int> list) {
  final height = list.length ~/ width;
  assert(width * height == list.length);
  final inversions = _countInversions(list);

  if (width.isOdd) {
    return inversions.isEven;
  }

  final blankRow = list.indexOf(list.length - 1) ~/ width;

  if ((height - blankRow).isEven) {
    return inversions.isOdd;
  } else {
    return inversions.isEven;
  }
}

int _countInversions(List<int> items) {
  final tileCount = items.length - 1;
  var score = 0;
  for (var i = 0; i < items.length; i++) {
    final value = items[i];
    if (value == tileCount) {
      continue;
    }

    for (var j = i + 1; j < items.length; j++) {
      final v = items[j];
      if (v != tileCount && v < value) {
        score++;
      }
    }
  }
  return score;
}

String replaceFarsiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);
  }

  return input;
}

String replaceHindiNumber(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const hindi = ['०', '१', '२', '३', '४', '५', '६', '७', '८', '९'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], hindi[i]);
  }

  return input;
}

String getNumber(int number, PuzzleType type) {
  if (type == PuzzleType.arabic) {
    return replaceFarsiNumber(number.toString());
  } else if (type == PuzzleType.hindi) {
    return replaceHindiNumber(number.toString());
  } else {
    return number.toString();
  }
}

String getText(String text, PuzzleType type, String prefixText) {

  // if (prefixText.isNotEmpty) {
  //   return prefixText +" "+text;
  // } else {
  //   return text;
  // }


  // Todo handle text according language
  if (type == PuzzleType.arabic && text == " Tiles left") {
    return prefixText+" ترك البلاط";
  } else if (type == PuzzleType.arabic && text == " Moves") {
    return prefixText+" التحركات";
  } else if (type == PuzzleType.hindi && text == " Tiles left") {
    return prefixText +" टाइलें बची हैं ";
  } else if (type == PuzzleType.hindi && text == " Moves") {
    return prefixText +" चालें ";
  } else {
    return prefixText +" "+text;
  }
}

TextSpan getTextSpan(int incorrectTiles, String text, PuzzleType type, TextStyle _infoStyle) {
  if (type == PuzzleType.arabic) {
    return TextSpan(
      children: [
        // TextSpan(text: getText(text, type, ""),
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontWeight: FontWeight.normal,
        //     )
        // ),
        TextSpan(
          text: getText(text, type, getNumber(incorrectTiles, type)), //controls.incorrectTiles.toString(),
          style: _infoStyle,
        ),
      ],
    );
  } else {
    return TextSpan(
      children: [
        TextSpan(
          text: getText(text, type, getNumber(incorrectTiles, type)), //controls.incorrectTiles.toString(),
          style: _infoStyle,
        ),
        // TextSpan(text: getText(text, type, ),
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontWeight: FontWeight.normal,
        //     )
        // ),
      ],
    );
  }
}

RichText getRichText(int incorrectTiles, String text, PuzzleType type, TextStyle _infoStyle){
  if (type == PuzzleType.arabic) {
    return RichText(
        textAlign: TextAlign.right,
        text: getTextSpan(incorrectTiles, text, type, _infoStyle)
    );
  } else {
    return RichText(
        textAlign: TextAlign.right,
        text: getTextSpan(incorrectTiles, text, type, _infoStyle)
    );
  }
}

String getBackgroundImage(PuzzleType type) {
  if (type == PuzzleType.arabic) {
    return 'images/flutter.jpg';
  } else if (type == PuzzleType.hindi) {
    return 'images/flutter.jpg';
  } else {
    return 'images/flutter.jpg';
  }
}