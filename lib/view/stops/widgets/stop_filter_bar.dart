import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/model/entities/route.dart';
import 'package:in_porto/view/common/route_badge.dart';
import 'package:in_porto/view/common/date_picker_badge.dart';

class StopFilterBar extends StatelessWidget {
  const StopFilterBar({
    super.key,
    required this.asyncRoutes,
    required this.selectedRouteIds,
    required this.selectedDate,
    required this.onRouteToggle,
    required this.onClearFilters,
    required this.onDateChanged,
  });

  final AsyncValue<List<TransportRoute>> asyncRoutes;
  final Set<String> selectedRouteIds;
  final DateTime selectedDate;
  final Function(String) onRouteToggle;
  final VoidCallback onClearFilters;
  final Function(DateTime) onDateChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        spacing: 8.0,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                child: asyncRoutes.when(
                  data: (routes) => Row(
                    spacing: 4.0,
                    children: [
                      if (selectedRouteIds.isNotEmpty)
                        GestureDetector(
                          onTap: onClearFilters,
                          child: const Icon(
                            Icons.close_rounded,
                          ),
                        ),
                      ...routes.map(
                        (route) {
                          final isSelected = selectedRouteIds.contains(
                            route.id,
                          );
                          final isSubtle =
                              selectedRouteIds.isNotEmpty && !isSelected;

                          return GestureDetector(
                            onTap: () => onRouteToggle(route.id),
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 200),
                              opacity: isSubtle ? 0.3 : 1.0,
                              child: RouteBadge(
                                number: route.shortName,
                                color: route.color,
                                textColor: route.textColor,
                                large: true,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  loading: () => Container(),
                  error: (error, stack) => Container(),
                ),
              ),
            ),
          ),
          DatePickerBadge(
            selectedDate: selectedDate,
            onDateChanged: onDateChanged,
          ),
        ],
      ),
    );
  }
}
