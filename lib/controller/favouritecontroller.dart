import 'package:get/get.dart';
import 'package:quote_app/dbhelper/dbhelper.dart';
import 'package:quote_app/ui/AuthorQuote.dart';

import '../helper/PreferenceHelper.dart';

class FavouriteController extends GetxController{
  bool isloading = false;
  Dbhelper dd = Dbhelper();
  List<Map> data = [];

  void getdbdata() {
    isloading = true;
    update();
    dd.viewdb(finaldb).then((value) {
      print(value);
        data = value;
        isloading = false;
        update();
    });

  }

  removelike({required String name}){
    PreferenceHelper.saveisliked(name,false);
  }

  deletedata(int index){
    dd.deletedata(db: finaldb, id: data[index]['name']);
    getdbdata();
    update();
  }
}