import 'package:flutter/material.dart';
import 'package:in_porto/view/common/buttons.dart';
import 'package:in_porto/viewmodel/connectivity_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:in_porto/enums.dart';

class DownloadDataView extends StatelessWidget {
  const DownloadDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivityStatus = context.watch<ConnectivityViewmodel>().status;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0.0, -0.75),
                child: const Icon(
                  Icons.cloud_off_rounded,
                  size: 92,
                ),
              ),
              Align(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Cloud Data',
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
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
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _connectivityText(context, connectivityStatus),
                    const SizedBox(height: 16),
                    MainButton(
                      onPressed: () {
                        Navigator.of(context).pop();
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
