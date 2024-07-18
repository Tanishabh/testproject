// import 'package:flutter/material.dart';
// import 'package:testproject/main.dart';
//
// class AmountBottomSheet extends StatefulWidget {
//   final List<Map<String, dynamic>> itemSelect;
//   AmountBottomSheet({super.key, required this.itemSelect});
//
//   @override
//   _AmountBottomSheetState createState() => _AmountBottomSheetState();
// }
//
// class _AmountBottomSheetState extends State<AmountBottomSheet> {
//   final TextEditingController amount = TextEditingController();
//
//   List<int> balanceList = [5, 10, 100, 1000];
//   List<int> multiplierList = [1, 5, 10, 20, 50, 100];
//   Set<int> selectedItems = {};
//   int updateAmount = 0;
//   int balanceValue = 0;
//   int multiplierValue = 1;
//   int selectedIndex = 0;
//
//   void selectBalance(int selectedIndex) {
//     setState(() {
//       balanceValue = balanceList[selectedIndex];
//       updateAmount = widget.itemSelect.length * balanceValue * multiplierValue;
//     });
//     deductAmount();
//     print('Selected Amount: $updateAmount');
//   }
//
//   void selectMultiplier(int selectedIndex) {
//     setState(() {
//       multiplierValue = multiplierList[selectedIndex];
//       amount.text = multiplierValue.toString();
//       updateAmount = widget.itemSelect.length * balanceValue * multiplierValue;
//     });
//     deductAmount();
//     print('Selected Amount: $updateAmount');
//   }
//
//   void increment() {
//     setState(() {
//       multiplierValue++;
//       amount.text = multiplierValue.toString();
//       updateAmount = widget.itemSelect.length * balanceValue * multiplierValue;
//       deductAmount();
//     });
//   }
//
//   void decrement() {
//     setState(() {
//       if (multiplierValue > 1) {
//         multiplierValue--;
//         amount.text = multiplierValue.toString();
//         updateAmount = widget.itemSelect.length * balanceValue * multiplierValue;
//         deductAmount();
//       }
//     });
//   }
//
//   void deductAmount() {
//     print('Deducted Amount: $updateAmount');
//   }
//
//   @override
//   void initState() {
//     amount.text = multiplierValue.toString();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             // child: Text('Number of Selections: ${selectedItems.length}'),
//             child: Text('Number of Selections: ${widget.itemSelect.length}'),
//           ),
//           widget.itemSelect.isNotEmpty?
//           Container(
//             height: widget.itemSelect.isNotEmpty?height * 0.20:0,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: GridView.builder(
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 6,
//                   mainAxisSpacing: 3,
//                   childAspectRatio: 1.9,
//                 ),
//                 itemCount:  widget.itemSelect.length,
//                 itemBuilder: (context, index) {
//                   var data = widget.itemSelect[index];
//                   return Center(
//                     child: Container(
//                       width: width * 0.10,
//                       decoration:
//                       BoxDecoration(
//                         color:
//                         data['color'],
//                         borderRadius:
//                         BorderRadius
//                             .circular(
//                             10),
//                       ),
//                       child: Center(
//                         child: Text(
//                           data["no"]
//                               .toString(),
//                           style: const TextStyle(
//                               color: Colors
//                                   .white,
//                               fontSize:
//                               17),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ) :Container(),
//
//           Container(
//             padding: const EdgeInsets.fromLTRB(25, 10, 0, 5),
//             width: width,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Text(
//                   "Balance",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.red,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Container(
//                     height: 30,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       shrinkWrap: true,
//                       itemCount: balanceList.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return InkWell(
//                           onTap: () {
//                             setState(() {
//                               selectedIndex = balanceList[index];
//                             });
//                             selectBalance(index);
//                           },
//                           child: Container(
//                             width: width * 0.15,
//                             decoration: BoxDecoration(
//                               color: selectedIndex == balanceList[index]
//                                   ? Colors.blue
//                                   : Colors.teal,
//                               borderRadius: BorderRadius.circular(5),
//                             ),
//                             margin: const EdgeInsets.only(right: 5),
//                             padding: const EdgeInsets.all(5),
//                             child: Center(
//                               child: Text(
//                                 balanceList[index].toString(),
//                                 style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w900,
//                                   color: selectedIndex == balanceList[index]
//                                       ? Colors.white
//                                       : Colors.green,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             padding: const EdgeInsets.all(5),
//             width: width,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   "Quantity",
//                   style: TextStyle(fontSize: 18),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 18),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       InkWell(
//                         onTap: decrement,
//                         child: Container(
//                           width: 35,
//                           alignment: Alignment.center,
//                           margin: const EdgeInsets.only(right: 5),
//                           padding: const EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                             color: Colors.blue,
//                           ),
//                           child: const Text("—",
//                               style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.w900,
//                                   color: Colors.white)),
//                         ),
//                       ),
//                       Container(
//                         height: 35,
//                         alignment: Alignment.center,
//                         padding: const EdgeInsets.all(4),
//                         width: 75,
//                         decoration: BoxDecoration(
//                           color: Colors.red,
//                         ),
//                         child: TextField(
//                           controller: amount,
//                           keyboardType: TextInputType.number,
//                           textAlign: TextAlign.center,
//                           onChanged: (value) {
//                             int newValue = int.tryParse(value) ?? 1;
//                             setState(() {
//                               multiplierValue = newValue;
//                               updateAmount = selectedItems.length * balanceValue * multiplierValue;
//                               deductAmount();
//                             });
//                           },
//                           decoration: const InputDecoration(
//                               border: InputBorder.none),
//                           style: const TextStyle(
//                               fontSize: 18,
//                               color: Colors.white,
//                               fontWeight: FontWeight.w900),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: increment,
//                         child: Container(
//                           width: 35,
//                           alignment: Alignment.center,
//                           margin: const EdgeInsets.only(left: 5),
//                           padding: const EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                             color: Colors.teal,
//                           ),
//                           child: const Text("+",
//                               style: TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.w900,
//                                   color: Colors.white)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 40,
//             child: ListView.builder(
//               shrinkWrap: true,
//               scrollDirection: Axis.horizontal,
//               itemCount: multiplierList.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       selectMultiplier(index);
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: multiplierValue == multiplierList[index]
//                           ? Colors.red
//                           : const Color(0xffe1e1e1),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                     ),
//                     child: Text(
//                       'X${multiplierList[index]}',
//                       style: const TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 30),
//             child: Row(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       print('Cancelled');
//                     });
//                     Navigator.of(context).pop();
//                   },
//                   child: Container(
//                     alignment: Alignment.center,
//                     color: Colors.white,
//                     width: width / 3,
//                     height: 45,
//                     child: const Text(
//                       "Cancel",
//                       style: TextStyle(color: Colors.grey, fontSize: 20),
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     // Betprovider.Colorbet(context, amount.text, widget.predictionType, widget.gameid);
//                   },
//                   child: Center(
//                     child: Container(
//                       alignment: Alignment.center,
//                       color: Colors.green,
//                       width: width * 0.55,
//                       height: 45,
//                       child: Text(
//                         "Total amount $updateAmount",
//                         style: const TextStyle(
//                             fontSize: 20, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
