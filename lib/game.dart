import 'package:flutter/material.dart';

class DragAndDropGamePage extends StatefulWidget {
  @override
  _DragAndDropGamePageState createState() => _DragAndDropGamePageState();
}

class _DragAndDropGamePageState extends State<DragAndDropGamePage> {
  String element1 = "1";
  String element2 = "2";
  String matchedElement1 = "";
  String matchedElement2 = "";
  Offset _offset1 = const Offset(0, 0);
  Offset _offset2 = const Offset(120, 0);

  final double _elementSize = 100.0;
  bool _isElement1Draggable = true;
  bool _isElement1Draggable2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drag and Drop Game"),
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DragTarget<String>(
                    builder: (context, List<String?> candidateData, rejectedData) {
                      return _buildDragTargetElement("one", matchedElement1.isNotEmpty, "1");
                    },
                    onWillAccept: (data) => data == element1 && matchedElement1.isEmpty &&
                      element2 != matchedElement1,
                    onAccept: (data) {
                      setState(() {
                        matchedElement1 = data;
                        _isElement1Draggable = false;
                      });
                    },
                  ),
                  DragTarget<String>(
                    builder:(context, List<String?> candidateData, rejectedData) {
                      return _buildDragTargetElement(
                        "two", matchedElement2.isNotEmpty, "2");
                    },
                    onWillAccept: (data1) => data1 == element2 && matchedElement2.isEmpty &&
                      element1 != matchedElement2,
                    onAccept: (data1) {
                      setState(() {
                        matchedElement2 = data1;
                        _isElement1Draggable2 = false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          Visibility(
            visible: _isElement1Draggable,
            child: Positioned(
              left: _offset1.dx,
              top: _offset1.dy,
              child: Draggable(
                data: element1,
                feedback: Container(
                  width: _elementSize,
                  height: _elementSize,
                  color: Colors.blue.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      element1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                onDraggableCanceled: (velocity, offset) {
                  setState(() {
                    if (_isElement1Draggable) {
                      _offset1 = offset;
                    }
                    if (_isElement1Draggable == false) {
                      _offset1 = offset;
                    }
                  });
                },
                child: _buildDraggableElement(element1),
              ),
            ),
          ),
          Visibility(
            visible: _isElement1Draggable2,
            child: Positioned(
              left: _offset2.dx,
              top: _offset2.dy,
              child: Draggable(
                data: element2,
                feedback: Container(
                  width: _elementSize,
                  height: _elementSize,
                  color: Colors.blue.withOpacity(0.5),
                  child: Center(
                    child: Text(
                      element1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                onDraggableCanceled: (velocity, offset) {
                  setState(() {
                    if (_isElement1Draggable2) {
                      _offset2 = offset;
                    }
                  });
                },
                child: _buildDraggableElement(element2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableElement(String element) {
    return Container(
      width: _elementSize,
      height: _elementSize,
      color: Colors.blue,
      child: Center(
        child: Text(
          element,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }

  Widget _buildDragTargetElement(
      String element, bool isMatched, String number) {
    return Material(
      child: Container(
        width: _elementSize + 50,
        height: _elementSize + 50,
        color: isMatched ? Colors.green : Colors.grey,
        child: Center(
          child: Text(
            isMatched ? number : element,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
