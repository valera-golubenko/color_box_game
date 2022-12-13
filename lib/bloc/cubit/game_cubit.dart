import 'package:bloc/bloc.dart';
import 'package:color_box_game/model.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameInitial());

  Future<void> init() async {
    emit(GameLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(GameLoaded());
    setIndexColorList();
    setBlackColor();
  }

  void setIndexColorList() {
    boxes = List.generate(colors.length, (index) {
      final color = colors[index];
      return Box(index: index, randomColor: color);
    });
  }

  void setBlackColor() async {
    await Future.delayed(const Duration(seconds: 4));
    boxes = boxes
        .map((box) => box.copyWidth(
              status: StatusBox.hidden,
            ))
        .toList();
  }

  void boxTap(Box box) async {
    if (box.status == StatusBox.selected) return;

    if (selectingBoxes.length >= 2) {
      _resetAnSelectedColors();
    }
    _selectBox(box);

    // setState(() {});

    await Future.delayed(const Duration(seconds: 1));

    if (selectingBoxes.length < 2) return;
    _checkSelections();
    _resetAnSelectedColors();
    // setState(() {});
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
}
