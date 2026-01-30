import 'dart:io';
import 'package:http/http.dart' as http;

class GtfsRemoteDataSource {
  Future<({File file, String? etag, String? lastModified})> downloadGtfsFile(
    String url,
    String savePath, {
    Function(double progress)? onProgress,
  }) async {
    final httpClient = http.Client();
    final request = http.Request('GET', Uri.parse(url));
    final response = await httpClient.send(request);

    if (response.statusCode != 200) {
      throw Exception('Failed to download GTFS zip from $url');
    }

    final etag = response.headers['etag'];
    final lastModified = response.headers['last-modified'];

    final file = File(savePath);
    final sink = file.openWrite();

    final contentLength = response.contentLength ?? 0;
    int receivedBytes = 0;

    await response.stream
        .listen(
          (List<int> chunk) {
            receivedBytes += chunk.length;
            sink.add(chunk);
            if (contentLength > 0 && onProgress != null) {
              onProgress(receivedBytes / contentLength);
            }
          },
          onDone: () async {
            await sink.close();
            httpClient.close();
          },
          onError: (e) {
            sink.close();
            httpClient.close();
            throw e;
          },
          cancelOnError: true,
        )
        .asFuture();

    return (file: file, etag: etag, lastModified: lastModified);
  }

  Future<bool> hasResourceChanged(
    String url, {
    String? storedEtag,
    String? storedLastModified,
  }) async {
    if (storedEtag == null && storedLastModified == null) {
      return true;
    }

    try {
      final httpClient = http.Client();
      final request = http.Request('HEAD', Uri.parse(url));

      if (storedEtag != null) {
        request.headers['If-None-Match'] = storedEtag;
      }
      if (storedLastModified != null) {
        request.headers['If-Modified-Since'] = storedLastModified;
      }

      final response = await httpClient.send(request);
      httpClient.close();

      if (response.statusCode == 304) {
        return false;
      }

      final currentEtag = response.headers['etag'];
      final currentLastModified = response.headers['last-modified'];

      if (storedEtag != null && currentEtag != null) {
        return storedEtag != currentEtag;
      }
      if (storedLastModified != null && currentLastModified != null) {
        return storedLastModified != currentLastModified;
      }

      return true;
    } catch (e) {
      return true;
    }
  }
}
