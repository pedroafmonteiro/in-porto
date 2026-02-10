import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';

class LicensesView extends StatefulWidget {
  const LicensesView({super.key});

  @override
  State<LicensesView> createState() => _LicensesViewState();
}

class _LicensesViewState extends State<LicensesView> {
  final List<LicenseEntry> _licenseEntries = [];
  final Map<String, List<LicenseEntry>> _packageLicenses = {};
  final Set<String> _expandedPackages = {};
  late final Stream<LicenseEntry> _licenseStream;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _licenseStream = LicenseRegistry.licenses;
    _listenLicenses();
  }

  void _listenLicenses() {
    _licenseStream.listen(
      (entry) {
        setState(() {
          _licenseEntries.add(entry);
          for (final pkg in entry.packages) {
            _packageLicenses.putIfAbsent(pkg, () => []).add(entry);
          }
        });
      },
      onDone: () {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_isLoading,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: _isLoading
                ? null
                : () {
                    Navigator.of(context).pop();
                  },
          ),
          title: Text(AppLocalizations.of(context)!.openSourceLicensesTitle),
        ),
        body: _isLoading && _packageLicenses.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16.0),
                children: _packageLicenses.keys.map((pkg) {
                  final licenses = _packageLicenses[pkg]!;
                  final isExpanded = _expandedPackages.contains(pkg);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(pkg),
                            subtitle: Text(
                              '${licenses.length} ${AppLocalizations.of(context)!.license}${licenses.length > 1 ? 's' : ''}',
                            ),
                            trailing: Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                            ),
                            onTap: () {
                              setState(() {
                                if (isExpanded) {
                                  _expandedPackages.remove(pkg);
                                } else {
                                  _expandedPackages.add(pkg);
                                }
                              });
                            },
                          ),
                          if (isExpanded)
                            ...licenses.map((licenseEntry) {
                              final licenseText = licenseEntry.paragraphs
                                  .map((p) => p.text)
                                  .join('\n\n');
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                  vertical: 8.0,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      licenseText,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                              );
                            }),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }
}
