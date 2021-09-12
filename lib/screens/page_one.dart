import 'package:flutter/material.dart';
import 'package:imitation_of_files_download/models/download.dart';
import 'package:imitation_of_files_download/services/downloader.dart';
import 'package:provider/provider.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
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
            bool saveButton =
                downloadsFilesLenght != 0 && downloadingFilesCount == 0;
            bool clearButton =
                downloadsFilesLenght > 0 || downloadingFilesCount > 0;
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: saveButton
                          ? () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Успешно сохранено')));
                            }
                          : null,
                      child: Text('Сохранить')),
                  ElevatedButton(
                      onPressed: clearButton
                          ? () {
                              _downloader.clear();
                            }
                          : null,
                      child: Text('Сбросить'))
                ],
              ),
            );
          }
          return Text('There is has not data');
        });
  }
}
