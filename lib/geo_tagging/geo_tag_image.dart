// import 'dart:html';
//
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// class GeoTagImg extends StatelessWidget {
//   final File image;
//   final Position position;
//   final String address;
//   final String date;
//   final GlobalKey globalKey;
//   final Function saveImage;
//
//   GeoTagImg({super.key,
//     required this.image,
//     required this.position,
//     required this.address,
//     required this.date,
//     required this.globalKey,
//     required this.saveImage,
//   });
//
//
//   bool _isLoading = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('GeoTag Image'),
//       ),
//       body: Center(
//         child: RepaintBoundary(
//           key: globalKey,
//           child: Stack(
//             children: <Widget>[
//               SizedBox(
//                   height: 450,
//                   child: Image.file(image)),
//               Positioned(
//                 bottom: 10,
//                 left: 10,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       'Address: $address',
//                       style: const TextStyle(color: Colors.white, fontSize: 8),
//                     ),
//                     Text(
//                       'Date: $date',
//                       style: const TextStyle(color: Colors.white, fontSize: 8),
//                     ),
//                     Text(
//                       'Latitude: ${position.latitude}',
//                       style: const TextStyle(color: Colors.white, fontSize: 8),
//                     ),
//                     Text(
//                       'Longitude: ${position.longitude}',
//                       style: const TextStyle(color: Colors.white, fontSize: 8),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: _isLoading
//           ? const CircularProgressIndicator()
//           : FloatingActionButton(
//         onPressed: () => saveImage(),
//         tooltip: 'Save Image',
//         child: const Icon(Icons.save),
//       ),
//     );
//   }
// }
