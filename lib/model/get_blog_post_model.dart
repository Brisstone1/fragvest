class GetBlogPostModel {
  bool success;
  List<Data> data;

  GetBlogPostModel({this.success, this.data});

  GetBlogPostModel.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) this.success = json["success"];
    if (json["data"] is List)
      this.data = json["data"] == null
          ? null
          : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["success"] = this.success;
    if (this.data != null)
      data["data"] = this.data.map((e) => e.toJson()).toList();
    return data;
  }
}

class Data {
  String postImage;
  String postTitle;
  String postLink;

  Data({this.postImage, this.postTitle, this.postLink});

  Data.fromJson(Map<String, dynamic> json) {
    if (json["post_image"] is String) this.postImage = json["post_image"];
    if (json["post_title"] is String) this.postTitle = json["post_title"];
    if (json["post_link"] is String) this.postLink = json["post_link"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["post_image"] = this.postImage;
    data["post_title"] = this.postTitle;
    data["post_link"] = this.postLink;
    return data;
  }
}
