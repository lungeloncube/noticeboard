// To parse this JSON data, do
//
//     final commentResponse = commentResponseFromJson(jsonString);

import 'dart:convert';

CommentResponse commentResponseFromJson(String str) =>
    CommentResponse.fromJson(json.decode(str));

String commentResponseToJson(CommentResponse data) =>
    json.encode(data.toJson());

class CommentResponse {
  CommentResponse({
    this.commentId,
    this.commentText,
    this.createdAt,
    this.views,
    this.likes,
    this.dislikes,
    this.comments,
    this.users,
  });

  String commentId;
  String commentText;
  DateTime createdAt;
  int views;
  int likes;
  int dislikes;
  List<CommentResponse> comments;
  Users users;

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      CommentResponse(
        commentId: json["commentId"],
        commentText: json["commentText"],
        createdAt: DateTime.parse(json["createdAt"]),
        views: json["views"],
        likes: json["likes"],
        dislikes: json["dislikes"],
        comments: List<CommentResponse>.from(
            json["comments"].map((x) => CommentResponse.fromJson(x))),
        users: Users.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "commentText": commentText,
        "createdAt": createdAt.toIso8601String(),
        "views": views,
        "likes": likes,
        "dislikes": dislikes,
        "comments": List<CommentResponse>.from(comments.map((x) => x.toJson())),
        "users": users.toJson(),
      };
}

class Users {
  Users({
    this.userId,
    this.categories,
    this.thumbnailUrl,
    this.username,
    this.firstName,
    this.lastName,
    this.emailAddress,
    this.phoneNumber,
    this.branchId,
    this.enabled,
  });

  double userId;
  List<Category> categories;
  String thumbnailUrl;
  String username;
  String firstName;
  String lastName;
  String emailAddress;
  String phoneNumber;
  String branchId;
  bool enabled;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        userId: json["userId"].toDouble(),
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        thumbnailUrl: json["thumbnailUrl"],
        username: json["username"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        emailAddress: json["emailAddress"],
        phoneNumber: json["phoneNumber"],
        branchId: json["branchId"],
        enabled: json["enabled"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "thumbnailUrl": thumbnailUrl,
        "username": username,
        "firstName": firstName,
        "lastName": lastName,
        "emailAddress": emailAddress,
        "phoneNumber": phoneNumber,
        "branchId": branchId,
        "enabled": enabled,
      };
}

class Category {
  Category({
    this.categoryId,
    this.name,
    this.publicView,
    this.branchId,
  });

  int categoryId;
  String name;
  bool publicView;
  String branchId;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: json["categoryId"],
        name: json["name"],
        publicView: json["publicView"],
        branchId: json["branchId"],
      );

  Map<String, dynamic> toJson() => {
        "categoryId": categoryId,
        "name": name,
        "publicView": publicView,
        "branchId": branchId,
      };
}

