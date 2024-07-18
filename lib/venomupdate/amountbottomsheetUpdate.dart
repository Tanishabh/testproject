import 'package:flutter/material.dart';
import 'package:testproject/main.dart';

class AmountBottomSheetUpdateD extends StatefulWidget {
  final List<Map<String, dynamic>> itemSelect;
  int tabindex;

  AmountBottomSheetUpdateD({Key? key, required this.itemSelect, required this.tabindex}) : super(key: key);

  @override
  _AmountBottomSheetUpdateDState createState() => _AmountBottomSheetUpdateDState();
}

class _AmountBottomSheetUpdateDState extends State<AmountBottomSheetUpdateD> {
  final TextEditingController amount = TextEditingController();

  List<int> balanceList = [5, 10, 100, 1000];
  List<int> multiplierList = [1, 5, 10, 20, 50, 100];
  Set<int> selectedItems = {};
  int updateAmount = 0;
  int balanceValue = 0;
  int multiplierValue = 1;
  int selectedIndex = 0;

  void selectBalance(int selectedIndex) {
    setState(() {
      balanceValue = balanceList[selectedIndex];
      updateAmount = widget.itemSelect.length * balanceValue * multiplierValue;
    });
    deductAmount();
    print('Selected Amount: $updateAmount');
  }

  void selectMultiplier(int selectedIndex) {
    setState(() {
      multiplierValue = multiplierList[selectedIndex];
      amount.text = multiplierValue.toString();
      updateAmount = widget.itemSelect.length * balanceValue * multiplierValue;
    });
    deductAmount();
    print('Selected Amount: $updateAmount');
  }

  void increment() {
    setState(() {
      multiplierValue++;
      amount.text = multiplierValue.toString();
      updateAmount = widget.itemSelect.length * balanceValue * multiplierValue;
      deductAmount();
    });
  }

  void decrement() {
    setState(() {
      if (multiplierValue > 1) {
        multiplierValue--;
        amount.text = multiplierValue.toString();
        updateAmount = widget.itemSelect.length * balanceValue * multiplierValue;
        deductAmount();
      }
    });
  }

  void deductAmount() {
    print('Deducted Amount: $updateAmount');
  }

  void _clearSelectedItems() {
    setState(() {
      selectedItems.clear();
    });
  }

  @override
  void initState() {
    amount.text = multiplierValue.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<Map<String, dynamic>>> groupedItems = {};
    for (var item in widget.itemSelect) {
      if (!groupedItems.containsKey(item['title'])) {
        groupedItems[item['title']] = [];
      }
      groupedItems[item['title']]!.add(item);
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.tabindex==0? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.builder(
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context , int index){
                    return  Padding(
                      padding:const EdgeInsets.only(left: 10, top: 3),
                      child: Text(
                          widget.itemSelect[index]['title'].toString()
                              .toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 17)),
                    );
                  }),
              Container(
                  height: selectedItems.length>=5? height * 0.13:height*0.05,
                  child: GridView.builder(
                    itemCount: widget.itemSelect.where((element) => element["no"].toString().length == 2).length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 3,
                      childAspectRatio: 1.9,
                    ),
                    itemBuilder: (context, index) {
                      final items =  widget.itemSelect.where((element) => element["no"].toString().length == 2).toList();
                      final singleNo = widget.itemSelect.where((element) => element["no"].toString().length == 1).map((e) => e["no"].toString()).toList();
                      // final backgroundColor = widget.colors == null ? Colors.white : widget.colors!.first;
                      final backgroundColor = Colors.red;



                      return  Row(
                        children: [
                          Container(
                            height: height * 0.033,
                            width: width*0.09,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: backgroundColor,
                            ),
                            child: Center(
                              child: Text(
                                items[index]["no"]
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                          singleNo.isNotEmpty
                              ? Container(
                            height: height * 0.033,
                            width: width*0.14,
                            decoration:
                            BoxDecoration(
                              borderRadius:
                              BorderRadius
                                  .circular(
                                  3),
                              color: const Color(
                                  0xff3d7456),
                            ),
                            child: Center(
                              child: Text(
                                singleNo
                                    .join(","),
                                style: const TextStyle(
                                    color: Colors
                                        .white,
                                    fontSize: 12),
                              ),
                            ),
                          )
                              : const SizedBox(),
                        ],
                      );
                    },
                  ))
            ],
          ):Container(),
          ...groupedItems.entries.map((entry) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.key, style: TextStyle(fontSize: 18)),
                Container(
                  height: 50, // Adjust height as needed
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                      mainAxisSpacing: 3,
                      childAspectRatio: 1.9,
                    ),
                    itemCount: entry.value.length,
                    itemBuilder: (context, index) {
                      var data = entry.value[index];
                      return Center(
                        child: Container(
                          width: 30, // Adjust width as needed
                          decoration: BoxDecoration(
                            color: Color(0xffc86eff),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              data["no"].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }).toList(),
          SizedBox(height: 16.0),
          _buildBalanceSection(),
          _buildQuantitySection(),
          SizedBox(height: 40),
          _buildMultiplierButtons(),
          SizedBox(height: 15),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildBalanceSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(25, 10, 0, 5),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Balance",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.red,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: balanceList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = balanceList[index];
                      });
                      selectBalance(index);
                    },
                    child: Container(
                      width: 60,
                      decoration: BoxDecoration(
                        color: selectedIndex == balanceList[index] ? Colors.blue : Colors.teal,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: const EdgeInsets.only(right: 5),
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          balanceList[index].toString(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: selectedIndex == balanceList[index] ? Colors.white : Colors.green,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySection() {
    return Container(
      padding: const EdgeInsets.all(5),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Quantity", style: TextStyle(fontSize: 18)),
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: decrement,
                  child: Container(
                    width: 35,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.blue),
                    child: const Text(
                      "—",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  height: 35,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(4),
                  width: 75,
                  decoration: BoxDecoration(color: Colors.red),
                  child: TextField(
                    controller: amount,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      int newValue = int.tryParse(value) ?? 1;
                      setState(() {
                        multiplierValue = newValue;
                        updateAmount = widget.itemSelect.length * balanceValue * multiplierValue;
                        deductAmount();
                      });
                    },
                    decoration: const InputDecoration(border: InputBorder.none),
                    style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w900),
                  ),
                ),
                InkWell(
                  onTap: increment,
                  child: Container(
                    width: 35,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.teal),
                    child: const Text(
                      "+",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMultiplierButtons() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: multiplierList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton(
              onPressed: () {
                selectMultiplier(index);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: multiplierValue == multiplierList[index] ? Colors.red : const Color(0xffe1e1e1),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
              child: Text(
                'X${multiplierList[index]}',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                _clearSelectedItems();
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                color: Colors.white,
                width: 150,
                height: 45,
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  // Betprovider.Colorbet(context, amount.text, widget.predictionType, widget.gameid);
                },
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.green,
                    height: 45,
                    child: Text(
                      "Total amount $updateAmount",
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}