import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class MyGeoTagging extends StatefulWidget {
  const MyGeoTagging({super.key});

  @override
  _MyGeoTaggingState createState() => _MyGeoTaggingState();
}

class _MyGeoTaggingState extends State<MyGeoTagging> {
  File? _image;
  final picker = ImagePicker();
  Position? _currentPosition;
  String _currentAddress = '';
  String _formattedDate = '';
  final GlobalKey _globalKey = GlobalKey();
  bool _isLoading = false;
  String _buttonText = 'Save';

  Future<void> getImage() async {
    var image;
    try {
      image = await picker.pickImage(source: ImageSource.camera);
    } catch (platformException) {
      print("Not allowing: $platformException");
    }

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
      await _getCurrentLocation();
      await _getAddressFromLatLng();
      await _getFormattedDate();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => GeoTagImg(
            image: _image!,
            position: _currentPosition!,
            address: _currentAddress,
            date: _formattedDate,
            globalKey: _globalKey,
            saveImage: saveImage,
          ),
        ),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placemarks[0];
      String fullAddress = "${place.name}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      setState(() {
        _currentAddress = fullAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _getFormattedDate() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm');
    final String formatted = formatter.format(now);
    setState(() {
      _formattedDate = formatted;
    });
  }

  Future<void> saveImage() async {
    setState(() {
      _isLoading = true;
      _buttonText = 'Saving...';
    });

    await _askPermission();

    RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(pixelRatio: 3.0); // You can adjust the pixelRatio as needed

    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();

    final directory = await getExternalStorageDirectory();
    File imgFile = File('${directory!.path}/screenshot${DateTime.now().millisecondsSinceEpoch}.png');
    await imgFile.writeAsBytes(pngBytes);

    // Save image to gallery using image_gallery_saver
    final result = await ImageGallerySaver.saveFile(imgFile.path);
    print(result);

    setState(() {
      _isLoading = false;
      _buttonText = 'Saved';
    });

    print("Image saved at: ${imgFile.path}");
  }

  Future<void> _askPermission() async {
    if (await Permission.storage.request().isGranted) {
      print("Permission Granted");
    } else {
      print("Permission Denied");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoTag Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null ? const Text('No image selected.') : Image.file(_image!),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: getImage,
              child: const Text('Capture Image'),
            ),
          ],
        ),
      ),
      floatingActionButton: _isLoading
          ? const CircularProgressIndicator()
          : FloatingActionButton(
        onPressed: () => saveImage(),
        tooltip: 'Save Image',
        child: const Icon(Icons.save),
      ),
    );
  }
}

class GeoTagImg extends StatelessWidget {
  final File image;
  final Position position;
  final String address;
  final String date;
  final GlobalKey globalKey;
  final Function saveImage;

  GeoTagImg({super.key,
    required this.image,
    required this.position,
    required this.address,
    required this.date,
    required this.globalKey,
    required this.saveImage,
  });

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeoTag Image'),
      ),
      body: Center(
        child: RepaintBoundary(
          key: globalKey,
          child: Stack(
            children: <Widget>[
              SizedBox(
                height: 600,
                child: Image.file(image),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Address: $address',
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                    Text(
                      'Date: $date',
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                    Text(
                      'Latitude: ${position.latitude}',
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                    Text(
                      'Longitude: ${position.longitude}',
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _isLoading
          ? const CircularProgressIndicator()
          : FloatingActionButton(
        onPressed: () => saveImage(),
        tooltip: 'Save Image',
        child: const Icon(Icons.save),
      ),
    );
  }
}
