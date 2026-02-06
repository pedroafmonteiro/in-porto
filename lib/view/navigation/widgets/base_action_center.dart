import 'package:flutter/material.dart';
import 'package:in_porto/view/search/search_view.dart';
import 'package:in_porto/view/favorites/favorites_view.dart';
import 'package:in_porto/view/settings/settings_view.dart';
import 'package:in_porto/l10n/app_localizations.dart';

class BaseActionCenter extends StatelessWidget {
  final VoidCallback onOpen;
  final VoidCallback? onClose;
  final ValueChanged<Widget> onSelected;

  const BaseActionCenter({
    super.key,
    required this.onSelected,
    required this.onOpen,
    this.onClose,
  });

  void _openFavoritesView() {
    onSelected(const FavoritesView());
    onOpen();
  }

  void _openSearchView() {
    onSelected(const SearchView());
    onOpen();
  }

  void _openSettingsView() {
    onSelected(const SettingsView());
    onOpen();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: _openFavoritesView,
          icon: Icon(
            Icons.favorite_rounded,
          ),
          tooltip: "Favorites",
        ),
        InkWell(
          onTap: _openSearchView,
          borderRadius: BorderRadius.circular(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    AppLocalizations.of(context)!.search,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        IconButton(
          onPressed: _openSettingsView,
          icon: const Icon(Icons.settings_rounded),
          tooltip: AppLocalizations.of(context)!.settingsTitle,
        ),
      ],
    );
  }
}
