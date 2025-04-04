import 'package:spatial_app/common/translation/translations.dart';
import 'base_exception.dart';

class SomethingWentWrong extends BaseException {

  SomethingWentWrong() : super(LocaleKeys.somethingWentWrong.tr());

}