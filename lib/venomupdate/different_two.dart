import 'package:flutter/material.dart';
import 'package:testproject/generated/assets.dart';
import 'package:testproject/main.dart';
import 'package:testproject/venomk3/text_widget.dart';
import 'package:testproject/venomupdate/amountbottomsheetUpdate.dart';


class DifferentScreen extends StatefulWidget {
  final int tabindex;
  const DifferentScreen({super.key, required this.tabindex});

  @override
  _DifferentScreenState createState() => _DifferentScreenState();
}

class _DifferentScreenState extends State<DifferentScreen> {
  PersistentBottomSheetController? _bottomSheetController;

  final TextEditingController amount = TextEditingController();

  List<Map<String, dynamic>> sametwoitemone = [
    {"id":"1", "no":11,"title":"2 matching numbers: odd(13.83)","color":const Color(0xff784a9c)},
    {"id":"2", "no":22,"title":"2 matching numbers: odd(13.83)","color":const Color(0xff784a9c)},
    {"id":"3", "no":33,"title":"2 matching numbers: odd(13.83)","color":const Color(0xff784a9c)},
    {"id":"4", "no":44,"title":"2 matching numbers: odd(13.83)","color":const Color(0xff784a9c)},
    {"id":"5", "no":55,"title":"2 matching numbers: odd(13.83)","color":const Color(0xff784a9c)},
    {"id":"6", "no":66,"title":"2 matching numbers: odd(13.83)","color":const Color(0xff784a9c)},
  ];

  List<Map<String, dynamic>> sametwoitemtwo = [
    {"id":"1", "no":11,"title":"A pair of unique numbers:odds(69.12)","color":const Color(0xfffb9494)},
    {"id":"2", "no":22,"title":"A pair of unique numbers:odds(69.12)","color":const Color(0xfffb9494)},
    {"id":"3", "no":33,"title":"A pair of unique numbers:odds(69.12)","color":const Color(0xfffb9494)},
    {"id":"4", "no":44,"title":"A pair of unique numbers:odds(69.12)","color":const Color(0xfffb9494)},
    {"id":"5", "no":55,"title":"A pair of unique numbers:odds(69.12)","color":const Color(0xfffb9494)},
    {"id":"6", "no":66,"title":"A pair of unique numbers:odds(69.12)","color":const Color(0xfffb9494)},
  ];

  List<Map<String, dynamic>> sametwoitemthree= [
    {"id":"1", "no":1,"title":" ","color":const Color(0xff3d7456)},
    {"id":"2", "no":2,"title":" ","color":const Color(0xff3d7456)},
    {"id":"3", "no":3,"title":" ","color":const Color(0xff3d7456)},
    {"id":"4", "no":4,"title":" ","color":const Color(0xff3d7456)},
    {"id":"5", "no":5,"title":" ","color":const Color(0xff3d7456)},
    {"id":"6", "no":6,"title":" ","color":const Color(0xff3d7456)},
  ];


  late List<List<Map<String, dynamic>>> allLists;
  Set<Map<String, dynamic>> selectedItems = {};
  int updateAmount = 0;

  int value = 1;

  @override
  void initState() {
    super.initState();
    allLists = [sametwoitemone, sametwoitemtwo, sametwoitemthree];
  }

  void handleSelection(Map<String, dynamic> selectedItem) {
    setState(() {
      if (selectedItems.contains(selectedItem)) {
        selectedItems.remove(selectedItem);
      } else {
        selectedItems.add(selectedItem);
      }
      updateAmount = selectedItems.length * value;
    }
    );
  }
  void handleSelectionfirst(Map<String, dynamic> selectedItem) {
    setState(() {
      selectedItems.removeWhere((element) => element["id"].toString()==selectedItem["id"].toString());
      selectedItems.add(selectedItem);
    }
    );
  }

  void showPersistentBottomSheet(BuildContext context) {
    if (_bottomSheetController != null) {
      _bottomSheetController!.close();

    }
    _bottomSheetController = Scaffold.of(context).showBottomSheet(
          (BuildContext context) {
        return AmountBottomSheetUpdateD(
            itemSelect: selectedItems.toList(),
           tabindex:widget.tabindex

        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: height*0.40,
              child: allLists.isNotEmpty ? ListView.builder(
                itemCount: allLists[0].length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, listIndex) {
                  final item = allLists[0][listIndex];

                  return InkWell(
                    onTap: () {
                      handleSelection(item);
                      showPersistentBottomSheet(context);
                    },
                    child:Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Center(
                        child: Container(
                          height: 36,
                          width: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xffdaacfe),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: textWidget(
                            text: item['no'].toString(),
                            fontSize: width * 0.04,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ) : Container(),
            ),

            SizedBox(
              height: height * 0.015,
            ),

            Container(
                height: 50,
                child: allLists.isNotEmpty?ListView.builder(
                  itemCount: allLists[1].length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, listIndex) {
                    final items = allLists[1][listIndex];
                    return  InkWell(
                      onTap: () async {

                        handleSelectionfirst(items);
                        showPersistentBottomSheet(context);



                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 40,
                          width: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xfffb9494),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: textWidget(
                            text: items["no"].toString(),
                            fontSize: width * 0.04,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ):Container()
            ),

            SizedBox(
              height: height * 0.02,
            ),
            Container(
                height: 50,
                child: allLists.isNotEmpty?ListView.builder(
                  itemCount: allLists[2].length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, listIndex) {
                    final items = allLists[2][listIndex];
                    return  InkWell(
                      onTap: () async {
                        handleSelectionfirst(items);
                        showPersistentBottomSheet(context);

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 40,
                          width: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xff3d7456),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: textWidget(
                            text: items["no"].toString(),
                            fontSize: width * 0.04,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ):Container()
            ),


          ],
        ),
      ),
    );
  }
}