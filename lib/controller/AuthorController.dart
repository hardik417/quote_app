
import 'package:get/get.dart';
import 'package:quote_app/network/ApiRepository.dart';

import '../model/AuthorListResponse.dart';

class AuthorController extends GetxController{
  bool isLoading = false;
  bool isScroll = false;

  List<AuthorList> authorList = [];

  updateLoading(bool isLoad){
    isLoading = isLoad;
    update();
  }

  updateScroll(bool isScroll){
    this.isScroll = isScroll;
    update();
  }

  updateList(List<AuthorList> data){
    authorList = data;
    print("object authorList : ${authorList.length}");
    update();
  }

  Future<AuthorListResponse> getAuthorList(String limit){
    Future<AuthorListResponse> data;
    data =
    ApiRepository().authorList(limit);
    return data;
  }
}