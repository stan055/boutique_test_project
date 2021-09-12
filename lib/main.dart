import 'package:flutter/material.dart';
import 'package:imitation_of_files_download/screens/download_files_screen.dart';
import 'package:imitation_of_files_download/services/downloader.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider<Downloader>(
      create: (context) => Downloader(3, 30),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DownloadFilesScreen(),
    );
  }
}
