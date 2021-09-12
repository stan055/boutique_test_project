import 'package:flutter/material.dart';
import 'package:imitation_of_files_download/drawer/drawer.dart';
import 'package:imitation_of_files_download/models/download.dart';
import 'package:imitation_of_files_download/services/downloader.dart';
import 'package:provider/provider.dart';

class DownloadFilesScreen extends StatefulWidget {
  const DownloadFilesScreen({Key? key}) : super(key: key);

  @override
  _DownloadFilesScreenState createState() => _DownloadFilesScreenState();
}

class _DownloadFilesScreenState extends State<DownloadFilesScreen> {
  late Downloader _downloader;

  @override
  void initState() {
    _downloader = context.read<Downloader>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Download Files Screen'),
      ),
      drawer: NavigationDrawer(),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  initialData: _downloader.data,
                  stream: _downloader.stream,
                  builder: (context, AsyncSnapshot<List<Download>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView(
                        children: snapshot.data!
                            .map((Download d) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      title: Text('${d.position}  ${d.status}'),
                                      subtitle:
                                          d.status == DownloadField.downloading
                                              ? LinearProgressIndicator()
                                              : Text('for ${d.data} sec.'),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          _downloader.deleteWhere(d.position);
                                        },
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                    }
                    return Center(
                        child: Container(child: Text('There is no data')));
                  })),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton.icon(
                onPressed: () {
                  try {
                    _downloader.add(Download(DownloadField.wait, null));
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                icon: Icon(Icons.download),
                label: Text('Загрузить файлы')),
          )
        ],
      ),
    );
  }
}
