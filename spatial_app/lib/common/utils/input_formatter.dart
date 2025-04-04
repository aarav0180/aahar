import 'package:flutter/services.dart';

import 'validator.dart';

abstract class InputFormatter {
  InputFormatter._();

  //match all strings that start with a letter
  static final TextInputFormatter inputLetterFormatters =
      FilteringTextInputFormatter(RegExp(r"[a-zA-Z]"), allow: true);

  static final digitsOnly = FilteringTextInputFormatter.digitsOnly;

  static final email = [
    FilteringTextInputFormatter.singleLineFormatter,
    LengthLimitingTextInputFormatter(Validator.emailMaxLength),
    FilteringTextInputFormatter.deny(RegExp(r"\s")),
  ];

  static final search = [
    FilteringTextInputFormatter.singleLineFormatter,
    FilteringTextInputFormatter.allow(RegExp(r"[A-Za-z0-9\-?,. ]")),
  ];

  static final password = [LengthLimitingTextInputFormatter(32)];

  static final allowAlphabetAndNumberInputFormatter = FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z0-9]"));

  static final allowAlphabetAndSpaceInputFormatter = FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"));

  static final allowUpperCaseAlphabetAndNumberInputFormatter = FilteringTextInputFormatter.allow(RegExp(r"[A-Z0-9]"));

  static final currency = [
    FilteringTextInputFormatter.singleLineFormatter
  ];

}
