import 'package:flutter/material.dart';
import 'package:in_porto/data/registry/agency_registry.dart';
import 'package:in_porto/l10n/app_localizations.dart';
import 'package:in_porto/view/common/buttons.dart';
import 'package:in_porto/view/navigation/navigation_view.dart';
import 'package:in_porto/viewmodel/connectivity_viewmodel.dart';
import 'package:in_porto/viewmodel/data_viewmodel.dart';
import 'package:in_porto/viewmodel/settings_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:in_porto/enums.dart';

class DownloadDataView extends StatelessWidget {
  const DownloadDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivityStatus = context.watch<ConnectivityViewmodel>().status;
    final agencyStatus = context.watch<DataViewModel>().agencyStatus;
    final agencyProgress = context.watch<DataViewModel>().agencyProgress;
    final isLoading = context.watch<DataViewModel>().isLoading;
    final isDataLoaded = context.watch<DataViewModel>().isDataLoaded;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.cloud_rounded,
                    size: 92,
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      AppLocalizations.of(context)!.downloadDataTitle,
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  layoutBuilder: (currentChild, previousChildren) {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        ...previousChildren,
                        if (currentChild != null) currentChild,
                      ],
                    );
                  },
                  child: SingleChildScrollView(
                    key: ValueKey('${isLoading}_$isDataLoaded'),
                    child: (!isLoading && !isDataLoaded)
                        ? Column(
                            key: const ValueKey('notLoadedContent'),
                            children: [
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.downloadDataText1,
                                textAlign: TextAlign.justify,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.downloadDataText2,
                                textAlign: TextAlign.justify,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.downloadDataText3,
                                textAlign: TextAlign.justify,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                AppLocalizations.of(
                                  context,
                                )!.downloadDataText4,
                                textAlign: TextAlign.justify,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          )
                        : Column(
                            key: const ValueKey('agencyStatusContent'),
                            children: [
                              for (final agency in agencyStatus.entries) ...[
                                Card(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainer,
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(
                                      16.0,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        12.0,
                                      ),
                                    ),
                                    title: Text(agency.key),
                                    leading: Builder(
                                      builder: (context) {
                                        final appAgency =
                                            AgencyRegistry.getAgencyByName(
                                              agency.key,
                                            );
                                        final imagePath = appAgency != null
                                            ? 'assets/images/${appAgency.id}.png'
                                            : 'assets/images/${agency.key.toLowerCase().replaceAll(' ', '')}.png';
                                        return Image.asset(
                                          imagePath,
                                          width: 60,
                                          height: 60,
                                          errorBuilder:
                                              (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return const Icon(
                                                  Icons.directions_bus,
                                                  size: 60,
                                                );
                                              },
                                        );
                                      },
                                    ),
                                    trailing:
                                        agency.value == AgencyLoadStatus.loading
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                '${((agencyProgress[agency.key] ?? 0.0) * 100).toInt()}%',
                                                style: Theme.of(
                                                  context,
                                                ).textTheme.bodySmall,
                                              ),
                                              const SizedBox(width: 8),
                                              SizedBox(
                                                width: 24,
                                                height: 24,
                                                child:
                                                    CircularProgressIndicator(
                                                      value:
                                                          agencyProgress[agency
                                                              .key],
                                                      strokeWidth: 2.5,
                                                    ),
                                              ),
                                            ],
                                          )
                                        : Icon(
                                            agency.value ==
                                                    AgencyLoadStatus.done
                                                ? Icons.check_rounded
                                                : Icons.cloud_off_rounded,
                                            color:
                                                agency.value ==
                                                    AgencyLoadStatus.done
                                                ? Colors.green
                                                : Colors.grey,
                                          ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: (!isLoading && !isDataLoaded)
                      ? Column(
                          key: const ValueKey('notLoaded'),
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            _connectivityText(context, connectivityStatus),
                            const SizedBox(height: 16),
                            MainButton(
                              onPressed: () {
                                if (!isDataLoaded && !isLoading) {
                                  context.read<DataViewModel>().loadGtfsData();
                                }
                              },
                              text: AppLocalizations.of(context)!.continueText,
                              icon: Icons.arrow_forward_ios_rounded,
                              disabled:
                                  connectivityStatus ==
                                  ConnectivityStatus.offline,
                            ),
                          ],
                        )
                      : (!isLoading && isDataLoaded)
                      ? MainButton(
                          key: const ValueKey('loaded'),
                          onPressed: () {
                            context
                                .read<SettingsViewModel>()
                                .setHasSeenOnboarding(1);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const NavigationView(),
                              ),
                            );
                          },
                          text: AppLocalizations.of(context)!.finishText,
                          icon: Icons.arrow_forward_ios_rounded,
                        )
                      : const SizedBox.shrink(key: ValueKey('loading')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _connectivityText(BuildContext context, ConnectivityStatus status) {
  switch (status) {
    case ConnectivityStatus.connected:
      return Text(
        AppLocalizations.of(context)!.connectivitySuccess,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.green,
        ),
      );
    case ConnectivityStatus.offline:
      return Text(
        AppLocalizations.of(context)!.connectivityError,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.red),
      );
  }
}
