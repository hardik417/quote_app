import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quote_app/utils/ApiParam.dart';

import '../model/AuthorListResponse.dart';
import '../model/SearchQuoteResponse.dart';

class ApiRepository{
  late AuthorListResponse authorListResponse;
  late SearchQuoteResponse searchQuoteResponse;

 Future<AuthorListResponse> authorList(String limit) async {
    http.Response response = await http.get(Uri.parse("${ApiParam.baseURL}authors?limit=$limit"));

    if(response.statusCode == 200){
      authorListResponse = AuthorListResponse.fromJson(json.decode(response.body));
      return authorListResponse;
    }else{
     throw Exception("Something Went Wrong!");
    }
  }

  Future<AuthorListResponse> searchAuthorData(String name) async {
    http.Response response = await http.get(Uri.parse("${ApiParam.baseURL}search/authors?query=$name"));

    print("object response ${response.body}");
    if(response.statusCode == 200){
      authorListResponse = AuthorListResponse.fromJson(json.decode(response.body));
      return authorListResponse;
    }else{
      throw Exception("Something Went Wrong!");
    }
  }
  Future<SearchQuoteResponse> searchQuoteData({required String name,required String length}) async {
    http.Response response = await http.get(Uri.parse("${ApiParam.baseURL}search/quotes?query=life%$name&limit=$length"));

    print("object response ${response.body}");
    if(response.statusCode == 200){
      searchQuoteResponse = SearchQuoteResponse.fromJson(json.decode(response.body));
      return searchQuoteResponse;
    }else{
      throw Exception("Something Went Wrong!");
    }
  }
}