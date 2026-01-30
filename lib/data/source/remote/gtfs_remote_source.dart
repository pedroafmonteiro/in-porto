import 'dart:io';
import 'package:http/http.dart' as http;

class GtfsRemoteDataSource {
  Future<File> downloadGtfsFile(
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

    return file;
  }
}
