import 'package:flutter/material.dart';


class CheckboxListScreen extends StatefulWidget {
  @override
  _CheckboxListScreenState createState() => _CheckboxListScreenState();
}

class _CheckboxListScreenState extends State<CheckboxListScreen> {
  // List to hold the state of each checkbox
  late List<bool> _isChecked;
  late ScrollController _scrollController;
  late double _previousScrollOffset;

  @override
  void initState() {
    super.initState();
    // Initialize the list with false values (unchecked)
    _isChecked = List<bool>.filled(100, false);
    // Initialize the ScrollController
    _scrollController = ScrollController();
    _previousScrollOffset = 0.0;

    // Add listener to detect scroll direction
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    // Dispose the ScrollController to free resources
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    // Detect if the user is scrolling up
    if (_scrollController.offset < _previousScrollOffset) {
      setState(() {
        for (int i = 0; i < _isChecked.length; i++) {
          if (!_isChecked[i]) {
            _isChecked[i] = true;
          }
        }
      });
    }
    _previousScrollOffset = _scrollController.offset;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dynamic Checkbox List'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _isChecked.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text('Item $index'),
            value: _isChecked[index],
            onChanged: (bool ?value) {
              setState(() {
                _isChecked[index] = value!;
              });
            },
          );
        },
      ),
    );
  }
}
