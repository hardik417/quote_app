
import 'package:get/get.dart';

import '../model/AuthorListResponse.dart';
import '../model/SearchQuoteResponse.dart';
import '../network/ApiRepository.dart';

class SearchController extends GetxController{
  String dropdownValue = "10";
  List<SearchData> authorList = [];
  bool isScroll = false;

  updateScroll(bool isScroll) {
    this.isScroll = isScroll;
    update();
  }

  updateValue(String value){
    dropdownValue = value;
    update();
  }

  updateList(List<SearchData> data) {
    authorList = data;
    update();
  }

  Future<SearchQuoteResponse> getAuthorList({required String name,required String length}) {
    Future<SearchQuoteResponse> data;
    data = ApiRepository().searchQuoteData(name: name,length: length);
    return data;
  }
}