import 'package:bloc/bloc.dart';
import 'package:color_box_game/model.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState());

  Future<void> init() async {
    setIndexColorList();
    setBlackColor();
  }

  void setIndexColorList() {
    final boxes = List.generate(colors.length, (index) {
      final color = colors[index];
      return Box(index: index, randomColor: color);
    });

    final newState = state.copyWidth(boxes: boxes);
    emit(newState);
  }

  void setBlackColor() async {
    await Future.delayed(const Duration(seconds: 4));

    final boxes = state.boxes
        .map((box) => box.copyWidth(
              status: StatusBox.hidden,
            ))
        .toList();
    final newState = state.copyWidth(boxes: boxes);
    emit(newState);
  }

  void boxTap(Box box) async {
    if (box.status == StatusBox.selected) return;

    if (state.selectingBoxes.length >= 2) {
      _resetAnSelectedColors();
    }
    _selectBox(box);

    await Future.delayed(const Duration(seconds: 1));

    if (state.selectingBoxes.length < 2) return;
    _checkSelections();
    _resetAnSelectedColors();
    //emit(state);
    //setState(() {});
  }

  void _resetAnSelectedColors() {
    final boxes = state.boxes.map((box) {
      final isSelected = state.selectedBoxes.contains(box);
      if (isSelected) return box.copyWidth(status: StatusBox.selected);

      return box.copyWidth(status: StatusBox.hidden);
    }).toList();

    state.selectingBoxes.clear();
    final newState = state.copyWidth(boxes: []);
    emit(newState);
  }

  void _selectBox(Box tappedBox) {
    final boxes = state.boxes.map((box) {
      final isTapped = tappedBox == box;
      if (!isTapped) return box;

      return box.copyWidth(status: StatusBox.selecting);
    }).toList();
    final newState = state.copyWidth(boxes: boxes);
    emit(newState);
    state.selectingBoxes.add(tappedBox);
  }

  void _checkSelections() {
    final selectingColors =
        state.selectingBoxes.map((box) => box.randomColor).toSet();
    final isApprove = selectingColors.length == 1;

    if (isApprove) {
      state.selectedBoxes.addAll(state.selectingBoxes);
    } else {
      state.selectingBoxes.clear();
    }
  }
}
