class PropertyCategoryModel {
  String property;
  String alias;
  List<String> detail;

  PropertyCategoryModel({this.property, this.alias, this.detail});

  PropertyCategoryModel.fromJson(Map<String, dynamic> json) {
    property = json['property'];
    alias = json['alias'];
    detail = json['detail'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property'] = this.property;
    data['alias'] = this.alias;
    data['detail'] = this.detail;
    return data;
  }
}
