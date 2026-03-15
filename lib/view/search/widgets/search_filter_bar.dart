import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/model/search/searchable_item.dart';
import 'package:in_porto/viewmodel/search_viewmodel.dart';

class SearchFilterBar extends ConsumerWidget {
  const SearchFilterBar({super.key});

  String _getLabel(BuildContext context, SearchResultType type) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case SearchResultType.stop:
        return l10n.stop;
      case SearchResultType.route:
        return l10n.route;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFilter = ref.watch(searchFiltersProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        spacing: 8.0,
        children: SearchResultType.values.map((type) {
          final isSelected = selectedFilter == type;
          return Material(
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 0.1,
            child: FilterChip(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              label: Text(_getLabel(context, type)),
              selected: isSelected,
              onSelected: (_) {
                ref.read(searchFiltersProvider.notifier).toggle(type);
              },
              showCheckmark: true,
            ),
          );
        }).toList(),
      ),
    );
  }
}
