import '../translation/translations.dart';

abstract class Validator {
  Validator._();

  static const _emailValidationPattern = r"^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,10})+$";

  static const emailMaxLength = 64;

  static String? email(String? text, {bool isOptional = false}) {
    RegExp regExp = RegExp(_emailValidationPattern);
    if (text == null || text.isEmpty) {
      if (isOptional) return '';
      return LocaleKeys.requiredField.tr();
    }
    if (!regExp.hasMatch(text)) {
      return LocaleKeys.invalidEmail.tr();
    }
    return null;
  }

  static String? mobileNo(String text, String countryCode) {
    RegExp indiaRegex = RegExp(r'(^(?:[+0]9)?[0-9]{10}$)');
    RegExp internationalRegex = RegExp(r'(^(?:[+0])?[0-9]{7,15}$)');
    if (text.isEmpty) {
      return LocaleKeys.requiredField.tr();
    } else if (countryCode == "+91" && !indiaRegex.hasMatch(text)) {
      return LocaleKeys.invalidPhone.tr();
    } else if (countryCode != "+91" && !internationalRegex.hasMatch(text)) {
      return LocaleKeys.invalidPhone.tr();
    }
    return '';
  }

  static const passwordMinLength = 6;
  static const passwordMaxLength = 16;

  static String? password(String? pwd) {
    if (pwd == null || pwd.isEmpty) {
      return LocaleKeys.requiredField.tr();
    } else if (!RegExp(r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?!.*\s).{6,16}$").hasMatch(pwd)) {
      return LocaleKeys.invalidPassword.tr();
    }
    return null;
  }

  static String? required(String? text) {
    if (text == null || text.isEmpty) {
      return LocaleKeys.requiredField.tr();
    }
    return '';
  }

  static String? requiredDate(DateTime? text) {
    if (text == null) {
      return LocaleKeys.requiredField.tr();
    }
    return '';
  }

  static const nameMinLength = 3;
  static const nameMaxLength = 21;

  static String? name(
    String? value, {
    bool isNotFirstName = false,
    bool isOptional = false,
  }) {
    if (isOptional) return null;

    if (value == null || value.isEmpty) return LocaleKeys.requiredField.tr();

    final val = value.trim();
    if (!isNotFirstName && val.length < nameMinLength ) {
      return LocaleKeys.minLen.tr(args: [nameMinLength.toString()]);
    }
    if (val.isEmpty || !RegExp(r'^[a-z A-Z]+$').hasMatch(val.trim())) {
      return LocaleKeys.charsAndSpaceAllowed.tr();
    } else {
      return null;
    }
  }

  static const descriptionMaxLength = 3000;
  static const descriptionMinLength = 10;

  static String? description(String? desc) {
    if (desc == null || desc.isEmpty) {
      return LocaleKeys.requiredField.tr();
    }
    final descLen = desc.length;
    if (descLen < descriptionMinLength) {
      return LocaleKeys.minLen.tr(args: [descriptionMinLength.toString()]);
    }
    if (descLen > descriptionMaxLength) {
      return LocaleKeys.maxLen.tr(args: [descriptionMaxLength.toString()]);
    }
    return null;
  }
}
