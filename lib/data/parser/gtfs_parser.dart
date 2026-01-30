import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:csv/csv.dart';

class GtfsParser {
  final Archive _archive;
  final Map<String, List<String>> _cache = {};
  int _skippedRows = 0;

  GtfsParser(List<int> zipBytes)
    : _archive = ZipDecoder().decodeBytes(zipBytes);

  int get skippedRows => _skippedRows;

  Iterable<Map<String, dynamic>> parseFile(
    String filename, {
    String? agencyIdOverride,
  }) sync* {
    final lines = _getLines(filename);
    if (lines.isEmpty) return;

    final headers = const CsvToListConverter(
      eol: '\n',
    ).convert(lines.first)[0].map((h) => h.toString()).toList();

    for (var i = 1; i < lines.length; i++) {
      try {
        final row = const CsvToListConverter(eol: '\n').convert(lines[i])[0];
        final map = <String, dynamic>{};
        for (int j = 0; j < headers.length && j < row.length; j++) {
          map[headers[j]] = row[j];
        }

        if (agencyIdOverride != null && agencyIdOverride.isNotEmpty) {
          map['agency_id'] = agencyIdOverride;
        }

        yield map;
      } catch (e) {
        _skippedRows++;
      }
    }
  }

  int getRowCount(String filename) {
    if (!hasFile(filename)) return 0;
    final lines = _getLines(filename);
    return lines.length > 1 ? lines.length - 1 : 0;
  }

  bool hasFile(String filename) {
    return _archive.files.any((f) => f.name.toLowerCase() == filename);
  }

  List<String> _getLines(String filename) {
    if (_cache.containsKey(filename)) {
      return _cache[filename]!;
    }

    final file = _archive.files.firstWhere(
      (f) => f.name.toLowerCase() == filename,
      orElse: () => throw Exception('$filename not found in GTFS zip'),
    );

    final csvString = utf8.decode(file.content as List<int>);
    final lines = const LineSplitter().convert(csvString);

    _cache[filename] = lines;
    return lines;
  }
}
