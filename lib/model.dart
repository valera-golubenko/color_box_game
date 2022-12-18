import 'package:flutter/material.dart';

enum StatusBox {
  initial,
  hidden,
  selecting,
  selected,
}

@immutable
class Box {
  final int index;
  final Color randomColor;
  final Color backSideColor;
  final StatusBox status;

  const Box({
    required this.index,
    required this.randomColor,
    this.backSideColor = Colors.black,
    this.status = StatusBox.initial,
  });

  Color get color {
    switch (status) {
      case StatusBox.initial:
        return randomColor;
      case StatusBox.hidden:
        return backSideColor;
      case StatusBox.selecting:
        return randomColor.withOpacity(0.5);
      case StatusBox.selected:
        return randomColor;
      default:
        return backSideColor;
    }
  }

  Box copyWidth({
    int? index,
    Color? randomColor,
    StatusBox? status,
  }) {
    return Box(
      index: index ?? this.index,
      randomColor: randomColor ?? this.randomColor,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(dynamic other) => other is Box && other.index == index;

  @override
  int get hashCode => index.hashCode;
}

final List<Color> colors = [
  Colors.green,
  Colors.purple,
  Colors.red,
  Colors.blue,
  Colors.grey,
  Colors.orange,
  Colors.pink,
  Colors.indigo,
  Color(0xFF4CAF50),
  Colors.purple,
  Colors.red,
  Colors.blue,
  Colors.grey,
  Colors.orange,
  Colors.pink,
  Colors.indigo,
];
