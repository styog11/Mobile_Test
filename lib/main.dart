import 'package:flutter/material.dart';
import 'package:mobile_test/providers/repository_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) =>
         RepositoryProvider()
      ,
      child: const MainApp()));
}



class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late RepositoryProvider provider ;
  int page = 1;
  @override
  void initState() {
    provider = context.read<RepositoryProvider>();
    provider.fetchRepositories(page);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Center(
          child: Consumer<RepositoryProvider>(builder:(context,provider,child){
            return Center(child: Text('Hello World!'));
          }),
        ),
      ),
    );
  }
}

