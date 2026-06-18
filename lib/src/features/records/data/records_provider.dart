import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/mock_data.dart';
import '../../../../models/fodder_distribution_model.dart';

final recordsProvider = StateProvider<List<FodderDistributionModel>>((ref) {
  return mockFodderRecords;
});
