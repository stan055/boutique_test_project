class DownloadField {
  static final downloading = 'Downloading';
  static final wait = 'Wait';
  static final compleate = 'Compleate';
}

class Download {
  String status;
  dynamic data;
  int? position;

  Download(this.status, this.data);
}
