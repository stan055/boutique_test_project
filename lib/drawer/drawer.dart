import 'package:flutter/material.dart';
import 'package:imitation_of_files_download/screens/download_files_screen.dart';
import 'package:imitation_of_files_download/screens/save_files_screen.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: DrawerHeader(
              child: Text(
                'Navigation Drawer',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.file_download),
              title: Text('Файлы'),
              onTap: () {
                Navigator.of(context).push(FadeRoute(DownloadFilesScreen()));
              }),
          ListTile(
              leading: Icon(Icons.save),
              title: Text('Сохранить, сбросить'),
              onTap: () {
                Navigator.of(context).push(FadeRoute(SaveFilesScreen()));
              }),
        ],
      ),
    );
  }
}

class FadeRoute extends PageRoute {
  FadeRoute(this.page);
  final Widget page;

  @override
  Color get barrierColor => Colors.white;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(
      opacity: animation,
      child: page,
    );
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 100);
}
