

class Post{
  late final dynamic id, title, body;
  Post(this.id, this.title,this.body);
}
class PostInsert{
  late final String title,body;
  PostInsert(this.title,this.body);

  Map<String, dynamic> toJson(){
    return {
      "title":title.toString(),
      "body":body.toString(),
    };
  }
}