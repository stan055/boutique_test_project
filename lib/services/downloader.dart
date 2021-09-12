import 'dart:async';
import 'dart:math';

import 'package:imitation_of_files_download/models/download.dart';

class Downloader {
  List<Download> _downloads = [];
  final maxDownloading;
  final maxDownloads;
  final _streamController = StreamController<List<Download>>.broadcast();
  int id = 0;

  Downloader(this.maxDownloading, this.maxDownloads);

  Stream<List<Download>> get stream => _streamController.stream;
  List<Download> get data => _downloads;

  add(Download d) {
    if (_downloads.length >= maxDownloads)
      throw Exception('Already have the maximum number of downloads');

    final downloadingItemsCount = countDownloading(_downloads);
    if (downloadingItemsCount < maxDownloading) startDownloading(d);

    d.position = id++;
    _downloads.add(d);
    _streamController.add(_downloads);
  }

  startDownloading(Download d) {
    d.status = DownloadField.downloading;
    final duration = Random().nextInt(8) + 3;
    Future.delayed(Duration(seconds: duration)).then((_) {
      try {
        d.status = 'Download ${DownloadField.compleate}';
        d.data = duration;
        _streamController.add(_downloads);
      } catch (e) {
        print(e);
      }
    }).then((_) => nextDownloading());
  }

  nextDownloading() {
    try {
      final waitingDownload =
          _downloads.firstWhere((d) => d.status == DownloadField.wait);
      startDownloading(waitingDownload);
    } catch (e) {
      print(e);
    }
  }

  static int countDownloading(List<Download> list) =>
      list.where((d) => d.status == DownloadField.downloading).toList().length;

  deleteWhere(position) {
    _downloads.removeWhere((element) => element.position == position);
    _streamController.add(_downloads);
  }

  void clear() {
    _downloads.clear();
    _streamController.add(_downloads);
  }

  dispose() {
    _streamController.close();
  }
}
