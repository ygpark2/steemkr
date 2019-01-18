library yogamindful.src.model.post;

const String jsonTagFirst = "first";
const String jsonTagSecond = "second";
const String jsonTagDescription = "description";
const String jsonTagImgUrl = "img_url";

class Post {
  String key;
  String first;
  String second;
  String description;
  String imageUrl;

  Post([this.first, this.second, this.description, this.imageUrl, this.key]);

  static Map toMap(Post item) {
    Map jsonMap = {
      jsonTagFirst: item.first,
      jsonTagSecond: item.second,
      jsonTagDescription: item.description,
      jsonTagImgUrl: item.imageUrl
    };
    return jsonMap;
  }
}
