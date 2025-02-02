import 'package:flutter/material.dart';
import 'package:mobile_test/entities/repository.dart';
import 'package:mobile_test/providers/repository_provider.dart';
import 'package:mobile_test/widgets/treding_widget.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => RepositoryProvider(), child: const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late RepositoryProvider provider;
  int _selectedBar = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Expanded(child: _selectedBar == 0 ? TredingWidget() : Center(child:Text("settings"))),
              BottomNavigationBar(items: [
                BottomNavigationBarItem(icon: Icon(Icons.star),label: 'Trending'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
              ],
              selectedItemColor: Colors.blueAccent,
              currentIndex: _selectedBar,
              onTap: (value) {
                setState(() {
                  _selectedBar = value;
                });
              },),
            ],
          ),
        ),
      ),
    );
  }

}
