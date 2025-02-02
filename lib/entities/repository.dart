class Repository {
  final int id ;
  final String name ;
  final String description ;
  final String owner ;
  final int stars ;
  const Repository(this.id,this.name,this.description,this.owner,this.stars);
  factory  Repository.fromJson(Map<String,dynamic> json){
      return Repository(json['id'] as int, 
      json['name'].toString(),
       json['description'].toString(), 
       json['owner']['login'].toString(),
       json['stargazers_count'] as int);
  }
}