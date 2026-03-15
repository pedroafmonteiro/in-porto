import 'package:expressive_loading_indicator/expressive_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/view/search/widgets/results_card.dart';
import 'package:in_porto/view/search/widgets/search_filter_bar.dart';
import 'package:in_porto/viewmodel/search_viewmodel.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({super.key});

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchResultsAsync = ref.watch(searchResultsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Material(
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0.1,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              shape: RoundedSuperellipseBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).update(value);
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.search,
                border: InputBorder.none,
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight - 16.0),
          child: SearchFilterBar(),
        ),
      ),
      body: searchResultsAsync.when(
        data: (results) {
          if (results.isEmpty && _searchController.text.length >= 2) {
            return Center(
              child: Text(AppLocalizations.of(context)!.no_results),
            );
          }

          if (_searchController.text.length < 2) {
            return Center(
              child: Text(AppLocalizations.of(context)!.search_prompt),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 1,
              bottom: 8.0,
            ),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return ResultsCard(
                key: ValueKey(result.source),
                result: result,
              );
            },
          );
        },
        loading: () => Center(
          child: ExpressiveLoadingIndicator(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
