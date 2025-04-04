import '../common/utils/utils.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

abstract class AppDirectory {
  static late String? _path;

  static String get path {
    if (_path == null) {
      throw Exception("path is not initialised yet!");
    }
    return _path!;
  }

  static Future<void> initPath() async {
    if (!Utils.isWeb) {
      final dir = await getApplicationDocumentsDirectory();
      _path = dir.path;
    }
  }
}
