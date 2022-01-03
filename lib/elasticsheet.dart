import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class ElasticSheet extends StatefulWidget {
  final bool isDismissible;
  final Widget child;

  ///bottom sheet widget height
  final double sheetHeight;

  /// dragable area form the chid top postion to given value above
  /// like 100.0 value mean the sheetcan drag 100 pixel above from its postion

  /// Animation properties you can check out flutter docs form more information
  final SpringDescription springDescription;
  const ElasticSheet({
    Key? key,
    required this.isDismissible,
    required this.child,
    this.sheetHeight = 300.0,
    this.springDescription =
        const SpringDescription(mass: 10.0, stiffness: 2000, damping: 1.5),
  }) : super(key: key);

  @override
  _ElasticSheetState createState() => _ElasticSheetState();
}

class _ElasticSheetState extends State<ElasticSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late SpringDescription _springDescription;

  double _value = 0;

  @override
  void initState() {
    _animationController = AnimationController.unbounded(
      vsync: this,
    );

    _springDescription = widget.springDescription;
    _animationController.addListener(() {
      setState(() {
        _value = _animationController.value;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onDragUpdate,
      onVerticalDragEnd: _onDragEnd,
      child: SizedBox(
        height: widget.sheetHeight + _value,
        child: widget.child,
      ),
    );
  }

  void _onDragEnd(details) {
    final simulation = SpringSimulation(_springDescription, _value, 0, 0);
    _animationController.animateWith(simulation);
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_animationController.isAnimating) {
      _animationController.stop();
    }
    if (details.delta.dy > 0) {
      if (widget.isDismissible) {
        Navigator.of(context).pop();
      } else {
        setState(() {});
        _value--;
      }
    }
    if (details.delta.dy < 0) {
      setState(() {});
      _value++;
    }
  }
}
