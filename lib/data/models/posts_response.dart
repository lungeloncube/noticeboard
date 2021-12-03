// To parse this JSON data, do
//
//     final postsResponse = postsResponseFromJson(jsonString);

import 'dart:convert';

PostsResponse postsResponseFromJson(String str) =>
    PostsResponse.fromJson(json.decode(str));

String postsResponseToJson(PostsResponse data) => json.encode(data.toJson());

class PostsResponse {
  PostsResponse({
    this.posts,
  });

  List<Post> posts;

  factory PostsResponse.fromJson(Map<String, dynamic> json) => PostsResponse(
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

class Post {
  Post({
    this.postId,
    this.postText,
    this.createdAt,
    this.expirationDate,
    this.views,
    this.likes,
    this.dislikes,
    this.category,
    this.mediaFiles,
    this.comments,
    this.users,
  });

  String postId;
  String postText;
  DateTime createdAt;
  DateTime expirationDate;
  int views;
  int likes;
  int dislikes;
  Category category;
  List<MediaFile> mediaFiles;
  List<Comment> comments;
  Users users;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        postId: json["postId"],
        postText: json["postText"],
        createdAt: DateTime.parse(json["createdAt"]),
        expirationDate: DateTime.parse(json["expirationDate"]),
        views: json["views"],
        likes: json["likes"],
        dislikes: json["dislikes"],
        category: Category.fromJson(json["category"]),
        mediaFiles: List<MediaFile>.from(
            json["mediaFiles"].map((x) => MediaFile.fromJson(x))),
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        users: Users.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "postText": postText,
        "createdAt": createdAt.toIso8601String(),
        "expirationDate": expirationDate.toIso8601String(),
        "views": views,
        "likes": likes,
        "dislikes": dislikes,
        "category": category.toJson(),
        "mediaFiles": List<dynamic>.from(mediaFiles.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "users": users.toJson(),
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

class Comment {
  Comment({
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
  List<dynamic> comments;
  Users users;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        commentId: json["commentId"],
        commentText: json["commentText"],
        createdAt: DateTime.parse(json["createdAt"]),
        views: json["views"],
        likes: json["likes"],
        dislikes: json["dislikes"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        users: Users.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "commentText": commentText,
        "createdAt": createdAt.toIso8601String(),
        "views": views,
        "likes": likes,
        "dislikes": dislikes,
        "comments": List<dynamic>.from(comments.map((x) => x)),
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

  var userId;
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
        userId: json["userId"],
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

class MediaFile {
  MediaFile({
    this.mediaId,
    this.url,
    this.thumbnailUrl,
    this.type,
    this.views,
  });

  String mediaId;
  String url;
  String thumbnailUrl;
  String type;
  int views;

  factory MediaFile.fromJson(Map<String, dynamic> json) => MediaFile(
        mediaId: json["mediaId"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
        type: json["type"],
        views: json["views"],
      );

  Map<String, dynamic> toJson() => {
        "mediaId": mediaId,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
        "type": type,
        "views": views,
      };
}
