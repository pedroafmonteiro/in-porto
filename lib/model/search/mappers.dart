import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/model/search/searchable_item.dart';

class StopSearchableItem implements SearchableItem {
  final Stop stop;

  StopSearchableItem(this.stop);

  @override
  String get id => stop.id;

  @override
  String get primaryLabel => stop.name ?? '';

  @override
  String? get secondaryLabel => stop.code;

  @override
  List<String> get searchKeywords => [
        stop.name ?? '',
        stop.code ?? '',
      ];

  @override
  SearchResultType get type => SearchResultType.stop;

  @override
  Object get source => stop;
}

class RouteSearchableItem implements SearchableItem {
  final TransportRoute route;

  RouteSearchableItem(this.route);

  @override
  String get id => '${route.id}_${route.directionId}';

  @override
  String get primaryLabel => route.shortName ?? '';

  @override
  String? get secondaryLabel => route.tripHeadsign ?? route.longName;

  @override
  List<String> get searchKeywords => [
        route.shortName ?? '',
        route.longName ?? '',
        route.displayName ?? '',
        route.tripHeadsign ?? '',
        route.directionName ?? '',
      ];

  @override
  SearchResultType get type => SearchResultType.route;

  @override
  Object get source => route;
}
