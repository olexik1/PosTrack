import 'package:flutter/material.dart';


class StatusCircle extends StatelessWidget {
  final Color innerColor;
  final Color outerColor;
  final bool big;

  const StatusCircle({
    super.key,
    required this.innerColor,
    required this.outerColor,
    this.big = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: big ? 20 : 16,
      height: big ? 20 : 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: innerColor,
        border: Border.all(
          color: outerColor,
          width: 4,
        ),
      ),
    );
  }
}
