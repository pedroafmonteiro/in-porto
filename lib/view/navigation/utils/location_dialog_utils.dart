import 'package:flutter/material.dart';
import 'package:in_porto/l10n/app_localizations.dart';

enum LocationDialogResult {
  cancel,
  tryAgain,
  openSettings,
  grant,
}

class LocationDialogUtils {
  static Future<LocationDialogResult?> showPermissionDenied(
    BuildContext context,
  ) {
    return showDialog<LocationDialogResult>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.locationPermissionDenied),
        content: Text(
          AppLocalizations.of(context)!.locationPermissionDeniedDescription,
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context, LocationDialogResult.cancel),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, LocationDialogResult.tryAgain),
            child: Text(AppLocalizations.of(context)!.tryAgain),
          ),
        ],
      ),
    );
  }

  static Future<LocationDialogResult?> showPermissionPermanentlyDenied(
    BuildContext context,
  ) {
    return showDialog<LocationDialogResult>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          AppLocalizations.of(context)!.locationPermissionDeniedForever,
        ),
        content: Text(
          AppLocalizations.of(
            context,
          )!.locationPermissionDeniedForeverDescription,
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context, LocationDialogResult.cancel),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, LocationDialogResult.openSettings),
            child: Text(AppLocalizations.of(context)!.openSettings),
          ),
        ],
      ),
    );
  }

  static Future<LocationDialogResult?> showPreciseLocationExplanation(
    BuildContext context,
  ) {
    return showDialog<LocationDialogResult>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.preciseLocationNeeded),
        content: Text(
          AppLocalizations.of(context)!.preciseLocationNeededDescription,
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context, LocationDialogResult.cancel),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, LocationDialogResult.grant),
            child: Text(AppLocalizations.of(context)!.grant),
          ),
        ],
      ),
    );
  }
}
