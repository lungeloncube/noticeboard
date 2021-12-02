class AllPostsModel {
  int userId;
  List<Categories> categories;
  String thumbnailUrl;
  String username;
  String firstName;
  String lastName;
  String emailAddress;
  String phoneNumber;
  String branchId;
  bool enabled;

  AllPostsModel(
      {this.userId,
      this.categories,
      this.thumbnailUrl,
      this.username,
      this.firstName,
      this.lastName,
      this.emailAddress,
      this.phoneNumber,
      this.branchId,
      this.enabled});

  AllPostsModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    thumbnailUrl = json['thumbnailUrl'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    emailAddress = json['emailAddress'];
    phoneNumber = json['phoneNumber'];
    branchId = json['branchId'];
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['emailAddress'] = this.emailAddress;
    data['phoneNumber'] = this.phoneNumber;
    data['branchId'] = this.branchId;
    data['enabled'] = this.enabled;
    return data;
  }
}

class Categories {
  int categoryId;
  String name;
  bool publicView;
  String branchId;

  Categories({this.categoryId, this.name, this.publicView, this.branchId});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    name = json['name'];
    publicView = json['publicView'];
    branchId = json['branchId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['name'] = this.name;
    data['publicView'] = this.publicView;
    data['branchId'] = this.branchId;
    return data;
  }
}
