// To parse this JSON data, do
//
//     final authorListResponse = authorListResponseFromJson(jsonString);

import 'dart:convert';

AuthorListResponse authorListResponseFromJson(String str) => AuthorListResponse.fromJson(json.decode(str));

String authorListResponseToJson(AuthorListResponse data) => json.encode(data.toJson());

class AuthorListResponse {
  AuthorListResponse({
    this.count,
    this.totalCount,
    this.page,
    this.totalPages,
    this.lastItemIndex,
    this.results,
  });

  int? count;
  int? totalCount;
  int? page;
  int? totalPages;
  int? lastItemIndex;
  List<AuthorList>? results;

  factory AuthorListResponse.fromJson(Map<String, dynamic> json) => AuthorListResponse(
    count: json["count"] == null ? null : json["count"],
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    page: json["page"] == null ? null : json["page"],
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    lastItemIndex: json["lastItemIndex"] == null ? null : json["lastItemIndex"],
    results: json["results"] == null ? null : List<AuthorList>.from(json["results"].map((x) => AuthorList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count == null ? null : count,
    "totalCount": totalCount == null ? null : totalCount,
    "page": page == null ? null : page,
    "totalPages": totalPages == null ? null : totalPages,
    "lastItemIndex": lastItemIndex == null ? null : lastItemIndex,
    "results": results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class AuthorList {
  AuthorList({
    this.id,
    this.name,
    this.bio,
    this.description,
    this.link,
    this.quoteCount,
    this.slug,
    this.dateAdded,
    this.dateModified,
  });

  String? id;
  String? name;
  String? bio;
  String? description;
  String? link;
  int? quoteCount;
  String? slug;
  DateTime? dateAdded;
  DateTime? dateModified;

  factory AuthorList.fromJson(Map<String, dynamic> json) => AuthorList(
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    bio: json["bio"] == null ? null : json["bio"],
    description: json["description"] == null ? null : json["description"],
    link: json["link"] == null ? null : json["link"],
    quoteCount: json["quoteCount"] == null ? null : json["quoteCount"],
    slug: json["slug"] == null ? null : json["slug"],
    dateAdded: json["dateAdded"] == null ? null : DateTime.parse(json["dateAdded"]),
    dateModified: json["dateModified"] == null ? null : DateTime.parse(json["dateModified"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "bio": bio == null ? null : bio,
    "description": description == null ? null : description,
    "link": link == null ? null : link,
    "quoteCount": quoteCount == null ? null : quoteCount,
    "slug": slug == null ? null : slug,
    "dateAdded": dateAdded == null ? null : "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
    "dateModified": dateModified == null ? null : "${dateModified!.year.toString().padLeft(4, '0')}-${dateModified!.month.toString().padLeft(2, '0')}-${dateModified!.day.toString().padLeft(2, '0')}",
  };
}
