import 'package:flutter/material.dart';

class testPage extends StatefulWidget {
  final int tabindex;
  testPage({super.key, required this.tabindex});

  @override
  _testPageState createState() => _testPageState();
}

class _testPageState extends State<testPage> {
  PersistentBottomSheetController? _bottomSheetController;
  final TextEditingController amount = TextEditingController();

  List<int> list = [1, 10, 100, 1000];

  List<Map<String, dynamic>> bigList = [
    {"id": "1", "no": 1, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
    {"id": "2", "no": 2, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
    {"id": "3", "no": 3, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
    {"id": "4", "no": 4, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
    {"id": "5", "no": 5, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
    {"id": "6", "no": 6, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
  ];

  List<Map<String, dynamic>> smallList = [
    {"id": "1", "no": 1, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
    {"id": "2", "no": 2, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
    {"id": "3", "no": 3, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
    {"id": "4", "no": 4, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
    {"id": "5", "no": 5, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
    {"id": "6", "no": 6, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
  ];

  List<Map<String, dynamic>> evenList = [
    {"id": "1", "no": "3 continuous numbers", "color": const Color(0xfffb9494), "title": "3 continuous number: odds (34.36)"},
  ];

  late List<List<Map<String, dynamic>>> allLists;
  List<Map<String, dynamic>> selectedItems = [];
  List<int> multiplierList = [1, 10, 100, 1000];
  int selectedIndex = 0;
  int updateAmount = 0;

  int value = 1;

  @override
  void initState() {
    super.initState();
    allLists = [bigList, smallList, evenList];
  }

  void handleSelection(Map<String, dynamic> selectedItem) {
    setState(() {
      if (selectedItems.contains(selectedItem)) {
        selectedItems.remove(selectedItem);
      } else {
        selectedItems.add(selectedItem);
      }
      updateAmount = selectedItems.length * value;
    });
  }

  void selectam(int selectedIndex) {
    setState(() {
      this.selectedIndex = selectedIndex;
      value = multiplierList[selectedIndex];
      updateAmount = selectedItems.length * value;
    });
    deductAmount();
    print('Selected Amount: $updateAmount');
  }

  void deductAmount() {
    print('Deducted Amount: $updateAmount');
  }

  void showPersistentBottomSheet(BuildContext context) {
    if (_bottomSheetController != null) {
      _bottomSheetController!.close();
    }

    _bottomSheetController = Scaffold.of(context).showBottomSheet(
          (BuildContext context) {
        return AmountBottomSheet(itemSelect: selectedItems);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Items'),
      ),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              textWidget(text: "3 different number: odds (207.36)", fontSize: MediaQuery.of(context).size.width * 0.04),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                height: 50,
                child: ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, listIndex) {
                    if (allLists.isNotEmpty) {
                      final items = allLists[0].take(6).toList();

                      return Row(
                        children: items.map<Widget>((item) {
                          return InkWell(
                            onTap: () {
                              handleSelection(item);
                              showPersistentBottomSheet(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 40,
                                width: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xff784a9c),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: textWidget(
                                  text: item['no'].toString(),
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              textWidget(text: "3 continuous numbers: odds (34.56)", fontSize: MediaQuery.of(context).size.width * 0.04),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                height: 50,
                child: ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, listIndex) {
                    if (allLists.isNotEmpty) {
                      final items = allLists[2].take(1).toList();
                      return Row(
                        children: items.map<Widget>((item) {
                          return InkWell(
                            onTap: () {
                              handleSelection(item);
                              showPersistentBottomSheet(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xfffb9494),
                                ),
                                child: Center(
                                  child: textWidget(
                                    text: item['no'].toString(),
                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              textWidget(text: "2 different numbers: odds (34.56)", fontSize: MediaQuery.of(context).size.width * 0.04),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                height: 50,
                child: ListView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, listIndex) {
                    if (allLists.isNotEmpty) {
                      final items = allLists[1].take(6).toList();
                      return Row(
                        children: items.map<Widget>((item) {
                          return InkWell(
                            onTap: () {
                              handleSelection(item);
                              showPersistentBottomSheet(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Container(
                                height: 40,
                                width: 45,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xff784a9c),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: textWidget(
                                  text: item['no'].toString(),
                                  fontSize: MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textWidget({required String text, required double fontSize, Color color = Colors.black}) {
    return Text(
      text,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }
}

class AmountBottomSheet extends StatelessWidget {
  final List<Map<String, dynamic>> itemSelect;
  const AmountBottomSheet({super.key, required this.itemSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: itemSelect.length,
            itemBuilder: (context, index) {
              final item = itemSelect[index];
              return ListTile(
                title: Text(item['title']),
                subtitle: Text('Number: ${item['no']}'),
                trailing: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: item['color'],
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Handle the total amount calculation
                  Navigator.pop(context);
                },
                child: Text('Total amount: \$${itemSelect.length * 10}'), // Example calculation
              ),
            ],
          ),
        ],
      ),
    );
  }
}
