import 'package:flutter/material.dart';
import 'package:testproject/generated/assets.dart';
import 'package:testproject/main.dart';
import 'package:testproject/venomk3/text_widget.dart';
import 'package:testproject/venomupdate/amountbottomsheetUpdate.dart';


class TotalScreen extends StatefulWidget {
  final int tabindex;
  const TotalScreen({super.key, required this.tabindex});

  @override
  _TotalScreenState createState() => _TotalScreenState();
}

class _TotalScreenState extends State<TotalScreen> {
  PersistentBottomSheetController? _bottomSheetController;

  final TextEditingController amount = TextEditingController();

  List<Map<String, dynamic>> totalitems = [
    {"id":"1","centerno":Assets.assetsRedPlainK3,"no":"3","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"2","centerno":Assets.assetsGreenPlainK3,"no":"4","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"3","centerno":Assets.assetsRedPlainK3,"no":"5","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"4","centerno":Assets.assetsGreenPlainK3,"no":"6","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"5","centerno":Assets.assetsRedPlainK3,"no":"7","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"6","centerno":Assets.assetsGreenPlainK3,"no":"8","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"7","centerno":Assets.assetsRedPlainK3,"no":"9","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"8","centerno":Assets.assetsGreenPlainK3,"no":"10","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"9","centerno":Assets.assetsRedPlainK3,"no":"11","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"10","centerno":Assets.assetsGreenPlainK3,"no":"12","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"11","centerno":Assets.assetsRedPlainK3,"no":"13","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"12","centerno":Assets.assetsGreenPlainK3,"no":"14","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"13","centerno":Assets.assetsRedPlainK3,"no":"15","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"14","centerno":Assets.assetsGreenPlainK3,"no":"16","subtitle":"207.36X","color":Colors.green,"title":"Total"},
    {"id":"15","centerno":Assets.assetsRedPlainK3,"no":"17","subtitle":"207.36X","color":Colors.red,"title":"Total"},
    {"id":"16","centerno":Assets.assetsGreenPlainK3,"no":"18","subtitle":"207.36X","color":Colors.green,"title":"Total"},
  ];

  List<Map<String, dynamic>> sizeTypeList = [
    {"id":"1","no":"Big", "centerno":"1.98", "color":Colors.orange,"title":"Total"},
    {"id":"2","no":"Small", "centerno":"1.98", "color":Colors.blue,"title":"Total"},
    {"id":"3","no":"Even", "centerno":"1.98", "color":Colors.green,"title":"Total"},
    {"id":"4","no":"Odd", "centerno":"1.98", "color":Colors.red,"title":"Total"},
  ];


  late List<List<Map<String, dynamic>>> allLists;
  Set<Map<String, dynamic>> selectedItems = {};
  int updateAmount = 0;

  int value = 1;

  @override
  void initState() {
    super.initState();
    allLists = [totalitems, sizeTypeList];
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
  void handleSelectionSize(Map<String, dynamic> selectedItem) {
    setState(() {
      if (selectedItems.contains(selectedItem)) {
        selectedItems.remove(selectedItem);
      } else {
        if (selectedItem['no'] == "Big" && selectedItems.any((item) => item['no'] == "Small")) {
          selectedItems.removeWhere((item) => item['no'] == "Small");
          print("hdtjudrkj");
        } else if (selectedItem['no'] == "Small" && selectedItems.any((item) => item['no'] == "Big")) {
          selectedItems.removeWhere((item) => item['no'] == "Big");
          print("jtfjrj");
        } else if (selectedItem['no'] == "Even" && selectedItems.any((item) => item['no'] == "Odd")) {
          selectedItems.removeWhere((item) => item['no'] == "Odd");
          print("hndftdjd");
        } else if (selectedItem['no'] == "Odd" && selectedItems.any((item) => item['no'] == "Even")) {
          selectedItems.removeWhere((item) => item['no'] == "Even");
          print("kdtyd");
        }
        selectedItems.add(selectedItem);
      }
    }
    );
  }

  void showPersistentBottomSheet(BuildContext context) {
    if (_bottomSheetController != null) {
      _bottomSheetController!.close();

    }
    _bottomSheetController = Scaffold.of(context).showBottomSheet(
          (BuildContext context) {
        return AmountBottomSheetUpdateD(itemSelect: selectedItems.toList(), tabindex: 0);
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
              child: allLists.isNotEmpty ? GridView.builder(
                itemCount: allLists[0].length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, listIndex) {
                  final item = allLists[0][listIndex];

                  return InkWell(
                    onTap: () {
                      handleSelection(item);
                      showPersistentBottomSheet(context);
                    },
                    child: Column(
                      children: [
                        Container(
                          height: height * 0.06,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(item['centerno'].toString()),
                            ),
                          ),
                          child: Center(
                            child: textWidget(
                              text: item['no'],
                              fontSize: width * 0.05,
                              fontWeight: FontWeight.bold,
                              color: item['color'],
                            ),
                          ),
                        ),
                        textWidget(
                          text: item['subtitle'],
                          fontSize: width * 0.034,
                          color: Colors.grey,
                        ),
                      ],
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
                  return InkWell(
                      onTap: () {
                        handleSelectionSize(items);
                        showPersistentBottomSheet(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          height: 40,
                          width: 70,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: items['color'],
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              textWidget(
                                text: items['no'],
                                fontSize: width * 0.04,
                                color: Colors.white,
                              ),
                              textWidget(
                                text: items['centerno'],
                                fontSize: width * 0.04,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      )
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