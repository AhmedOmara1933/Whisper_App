
class StoryModel {
  String? storyImage;
  String? uId;
  String ?name;
  String ?image;
  String ?date;


  StoryModel({
    this.storyImage,
    this.uId,
    this.name,
    this.image,
    this.date
  });

  StoryModel.fromJson(Map<String, dynamic> json) {
    storyImage = json['storyImage'];
    uId = json['uId'];
    name = json['name'];
    image = json['image'];
    date = json['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'storyImage': storyImage,
      'uId': uId,
      'name': name,
      'image': image,
      'date': date,
    };
  }
}
