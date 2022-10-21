// To parse this JSON data, do
//
//     final searchQuoteResponse = searchQuoteResponseFromJson(jsonString);

import 'dart:convert';

SearchQuoteResponse searchQuoteResponseFromJson(String str) => SearchQuoteResponse.fromJson(json.decode(str));

String searchQuoteResponseToJson(SearchQuoteResponse data) => json.encode(data.toJson());

class SearchQuoteResponse {
  SearchQuoteResponse({
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
  List<SearchData>? results;

  factory SearchQuoteResponse.fromJson(Map<String, dynamic> json) => SearchQuoteResponse(
    count: json["count"] == null ? null : json["count"],
    totalCount: json["totalCount"] == null ? null : json["totalCount"],
    page: json["page"] == null ? null : json["page"],
    totalPages: json["totalPages"] == null ? null : json["totalPages"],
    lastItemIndex: json["lastItemIndex"] == null ? null : json["lastItemIndex"],
    results: json["results"] == null ? null : List<SearchData>.from(json["results"].map((x) => SearchData.fromJson(x))),
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

class SearchData {
  SearchData({
    this.id,
    this.content,
    this.author,
    this.tags,
    this.authorId,
    this.authorSlug,
    this.length,
    this.dateAdded,
    this.dateModified,
  });

  String? id;
  String? content;
  String? author;
  List<String>? tags;
  String? authorId;
  String? authorSlug;
  int? length;
  DateTime? dateAdded;
  DateTime? dateModified;

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
    id: json["_id"] == null ? null : json["_id"],
    content: json["content"] == null ? null : json["content"],
    author: json["author"] == null ? null : json["author"],
    tags: json["tags"] == null ? null : List<String>.from(json["tags"].map((x) => x)),
    authorId: json["authorId"] == null ? null : json["authorId"],
    authorSlug: json["authorSlug"] == null ? null : json["authorSlug"],
    length: json["length"] == null ? null : json["length"],
    dateAdded: json["dateAdded"] == null ? null : DateTime.parse(json["dateAdded"]),
    dateModified: json["dateModified"] == null ? null : DateTime.parse(json["dateModified"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "content": content == null ? null : content,
    "author": author == null ? null : author,
    "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x)),
    "authorId": authorId == null ? null : authorId,
    "authorSlug": authorSlug == null ? null : authorSlug,
    "length": length == null ? null : length,
    "dateAdded": dateAdded == null ? null : "${dateAdded!.year.toString().padLeft(4, '0')}-${dateAdded!.month.toString().padLeft(2, '0')}-${dateAdded!.day.toString().padLeft(2, '0')}",
    "dateModified": dateModified == null ? null : "${dateModified!.year.toString().padLeft(4, '0')}-${dateModified!.month.toString().padLeft(2, '0')}-${dateModified!.day.toString().padLeft(2, '0')}",
  };
}
