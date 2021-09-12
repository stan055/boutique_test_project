import 'package:flutter/material.dart';
import 'package:imitation_of_files_download/models/download.dart';
import 'package:imitation_of_files_download/services/downloader.dart';
import 'package:provider/provider.dart';

class PageTwo extends StatefulWidget {
  PageTwo({Key? key}) : super(key: key);

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  late Downloader _downloader;

  @override
  void initState() {
    _downloader = context.read<Downloader>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: _downloader.data,
        stream: _downloader.stream,
        builder: (context, AsyncSnapshot<List<Download>> snapshot) {
          if (snapshot.hasData) {
            final downloadsFilesLenght = snapshot.data!.length;
            final downloadingFilesCount =
                Downloader.countDownloading(snapshot.data!);
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Загрузка файлов',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      downloadsFilesLenght > 0
                          ? 'Загружено файлов: $downloadsFilesLenght'
                          : 'Нету загруженных файлов:(',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  downloadingFilesCount > 0
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Файлов в загрузке $downloadingFilesCount',
                            style: TextStyle(fontSize: 18),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            );
          }
          return Text('There is has not data');
        });
  }
}
