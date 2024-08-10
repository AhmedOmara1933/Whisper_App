class PostModel {
  String? image;
  String? name;
  String? uId;
  String? date;
  String? text;
  String? postImage;

  PostModel({this.image,
    this.name,
    this.uId,
    this.date,
    this.text,
    this.postImage});

  PostModel.fromJson(Map<String, dynamic>json){
  image=json['image'];
  name=json['name'];
  uId=json['uId'];
  date=json['date'];
  text=json['text'];
  postImage=json['postImage'];
  }
 Map<String,dynamic> toMap(){
    return {
      'image':image,
      'name':name,
      'uId':uId,
      'date':date,
      'text':text,
      'postImage':postImage,
    };
 }
}
