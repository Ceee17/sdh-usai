import 'package:uas/listdata/food_data.dart';
import 'package:uas/listdata/zone_data.dart';
import 'package:uas/models/Searchable.dart';

final List<Searchable> mixedList = [
  ...Foods,
  ...zoneData,
];
