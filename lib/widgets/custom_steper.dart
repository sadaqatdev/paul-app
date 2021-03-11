import 'package:flutter/material.dart';

class CustomSteper extends StatefulWidget {
  int lowerLimit;
  int upperLimit;
  int stepValur;
  double iconSize;
  int valuel;
  final ValueChanged<dynamic> onChanged;
  CustomSteper({
    Key key,
    this.lowerLimit,
    this.upperLimit,
    this.stepValur,
    this.iconSize,
    this.valuel,
    this.onChanged,
  }) : super(key: key);
  @override
  _CustomSteperState createState() => _CustomSteperState();
}

class _CustomSteperState extends State<CustomSteper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  widget.valuel = widget.valuel == widget.lowerLimit
                      ? widget.lowerLimit
                      : widget.valuel -= widget.stepValur;
                  this.widget.onChanged(widget.valuel);
                });
              }),
          Text(widget.valuel.toString()),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  widget.valuel = widget.valuel == widget.upperLimit
                      ? widget.upperLimit
                      : widget.valuel += widget.stepValur;
                  this.widget.onChanged(widget.valuel);
                });
              })
        ],
      ),
    );
  }
}
