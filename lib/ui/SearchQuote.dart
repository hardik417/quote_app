import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controller/searchController.dart';
import '../widgets/CommonAppBar.dart';
import '../widgets/TextField.dart';
import '../widgets/Txt.dart';
import '../widgets/WidgetButton.dart';

class SearchQuote extends StatefulWidget {
  const SearchQuote({Key? key}) : super(key: key);

  @override
  _SearchQuoteState createState() => _SearchQuoteState();
}

class _SearchQuoteState extends State<SearchQuote> {
  TextEditingController searchController = TextEditingController(text: "happiness");
  SearchController searchControll = Get.put(SearchController());
  List<String> list = <String>['10', '30', '40', '60', '80', '100'];

  @override
  void initState() {
    getQuoteData();
    searchControll.updateValue("10");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: commonAppBar("Search Quote") as PreferredSizeWidget,
      body: GetBuilder(builder: (SearchController controller) {
        return Column(
          children: [
            SizedBox(height: Get.height * 0.02),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormInputField(
                    controller: searchController,
                    hintText: "Ex. happiness, sad, friendship",
                    labelText: "Search Quote",
                    onTap: () {
                      searchController.text.isNotEmpty ? getQuoteData() : Fluttertoast.showToast(msg: "Please enter Quote name", backgroundColor: Colors.red);
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.black)),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DropdownButton<String>(
                      value: controller.dropdownValue,
                      isExpanded: true,
                      icon: const Icon(Icons.arrow_downward, size: 15),
                      elevation: 16,
                      style: const TextStyle(color: Colors.blue),
                      underline: const SizedBox(),
                      onChanged: (String? value) {
                        controller.updateValue(value.toString());
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Txt(value, color: Colors.black),
                        );
                      }).toList(),
                    ),
                  ),
                )
              ],
            ),
            controller.isScroll
                ? Expanded(child: Center(child: CircularProgressIndicator(color: Colors.orangeAccent.shade200)))
                : controller.authorList.isNotEmpty
                    ? Expanded(
                        child: Stack(
                          children: [
                            ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: controller.authorList.length,
                              itemBuilder: (context, index) {
                                return authorList(index, controller);
                              },
                            ),
                            controller.isScroll ? const Center(child: CircularProgressIndicator()) : const SizedBox()
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
        );
      }),
    ));
  }

  Widget authorList(int index, SearchController controller) {
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
              child: Txt(
                controller.authorList[index].author.toString(),
                size: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 8.0),
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
                        controller.authorList[index].content.toString(),
                        size: 15,
                        color: Colors.green,
                        maxLine: 2,
                        isOverFlow: true,
                        txtAlign: TextAlign.start,
                      ))
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 8.0),
              child: Row(
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
                        controller.authorList[index].tags.toString().replaceAll("[", "").replaceAll("]", "").toString(),
                        size: 15,
                        color: Colors.green,
                        maxLine: 2,
                        isOverFlow: true,
                        txtAlign: TextAlign.start,
                      ))
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.01),
          ],
        ),
      ),
    );
  }

  getQuoteData() {
    searchControll.updateScroll(true);
    searchControll.getAuthorList(name: searchController.text.toString(), length: searchControll.dropdownValue.toString()).then((response) {
      if (response.results!.isNotEmpty) {
        searchControll.authorList.clear();
        searchControll.updateList(response.results!);
        searchControll.updateScroll(false);
      }
    });
  }
}
