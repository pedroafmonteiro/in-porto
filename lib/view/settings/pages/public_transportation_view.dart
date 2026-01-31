import 'package:flutter/material.dart';
import 'package:in_porto/data/registry/agency_registry.dart';
import 'package:in_porto/l10n/app_localizations.dart';

class PublicTransportationView extends StatelessWidget {
  const PublicTransportationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          AppLocalizations.of(context)!.publicTransportationTitle,
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: AgencyRegistry.agencies.length,
        itemBuilder: (context, index) {
          final agency = AgencyRegistry.agencies[index];
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(agency.name),
              leading: Image.asset(
                'assets/images/${agency.id}.png',
                width: 60,
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.directions_bus, size: 60);
                },
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
