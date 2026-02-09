import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_porto/service/deep_link_service.dart';
import 'package:in_porto/viewmodel/navigation_state.dart';
import 'package:in_porto/viewmodel/stop_viewmodel.dart';
import 'package:http/http.dart' as http;

abstract class DeepLinkHandler {
  bool canHandle(Uri uri);
  Future<void> handle(Uri uri, Ref ref);
}

class ShortLinkHandler implements DeepLinkHandler {
  @override
  bool canHandle(Uri uri) {
    return uri.host == 't.porto.pt';
  }

  @override
  Future<void> handle(Uri uri, Ref ref) async {
    final client = http.Client();
    try {
      final request = http.Request('HEAD', uri)..followRedirects = false;
      final response = await client.send(request);

      final location = response.headers['location'];
      if (location != null) {
        await ref.read(deepLinkServiceProvider).handleLink(Uri.parse(location));
      }
    } catch (e) {
      debugPrint('Error resolving short link $uri: $e');
    } finally {
      client.close();
    }
  }
}

class ExplorePortoHandler implements DeepLinkHandler {
  @override
  bool canHandle(Uri uri) {
    final host = uri.host;
    return (host.contains('explore.porto.pt') || host.isEmpty) &&
        uri.pathSegments.contains('stops');
  }

  @override
  Future<void> handle(Uri uri, Ref ref) async {
    final stopsIndex = uri.pathSegments.indexOf('stops');
    if (stopsIndex != -1 && uri.pathSegments.length > stopsIndex + 1) {
      final stopIdFromLink = uri.pathSegments[stopsIndex + 1];
      await _selectStop(stopIdFromLink, ref);
    }
  }
}

class StcpHandler implements DeepLinkHandler {
  @override
  bool canHandle(Uri uri) {
    return uri.host.contains('stcp.pt') &&
        uri.queryParameters.containsKey('paragem');
  }

  @override
  Future<void> handle(Uri uri, Ref ref) async {
    final stopIdFromLink = uri.queryParameters['paragem'];
    if (stopIdFromLink != null) {
      await _selectStop(stopIdFromLink, ref);
    }
  }
}

Future<void> _selectStop(String stopIdFromLink, Ref ref) async {
  if (stopIdFromLink.isEmpty) return;

  final stopId = stopIdFromLink.contains(':')
      ? stopIdFromLink.split(':').last
      : stopIdFromLink;

  try {
    final stops = await ref.read(stopViewModelProvider.future);
    final stop = stops.firstWhere(
      (s) =>
          s.id.toLowerCase() == stopId.toLowerCase() ||
          s.code?.toLowerCase() == stopId.toLowerCase(),
      orElse: () => throw Exception(
        'Stop $stopId (from $stopIdFromLink) not found in repository',
      ),
    );

    ref.read(selectedNavigationOverrideProvider.notifier).select(stop);
  } catch (e) {
    debugPrint('Error handling deep link for stop $stopIdFromLink: $e');
  }
}
