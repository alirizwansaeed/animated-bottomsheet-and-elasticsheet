// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewSnapsheet extends StatefulWidget {
  final double initialSnap;
  final double midSnap;
  final double topsnap;
  ///this is fire header widget on the top
  final Widget headerTextWidget;
  ///this is first element of the body or we say first fading element of list
  final Widget listfirstElementWidget;
  ///this is actual list
  ///
  ///if user listview then shrink wrap must be provide 
  final Widget listWidget;
  const NewSnapsheet({
    Key? key,
    this.initialSnap = 0.0,
    this.midSnap = 0.3,
    this.topsnap = 0.7,
    required this.headerTextWidget,
    required this.listfirstElementWidget,
    required this.listWidget,
  }) : super(key: key);

  @override
  _NewSnapsheetState createState() => _NewSnapsheetState();
}

class _NewSnapsheetState extends State<NewSnapsheet> {
  double _bodyheight = 0.0;
  double _hederTextPosition = 15.0;
  double _opacity = 1.0;
  double _listOpacity = 1.0;
  bool showheader = true;

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    _controller.addListener(_listListner);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: Color(0xFF1C191C),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: _bodyheight,
            curve: Curves.easeInOut,
            child: SingleChildScrollView(
              controller: _controller,
              physics: ScrollPhysics(),
              child: Column(
                children: [
                  Opacity(
                      opacity: _listOpacity, child: widget.listfirstElementWidget),
                widget.listWidget,
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: _opacity,
            child: Container(
              height: 50,
              width: double.infinity,
              color: const Color(0xFF333133),
              padding: const EdgeInsets.only(top: 10),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: 40,
                    height: 4.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    top: _hederTextPosition,
                    child: widget.headerTextWidget,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onVerticalDragEnd: (details) => _onverticalDragEnd(details, height),
            child: Container(
              height: 50,
              color: Colors.black.withOpacity(.01),
              padding: const EdgeInsets.only(top: 10),
              alignment: Alignment.topCenter,
              child: Container(
                width: 40,
                height: 4.0,
                decoration: BoxDecoration(
                  color: Colors.grey.shade600,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _listListner() {
    if (_controller.offset >= 0 && _controller.offset <= 30) {
      setState(() {
        _listOpacity = ((_controller.offset - 30) * 1) / (0 - 30);
      });
    }

    if (_controller.offset >= 30) {
      setState(() {
        _opacity = 1.0;
        _hederTextPosition = 15.0;
      });
    } else {
      setState(() {
        _opacity = 0.0;
        _hederTextPosition = 0.0;
      });
    }
  }

  void _onverticalDragEnd(DragEndDetails detial, double height) {
    if (detial.velocity.pixelsPerSecond.dy < 0) {
      if (_bodyheight == height * widget.initialSnap) {
        _bodyheight = height * widget.midSnap;
        _opacity = 0.0;
        _hederTextPosition = 0;
      } else if (_bodyheight == height * widget.midSnap) {
        _bodyheight = height * widget.topsnap;
        _opacity = 0.0;
        _hederTextPosition = 0;
      }
    }
    if (detial.velocity.pixelsPerSecond.dy > 0) {
      if (_bodyheight == height * widget.topsnap) {
        _bodyheight = height * widget.midSnap;
        _opacity = 0.0;
        _hederTextPosition = 0;
      } else if (_bodyheight == height * widget.midSnap) {
        _bodyheight = height * widget.initialSnap;
        _opacity = 1.0;
        _hederTextPosition = 15.0;
      }
    }
    setState(() {});
  }
}
