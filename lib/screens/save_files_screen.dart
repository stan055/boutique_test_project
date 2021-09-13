import 'package:flutter/material.dart';
import 'package:imitation_of_files_download/drawer/drawer.dart';
import 'package:imitation_of_files_download/screens/page_one.dart';
import 'package:imitation_of_files_download/screens/page_two.dart';

class SaveFilesScreen extends StatefulWidget {
  const SaveFilesScreen({Key? key}) : super(key: key);

  @override
  _SaveFilesScreenState createState() => _SaveFilesScreenState();
}

class _SaveFilesScreenState extends State<SaveFilesScreen> {
  var _selectedIndex = 0;
  final _pages = <Widget>[PageOne(), PageTwo()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Files Screen'),
      ),
      drawer: NavigationDrawer(),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.navigate_before),
            label: 'Page one',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigate_next),
            label: 'Page two',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
