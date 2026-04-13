import 'package:ashfoam_sadiq/src/data/local/database_service.dart';
import 'package:ashfoam_sadiq/src/services/cart_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/// Register all application services
void setupServiceLocator() {
  // Database Service
  getIt.registerSingleton<DatabaseService>(DatabaseService.instance);

  // Cart Service
  getIt.registerSingleton<CartService>(CartService());
}
