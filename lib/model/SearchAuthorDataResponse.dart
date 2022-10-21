// To parse this JSON data, do
//
//     final searchAuthorDataResponse = searchAuthorDataResponseFromJson(jsonString);

import 'dart:convert';

SearchAuthorDataResponse searchAuthorDataResponseFromJson(String str) => SearchAuthorDataResponse.fromJson(json.decode(str));

String searchAuthorDataResponseToJson(SearchAuthorDataResponse data) => json.encode(data.toJson());

class SearchAuthorDataResponse {
  SearchAuthorDataResponse({
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
  dynamic lastItemIndex;
  List<AuthorData>? results;

  factory SearchAuthorDataResponse.fromJson(Map<String, dynamic> json) => SearchAuthorDataResponse(
    count: json["count"] == null ? null : json["count"],
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    page: json["page"] == null ? null : json["page"],
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    lastItemIndex: json["lastItemIndex"],
    results: json["results"] == null ? null : List<AuthorData>.from(json["results"].map((x) => AuthorData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count == null ? null : count,
    "totalCount": totalCount == null ? null : totalCount,
    "page": page == null ? null : page,
    "totalPages": totalPages == null ? null : totalPages,
    "lastItemIndex": lastItemIndex,
    "results": results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class AuthorData {
  AuthorData({
    this.id,
    this.name,
    this.link,
    this.bio,
    this.description,
    this.quoteCount,
    this.slug,
    this.dateAdded,
    this.dateModified,
  });

  String? id;
  String? name;
  String? link;
  String? bio;
  String? description;
  int? quoteCount;
  String? slug;
  DateTime? dateAdded;
  DateTime? dateModified;

  factory AuthorData.fromJson(Map<String, dynamic> json) => AuthorData(
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    link: json["link"] == null ? null : json["link"],
    bio: json["bio"] == null ? null : json["bio"],
    description: json["description"] == null ? null : json["description"],
    quoteCount: json["quoteCount"] == null ? null : json["quoteCount"],
    slug: json["slug"] == null ? null : json["slug"],
    dateAdded: json["dateAdded"] == null ? null : DateTime.parse(json["dateAdded"]),
    dateModified: json["dateModified"] == null ? null : DateTime.parse(json["dateModified"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "link": link == null ? null : link,
    "bio": bio == null ? null : bio,
    "description": description == null ? null : description,
    "quoteCount": quoteCount == null ? null : quoteCount,
    "slug": slug == null ? null : slug,
    "dateAdded": dateAdded == null ? null : "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
    "dateModified": dateModified == null ? null : "${dateModified!.year.toString().padLeft(4, '0')}-${dateModified!.month.toString().padLeft(2, '0')}-${dateModified!.day.toString().padLeft(2, '0')}",
  };
}
