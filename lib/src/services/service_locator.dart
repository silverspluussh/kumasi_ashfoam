import 'package:ashfoam_sadiq/src/data/local/database_service.dart';
import 'package:ashfoam_sadiq/src/services/cart_service.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<DatabaseService>(DatabaseService.instance);

  getIt.registerSingleton<CartService>(CartService());

  getIt.registerSingleton<SupabaseClient>(Supabase.instance.client);
}
