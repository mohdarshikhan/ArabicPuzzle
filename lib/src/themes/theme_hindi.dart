// Copyright 2020, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../core/puzzle_proxy.dart';
import '../core/util.dart';
import '../flutter.dart';
import '../shared_theme.dart';

const _accentBlue = Color(0xff000579);
const borderColor = Color.fromARGB(100, 11, 198, 249);
const themeColor = Color.fromARGB(100, 11, 198, 249);
const puzzleColor = Color.fromARGB(100, 11, 198, 249);
const buttonColor = Color.fromARGB(255, 4, 87, 153);

class ThemeHindi extends SharedTheme {
  @override
  String get name => 'Hindi';

  @override
  PuzzleType get puzzleType => PuzzleType.hindi;

  const ThemeHindi();

  @override
  Color get puzzleThemeBackground => themeColor;

  @override
  Color get puzzleBackgroundColor => puzzleColor;

  @override
  Color get puzzleAccentColor => _accentBlue;

  @override
  RoundedRectangleBorder puzzleBorder(bool small) => RoundedRectangleBorder(
    side: const BorderSide(
      // color: Color.fromARGB(255, 103, 103, 105),
      color: borderColor,
      width: 5,
    ),
    borderRadius: BorderRadius.all(
      Radius.circular(small ? 10 : 18),
    ),
  );

  @override
  Widget tileButton(int i, PuzzleProxy puzzle, bool small) {
    if (i == puzzle.tileCount) {
      assert(puzzle.solved);
      return const Center(
        child: Icon(
          Icons.thumb_up,
          size: 72,
          color: buttonColor,
        ),
      );
    }

    final correctPosition = puzzle.isCorrectPosition(i);

    final content = createInk(
      Center(
        child: Text(
          replaceHindiNumber((i + 1).toString()),
          // String.fromCharCode(i + 65), // A=65
          // (i + 1).toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: correctPosition ? FontWeight.bold : FontWeight.normal,
            fontSize: small ? 30 : 49,
          ),
        ),
      ),
    );

    return createButton(
      puzzle,
      small,
      i,
      content,
      color: buttonColor,
    );
  }
}
