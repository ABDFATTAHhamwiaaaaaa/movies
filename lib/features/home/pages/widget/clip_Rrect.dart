
import 'package:flutter/material.dart';

class ClipRRect extends StatelessWidget {
  final Widget child;
  final BorderRadiusGeometry borderRadius;

  ClipRRect({super.key, required this.child, required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: child,
    );
  }
}
