import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({@required this.colour, this.cardChild, this.onPress});

  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      /// when there's a tap, the function onPress is called
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: colour.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
