import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CacheManager {
  final Duration cacheCleanupThreshold;

  CacheManager({
    this.cacheCleanupThreshold = const Duration(days: 7),
  });

  Future<File> getLocalFile(String url) async {
    final directory = await getTemporaryDirectory();
    final filename = path.basename(Uri.parse(url).path);
    final file = File('${directory.path}/$filename');
    _cleanupCache(directory);
    return file;
  }

  Future<void> _cleanupCache(Directory cacheDir) async {
    final now = DateTime.now();
    final files = cacheDir.listSync();
    for (var file in files) {
      final stat = await FileStat.stat(file.path);
      if (now.difference(stat.modified) > cacheCleanupThreshold) {
        await file.delete();
      }
    }
  }

  Future<void> preCacheAsset(String assetPath) async {
    final directory = await getTemporaryDirectory();
    final filename = path.basename(assetPath);
    final file = File('${directory.path}/$filename');
    final ByteData data = await rootBundle.load(assetPath);
    await file.writeAsBytes(data.buffer.asUint8List());
  }
}
