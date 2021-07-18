import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  const Badge({
    Key key,
    @required this.child,
    @required this.value,
    this.color,
  }) : super(key: key);

  final Widget child;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          bottom: 4,
          left: 14,
          child: Container(
            padding: EdgeInsets.all(2.0),
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
  }
}
