import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:quote_app/helper/PreferenceHelper.dart';
import 'package:quote_app/widgets/Txt.dart';
import 'package:quote_app/widgets/WidgetButton.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/AuthorController.dart';
import '../dbhelper/dbhelper.dart';
import '../widgets/CommonAppBar.dart';
import '../widgets/TextField.dart';

late Database finaldb;
Dbhelper dd = Dbhelper();

getdb() {
  dd.createdb().then((value) {
    finaldb = value;
    AuthorQuote().createState().getdbdata();
  });
}

class AuthorQuote extends StatefulWidget {
  const AuthorQuote({Key? key}) : super(key: key);

  @override
  _AuthorQuoteState createState() => _AuthorQuoteState();
}

class _AuthorQuoteState extends State<AuthorQuote> {
  AuthorController authorController = Get.put(AuthorController());
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  int limit = 10;


  Dbhelper dd = Dbhelper();
  List<Map> data = [];

  void getdbdata() {
    dd.viewdb(finaldb).then((value) {
      print(value);
        data = value;
    });
  }

  @override
  void initState() {
    getAuthor(false);
    super.initState();
    getdb();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        print("IS SCROLLING");
        getAuthor(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: GetBuilder(builder: (AuthorController controller) {
      return Scaffold(
        appBar: commonAppBar("Author List") as PreferredSizeWidget,
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormInputField(
                    controller: searchController,
                    hintText: "Search Author",
                    labelText: "Author Name", onTap: () {
                    searchController.text.isNotEmpty ? getAuthorData() : Fluttertoast.showToast(msg: "Please enter Author name", backgroundColor: Colors.red);
                  },
                    onChanged: (value){
                      value.isEmpty
                          ? getAuthor(true)
                          : null;
                    },
                  ),
                ),
              ],
            ),
            controller.isLoading
                ?  Expanded(child: Center(child: CircularProgressIndicator(color: Colors.orangeAccent.shade200)))
                : controller.authorList.isNotEmpty
                    ? Expanded(
                        child: Stack(
                          children: [
                            ListView.builder(
                              controller: scrollController,
                              itemCount: controller.authorList.length,
                              itemBuilder: (context, index) {
                                return authorList(index, controller);
                              },
                            ),
                            controller.isScroll ?  Center(child: CircularProgressIndicator(color: Colors.orangeAccent.shade200)) : const SizedBox()
                          ],
                        ),
                      )
                    : Expanded(
                        child: Center(
                            child: Txt(
                          "No Data Found!",
                          size: 20,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
          ],
        ),
      );
    }));
  }

  void getAuthor(bool isScroll) {
    isScroll ? authorController.updateScroll(true) : authorController.updateLoading(true);

    print("object limit $limit");
    authorController.getAuthorList(limit.toString()).then((response) {
      if (response.results!.isNotEmpty) {
        if (limit == 10) {
          authorController.authorList.clear();
          authorController.updateList(response.results!);
          authorController.updateScroll(false);
          authorController.updateLoading(false);
          limit = limit + 10;
        } else {
          authorController.updateList(response.results!);
          authorController.updateScroll(false);
          authorController.updateLoading(false);
          limit = limit + 10;
        }
      } else {
        authorController.authorList.clear();
        authorController.updateScroll(false);
        authorController.updateLoading(false);
      }
    });
  }

  Widget authorList(int index, AuthorController controller) {
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
                    controller.authorList[index].name.toString(),
                    size: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        getdbdata();
                       if(PreferenceHelper.getisliked(controller.authorList[index].name.toString())){
                         dd.deletedata(db: finaldb, id: controller.authorList[index].name.toString());
                          PreferenceHelper.saveisliked(controller.authorList[index].name.toString(),false);
                        } else {
                         dd.adddata(
                             db: finaldb, desc: controller.authorList[index].description.toString(), link: controller.authorList[index].link.toString(), name: controller.authorList[index].name.toString());
                         getdbdata();
                         PreferenceHelper.saveisliked(controller.authorList[index].name.toString(),true);
                        }
                        setState(() {      });
                      },
                      icon: PreferenceHelper.getisliked(controller.authorList[index].name.toString()) ? Icon(Icons.favorite_outlined) : Icon(Icons.favorite_outline))
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
                    flex: 1,
                    child: Txt(
                      "BIO: ",
                      size: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      txtAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                      child: Txt(
                    controller.authorList[index].bio.toString(),
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
                    flex: 1,
                    child: Txt(

                      "description: ",
                      size: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      txtAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                      child: Txt(
                    controller.authorList[index].description.toString(),
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
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
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
                    child: GestureDetector(
                        onTap: () {
                          launchURL(controller.authorList[index].link.toString());
                        },
                        child: Txt(controller.authorList[index].link.toString(), size: 15, color: Colors.blue, maxLine: 5)),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height*0.008),
          ],
        ),
      ),
    );
  }

  static void launchURL(url) async {
    await launchUrl(Uri.parse(url));
  }

  void getAuthorData() {
    authorController.updateLoading(true);
    authorController.getAuthorData(searchController.text.toString()).then((response) {
        authorController.authorList.clear();
      if(response.results!.isNotEmpty){
        authorController.updateList(response.results!);
        authorController.updateLoading(false);
      }
        authorController.updateLoading(false);
    });
    }
}
