export '../store_manager.dart';

import 'package:get_it/get_it.dart';

import '../store_manager.dart';


final getIt = GetIt.instance;

void setupDependency() {
  getIt.registerSingleton(const StoreManager());
}
