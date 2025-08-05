import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';

class PublicTransportationView extends StatelessWidget {
  const PublicTransportationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(AppLocalizations.of(context)!.stcp),
              leading: Image.asset(
                'assets/images/stcp.png',
                width: 60,
                height: 60,
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(AppLocalizations.of(context)!.metrodoporto),
              leading: Image.asset(
                'assets/images/metrodoporto.png',
                width: 60,
                height: 60,
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              contentPadding: const EdgeInsets.only(
                left: 16.0,
                right: 12.0,
                top: 16.0,
                bottom: 16.0,
              ),
              title: Text(AppLocalizations.of(context)!.cpFull),
              leading: Image.asset(
                'assets/images/cp.png',
                width: 60,
                height: 60,
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
