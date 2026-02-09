import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:in_porto/service/deep_link_handlers.dart';

part 'deep_link_service.g.dart';

class DeepLinkService {
  final Ref _ref;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  final List<DeepLinkHandler> _handlers = [
    ShortLinkHandler(),
    ExplorePortoHandler(),
    StcpHandler(),
  ];

  DeepLinkService(this._ref);

  void init() {
    _appLinks = AppLinks();

    _appLinks.getInitialLink().then((uri) {
      if (uri != null) handleLink(uri);
    });

    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      handleLink(uri);
    });
  }

  void dispose() {
    _linkSubscription?.cancel();
  }

  Future<void> handleLink(Uri uri) async {
    for (final handler in _handlers) {
      if (handler.canHandle(uri)) {
        await handler.handle(uri, _ref);
        return;
      }
    }
  }
}

@Riverpod(keepAlive: true)
DeepLinkService deepLinkService(Ref ref) {
  final service = DeepLinkService(ref);
  ref.onDispose(() => service.dispose());
  return service;
}
