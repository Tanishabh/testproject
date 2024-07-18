// import 'package:flutter/material.dart';
// import 'package:testproject/main.dart';
// import 'package:testproject/venomk3/bottomsheet.dart';
//
// import 'package:testproject/venomk3/text_widget.dart';
//
// class MyHomePage extends StatefulWidget {
//   final int tabindex;
//   MyHomePage({super.key, required this.tabindex});
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   PersistentBottomSheetController? _bottomSheetController;
//
//   final TextEditingController amount = TextEditingController();
//
//
//
//   List<Map<String, dynamic>> bigList = [
//     {"id": "1", "no": 1, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
//     {"id": "2", "no": 2, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
//     {"id": "3", "no": 3, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
//     {"id": "4", "no": 4, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
//     {"id": "5", "no": 5, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
//     {"id": "6", "no": 6, "color": const Color(0xff784a9c), "title": "3 different number: odds (207.36)"},
//   ];
//
//   List<Map<String, dynamic>> smallList = [
//     {"id": "1", "no": 1, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
//     {"id": "2", "no": 2, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
//     {"id": "3", "no": 3, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
//     {"id": "4", "no": 4, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
//     {"id": "5", "no": 5, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
//     {"id": "6", "no": 6, "color": const Color(0xff784a9c), "title": "2 different number: odds (34.36)"},
//   ];
//
//   List<Map<String, dynamic>> evenList = [
//     {"id": "1", "no": "3 continuous numbers", "color": const Color(0xfffb9494), "title": "3 continuous number: odds (34.36)"},
//   ];
//
//   late List<List<Map<String, dynamic>>> allLists;
//   List<Map<String, dynamic>> selectedItems = [];
//   int updateAmount = 0;
//
//   int value = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     allLists = [bigList, smallList, evenList];
//   }
//
//   void handleSelection(Map<String, dynamic> selectedItem) {
//     setState(() {
//       if (selectedItems.contains(selectedItem)) {
//         selectedItems.remove(selectedItem);
//       } else {
//         selectedItems.add(selectedItem);
//       }
//       updateAmount = selectedItems.length * value;
//     });
//   }
//
//   void showPersistentBottomSheet(BuildContext context) {
//     if (_bottomSheetController != null) {
//       _bottomSheetController!.close();
//     }
//     _bottomSheetController = Scaffold.of(context).showBottomSheet(
//           (BuildContext context) {
//         return AmountBottomSheet(itemSelect:selectedItems);
//       },
//     );
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Select Items'),
//       ),
//       body: Builder(
//         builder: (context) => Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: height * 0.03,
//               ),
//               textWidget(text: "3 different number: odds (207.36)", fontSize: MediaQuery.of(context).size.width * 0.04),
//               SizedBox(
//                 height: height * 0.03,
//               ),
//               Container(
//                 height: 50,
//                 child: ListView.builder(
//                   itemCount: 1,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, listIndex) {
//                     if (allLists.isNotEmpty) {
//                       final items = allLists[0].take(6).toList();
//
//                       return Row(
//                         children: items.map<Widget>((item) {
//                           return InkWell(
//                             onTap: () {
//                               handleSelection(item);
//                               showPersistentBottomSheet(context);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: Container(
//                                 height: 40,
//                                 width: 45,
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xff784a9c),
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 child: textWidget(
//                                   text: item['no'].toString(),
//                                   fontSize: MediaQuery.of(context).size.width * 0.04,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       );
//                     } else {
//                       return Container();
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: height * 0.03,
//               ),
//               textWidget(text: "3 continuous numbers: odds (34.56)", fontSize: MediaQuery.of(context).size.width * 0.04),
//               SizedBox(
//                 height: height * 0.03,
//               ),
//               Container(
//                 height: 50,
//                 child: ListView.builder(
//                   itemCount: 1,
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemBuilder: (context, listIndex) {
//                     if (allLists.isNotEmpty) {
//                       final items = allLists[2].take(1).toList();
//                       return Row(
//                         children: items.map<Widget>((item) {
//                           return InkWell(
//                             onTap: () {
//                               handleSelection(item);
//                               showPersistentBottomSheet(context);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: Container(
//                                 height: height * 0.05,
//                                 width: MediaQuery.of(context).size.width * 0.80,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(10),
//                                   color: const Color(0xfffb9494),
//                                 ),
//                                 child: Center(
//                                   child: textWidget(
//                                     text: item['no'].toString(),
//                                     fontSize: MediaQuery.of(context).size.width * 0.04,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       );
//                     } else {
//                       return Container();
//                     }
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: height * 0.03,
//               ),
//               textWidget(text: "2 different numbers: odds (34.56)", fontSize: MediaQuery.of(context).size.width * 0.04),
//               SizedBox(
//                 height: height * 0.03,
//               ),
//               Container(
//                 height: 50,
//                 child: ListView.builder(
//                   itemCount: 1,
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   itemBuilder: (context, listIndex) {
//                     if (allLists.isNotEmpty) {
//                       final items = allLists[1].take(6).toList();
//                       return Row(
//                         children: items.map<Widget>((item) {
//                           return InkWell(
//                             onTap: () {
//                               handleSelection(item);
//                               showPersistentBottomSheet(context);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: Container(
//                                 height: 40,
//                                 width: 45,
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xff784a9c),
//                                   borderRadius: BorderRadius.circular(6),
//                                 ),
//                                 child: textWidget(
//                                   text: item['no'].toString(),
//                                   fontSize: MediaQuery.of(context).size.width * 0.04,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                       );
//                     } else {
//                       return Container();
//                     }
//                   },
//                 ),
//               ),
//
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }