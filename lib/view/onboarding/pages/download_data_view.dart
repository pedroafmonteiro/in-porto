import 'package:flutter/material.dart';
import 'package:in_porto/view/common/buttons.dart';
import 'package:in_porto/viewmodel/connectivity_viewmodel.dart';
import 'package:in_porto/viewmodel/data_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:in_porto/enums.dart';

class DownloadDataView extends StatefulWidget {
  const DownloadDataView({super.key});

  @override
  State<DownloadDataView> createState() => _DownloadDataViewState();
}

class _DownloadDataViewState extends State<DownloadDataView> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final connectivityStatus = context.watch<ConnectivityViewmodel>().status;
    final agencyStatus = context.watch<DataViewModel>().agencyStatus;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0.0, -0.75),
                child: _cloudIcon(context, currentStep),
              ),
              Align(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Cloud Data',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    if (currentStep == 0) ...[
                      const SizedBox(height: 16),
                      Text(
                        'To use this app, you will need to connect to the internet at least once to download essential information from the cloud.',
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'All data is publicly available and relates to the city of Porto. No private information or analytics are collected that could identify you.',
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    if (currentStep == 1) ...[
                      const SizedBox(height: 16),
                      for (final agency in agencyStatus.entries) ...[
                        Row(
                          children: [
                            Icon(
                              agency.value == AgencyLoadStatus.loading
                                  ? Icons.cloud_download_rounded
                                  : agency.value == AgencyLoadStatus.done
                                  ? Icons.cloud_done_rounded
                                  : Icons.cloud_off_rounded,
                              color: agency.value == AgencyLoadStatus.done
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              agency.key,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        if (agency.value == AgencyLoadStatus.loading) ...[
                          const SizedBox(height: 8),
                          LinearProgressIndicator(),
                        ],
                      ],
                    ],
                  ],
                ),
              ),
              if (currentStep == 0)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _connectivityText(context, connectivityStatus),
                      const SizedBox(height: 16),
                      MainButton(
                        onPressed: () {
                          setState(() {
                            currentStep = 1;
                          });
                          context.read<DataViewModel>().loadGtfsData();
                        },
                        text: 'Continue',
                        icon: Icons.arrow_forward_ios_rounded,
                        disabled:
                            connectivityStatus == ConnectivityStatus.offline,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cloudIcon(BuildContext context, int step) {
    return Icon(
      step == 0
          ? Icons.cloud_off_rounded
          : step == 1
          ? Icons.cloud_download_rounded
          : Icons.cloud_done_rounded,
      size: 92,
    );
  }
}

Widget _connectivityText(BuildContext context, ConnectivityStatus status) {
  switch (status) {
    case ConnectivityStatus.connected:
      return Text(
        'You are connected to the internet.',
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.green,
        ),
      );
    case ConnectivityStatus.offline:
      return Text(
        'You are currently offline.',
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.red),
      );
  }
}
