import 'package:flutter/material.dart';
import 'package:mobile_test/entities/repository.dart';
import 'package:mobile_test/providers/repository_provider.dart';
import 'package:provider/provider.dart';

class TredingWidget extends StatefulWidget {
  const TredingWidget({super.key});

  @override
  State<TredingWidget> createState() => _TredingWidgetState();
}

class _TredingWidgetState extends State<TredingWidget> {
  late RepositoryProvider provider;
  int page = 1;
  @override
  void initState() {
    provider = context.read<RepositoryProvider>();
    provider.fetchRepositories(page);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            provider.fetchRepositories(page);
          },
          child: Center(
            child: Consumer<RepositoryProvider>(
                builder: (context, provider, child) {
              return provider.isLoading
                  ? _buildProgress()
                  : provider.repositories.isEmpty
                      ? _buildNoRepositories()
                      : _buildRepositories(provider.repositories);
            }),
          ),
        ),
      ),
    );
  }

  _buildProgress() {
    return Center(child: CircularProgressIndicator());
  }

  _buildNoRepositories() {
    return Center(child: Text('No repositories found'));
  }

  _buildRepositories(List<Repository> repositories) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(decoration: BoxDecoration(
            color: Colors.grey.withAlpha(100),
          ),child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(child: Text("Trending Repos",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)),
          )),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: repositories.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: _buildSingleRepository(repositories[index]),
                  );
                }),
          ),
        ],
      ),
    );
  }

  _buildSingleRepository(Repository repo) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(repo.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(repo.description,style: TextStyle(fontSize: 14,),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
                    Image.asset('assets/row.png',height: 20,),
                    SizedBox(
                      width: 2,
                    ),
                    Text(repo.owner,style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),)
                  ]),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      Icon(Icons.star, size: 20),
                      SizedBox(
                        width: 2,
                      ),
                      Text(parseCount(repo.stars))
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
        Divider(color: Colors.grey,)
      ],
    );
  }
   String parseCount(int stars){
      if(stars < 1000){
        return stars.toString();
      }
      return "${(stars / 1000).toStringAsFixed(1)}k";
  }
}