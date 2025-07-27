import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:in_porto/view/favorites/favorites_view.dart';
import 'package:in_porto/view/search/search_view.dart';
import 'package:in_porto/view/settings/settings_view.dart';

class ActionCenter extends StatefulWidget {
  const ActionCenter({super.key});

  @override
  State<ActionCenter> createState() => _ActionCenterState();
}

class _ActionCenterState extends State<ActionCenter> {
  Widget _selectedView = const SearchView();

  void _openFavoritesView() {
    setState(() {
      _selectedView = const FavoritesView();
    });
  }

  void _openSearchView() {
    setState(() {
      _selectedView = const SearchView();
    });
  }

  void _openSettingsView() {
    setState(() {
      _selectedView = const SettingsView();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25.0),
      child: OpenContainer(
        tappable: false,
        transitionType: ContainerTransitionType.fade,
        transitionDuration: const Duration(milliseconds: 500),
        closedElevation: 5,
        openElevation: 0,
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35.0),
        ),
        closedColor: Theme.of(context).colorScheme.surface,
        openColor: Theme.of(context).colorScheme.surface,
        closedBuilder: (context, action) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite_rounded,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {
                    _openFavoritesView();
                    action();
                  },
                ),
                InkWell(
                  onTap: () {
                    _openSearchView();
                    action();
                  },
                  borderRadius: BorderRadius.circular(25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        left: 40.0,
                        right: 40.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Search',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings_rounded,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {
                    _openSettingsView();
                    action();
                  },
                ),
              ],
            ),
          );
        },
        openBuilder: (context, action) {
          return _selectedView;
        },
      ),
    );
  }
}
