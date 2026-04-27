import 'package:ashfoam_sadiq/src/features/inventory/services/excel_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final excelServiceProvider = Provider<ExcelService>((ref) {
  return ExcelService();
});
