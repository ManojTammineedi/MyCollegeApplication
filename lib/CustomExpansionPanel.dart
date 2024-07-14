import 'package:flutter/material.dart';

class CustomExpansionPanel extends StatefulWidget {
  const CustomExpansionPanel({
    Key? key,
    required this.headerBuilder,
    required this.body,
    required this.isExpanded,
  }) : super(key: key);

  final Widget Function(BuildContext, bool) headerBuilder;
  final Widget body;
  final bool isExpanded;

  @override
  _CustomExpansionPanelState createState() => _CustomExpansionPanelState();
}

class _CustomExpansionPanelState extends State<CustomExpansionPanel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _heightFactor = _controller.drive(CurveTween(curve: Curves.fastOutSlowIn));

    // Ensure that the controller is properly initialized based on the initial isExpanded state
    _controller.value = widget.isExpanded ? 1.0 : 0.0;
  }

  @override
  void didUpdateWidget(covariant CustomExpansionPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded != oldWidget.isExpanded) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.headerBuilder(context, widget.isExpanded),
        ClipRect(
          child: Align(
            alignment: Alignment.topCenter,
            heightFactor: _heightFactor.value,
            child: widget.body,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Ensure that the controller is properly disposed
    super.dispose();
  }
}
