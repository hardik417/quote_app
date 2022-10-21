import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quote_app/controller/favouritecontroller.dart';
import 'package:quote_app/dbhelper/dbhelper.dart';
import 'package:quote_app/ui/AuthorQuote.dart';
import 'package:quote_app/widgets/Txt.dart';
import 'package:sqflite/sqflite.dart';

import '../widgets/CommonAppBar.dart';

class FavoriteQuote extends StatefulWidget {
  const FavoriteQuote({Key? key}) : super(key: key);

  @override
  _FavoriteQuoteState createState() => _FavoriteQuoteState();
}

class _FavoriteQuoteState extends State<FavoriteQuote> {
FavouriteController favouriteController = Get.put(FavouriteController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favouriteController.getdbdata();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: commonAppBar("Favorite Quote") as PreferredSizeWidget,
          body: GetBuilder(
        builder: (FavouriteController controller) {
          return SafeArea(
            child: controller.isloading ? Center(child: CircularProgressIndicator(color: Colors.orangeAccent.shade200,)) :controller.data.length == 0 ? Center(child: Txt("No Data Found!",color: Colors.blue,size: 18,fontWeight: FontWeight.w600),):ListView.builder(
              itemCount: controller.data.length,
              itemBuilder: (context, index) {
                return authorList(index,controller);
              },
            ),
          );
        }
      ),
    ));
  }

  Widget authorList(int index, FavouriteController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),topRight: Radius.circular(5),
                ),
                color: Colors.deepOrange.shade100,
              ),
              width: double.infinity,
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Txt(
                    controller.data[index]['name'],
                    size: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {

                        controller.deletedata(index);
                        controller.removelike(name: controller.data[index]['name']);
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
            ),
            SizedBox(height: Get.height*0.008),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex :1,
                    child: Txt(
                      "Desc: ",
                      size: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      txtAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                      child: Txt(
                        controller.data[index]['desc'],
                        size: 15,
                        color: Colors.green,
                        maxLine: 2,
                        isOverFlow: true,
                        txtAlign: TextAlign.start,
                      ))
                ],
              ),
            ),
            SizedBox(height: Get.height*0.008),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  
                  Expanded(
                    flex:1,
                    child: Txt(
                      "Link: ",
                      size: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      txtAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                      child: Txt(
                        controller.data[index]['link'],
                        size: 15,
                        color: Colors.blue,
                        maxLine: 2,
                        isOverFlow: true,
                        txtAlign: TextAlign.start,
                      ))
                ],
              ),
            ),
            SizedBox(height: Get.height*0.008),
          ],
        ),
      ),
    );
  }
}
