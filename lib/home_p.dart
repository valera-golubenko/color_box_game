import 'package:color_box_game/model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Color> colors = [
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.blue,
    Colors.grey,
    Colors.orange,
    Colors.pink,
    Colors.indigo,
    Colors.green,
    Colors.purple,
    Colors.red,
    Colors.blue,
    Colors.grey,
    Colors.orange,
    Colors.pink,
    Colors.indigo,
  ];
  List<Box> boxes = <Box>[];
  List<Box> selectedBoxes = <Box>[];
  List<Box> selectingBoxes = <Box>[];

  void setIndexColorList() {
    boxes = List.generate(colors.length, (index) {
      final color = colors[index];
      return Box(index: index, randomColor: color);
    });
  }

  void setBlackColor() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      boxes = boxes
          .map((box) => box.copyWidth(
                status: StatusBox.hidden,
              ))
          .toList();
    });
  }

  // boxTap(Box box) {
  //   if (!isTap) {
  //     firstColor = box.activeColor;
  //     isTap = true;
  //     final newBoxActiveColor = box.copyWidth(currentColor: box.activeColor);
  //     boxes[box.index] = newBoxActiveColor;
  //   } else {
  //     secondColor = box.activeColor;
  //     isTap = false;
  //     final newBoxInActiveColor =
  //         box.copyWidth(currentColor: box.inActiveColor);
  //     boxes[box.index] = newBoxInActiveColor;
  //     if (firstColor == secondColor) {
  //       print('равны');
  //     } else {
  //       firstColor == null;
  //       secondColor == null;
  //     }
  //   }
  // }

  void boxTap(Box box) async {
    if (box.status == StatusBox.selected) return;

    if (selectingBoxes.length >= 2) {
      _resetAnSelectedColors();
    }
    _selectBox(box);

    setState(() {});

    await Future.delayed(const Duration(seconds: 1));

    if (selectingBoxes.length < 2) return;
    _checkSelections();
    _resetAnSelectedColors();
    setState(() {});
  }

  void _resetAnSelectedColors() {
    boxes = boxes.map((box) {
      final isSelected = selectedBoxes.contains(box);
      if (isSelected) return box.copyWidth(status: StatusBox.selected);

      return box.copyWidth(status: StatusBox.hidden);
    }).toList();

    selectingBoxes.clear();
  }

  void _selectBox(Box tappedBox) {
    boxes = boxes.map((box) {
      final isTapped = tappedBox == box;
      if (!isTapped) return box;

      return box.copyWidth(status: StatusBox.selecting);
    }).toList();

    selectingBoxes.add(tappedBox);
  }

  void _checkSelections() {
    final selectingColors =
        selectingBoxes.map((box) => box.randomColor).toSet();
    final isApprove = selectingColors.length == 1;

    if (isApprove) {
      selectedBoxes.addAll(selectingBoxes);
    } else {
      selectingBoxes.clear();
    }
  }

  @override
  void initState() {
    colors.shuffle();
    setIndexColorList();

    setBlackColor();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color game'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            Wrap(
              runSpacing: 15,
              alignment: WrapAlignment.spaceBetween,
              children: boxes.map(_buildBoxCard).toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBoxCard(Box box) {
    return InkWell(
      onTap: () {
        boxTap(box);
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: box.color,
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}


// setState(() {
          // final colorTap = box.activeColor;

          // if (!clickBox) {
          //   firstColor = colorTap;
          //   clickBox = true;
          //   final newBox = box.copyWidth(activeColor: Colors.black);
          //   boxes[box.index] = newBox;
          // } else {
          //   secondColor = colorTap;
          //   clickBox = false;
          //   final newBox = box.copyWidth(activeColor: colorTap);
          //   boxes[box.index] = newBox;
          // }
        // });