import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/model/entities/stop.dart';
import 'package:in_porto/view/stops/widgets/stop_details_app_bar_title.dart';
import 'package:in_porto/view/stops/widgets/stop_filter_bar.dart';
import 'package:in_porto/view/stops/widgets/stop_schedules_list.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';

class StopDetails extends ConsumerStatefulWidget {
  const StopDetails({super.key, required this.stop});

  final Stop stop;

  @override
  ConsumerState<StopDetails> createState() => _StopDetailsState();
}

class _StopDetailsState extends ConsumerState<StopDetails> {
  final ScrollController _scrollController = ScrollController();
  Timer? _refreshTimer;
  bool _showOlderDepartures = false;
  bool _showFab = false;
  Set<String> selectedRouteIds = {};
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;
      final now = DateTime.now();
      final isToday =
          selectedDate.year == now.year &&
          selectedDate.month == now.month &&
          selectedDate.day == now.day;

      final isScrollingAway = _scrollController.offset.abs() > 200 && isToday;
      if (isScrollingAway != _showFab) {
        setState(() {
          _showFab = isScrollingAway;
        });
      }
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stop = widget.stop;
    final asyncSchedules = ref.watch(stopSchedulesProvider(stop, selectedDate));
    final asyncRoutes = ref.watch(stopRoutesProvider(stop));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: StopDetailsAppBarTitle(stop: stop),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight - 16.0),
          child: StopFilterBar(
            asyncRoutes: asyncRoutes,
            selectedRouteIds: selectedRouteIds,
            selectedDate: selectedDate,
            onRouteToggle: (routeId) {
              setState(() {
                if (selectedRouteIds.contains(routeId)) {
                  selectedRouteIds.remove(routeId);
                } else {
                  selectedRouteIds.add(routeId);
                }
                _showOlderDepartures = false;
                _showFab = false;
              });
            },
            onClearFilters: () {
              setState(() {
                selectedRouteIds.clear();
                _showOlderDepartures = false;
                _showFab = false;
              });
            },
            onDateChanged: (date) {
              setState(() {
                selectedDate = date;
                _showOlderDepartures = false;
                _showFab = false;
              });
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StopSchedulesList(
              asyncSchedules: asyncSchedules,
              asyncRoutes: asyncRoutes,
              selectedRouteIds: selectedRouteIds,
              selectedDate: selectedDate,
              showOlderDepartures: _showOlderDepartures,
              scrollController: _scrollController,
              onShowOlderDepartures: () {
                setState(() {
                  _showOlderDepartures = true;
                });
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.animateTo(
                      -150.0,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                    );
                  }
                });
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _showFab
          ? FloatingActionButton.extended(
              onPressed: () async {
                if (!_scrollController.hasClients) return;
                await _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
                if (mounted &&
                    _scrollController.hasClients &&
                    _scrollController.offset.abs() < 1) {
                  setState(() {
                    _showOlderDepartures = false;
                  });
                }
              },
              label: Text(AppLocalizations.of(context)!.now),
              icon: Icon(
                (_scrollController.hasClients && _scrollController.offset > 0)
                    ? Icons.arrow_upward_rounded
                    : Icons.arrow_downward_rounded,
              ),
            )
          : null,
    );
  }
}
