import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:color_box_game/model.dart';
import 'package:meta/meta.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameState());

  Future<void> init(List<Color> colors) async {
    final colorsSet = {...colors};
    final shuffledColors = [...colorsSet, ...colorsSet];
    shuffledColors.shuffle();
    emit(state.copyWidth(colors: shuffledColors));
    setIndexColorList();
    setBlackColor();
  }

  void setIndexColorList() {
    final boxes = List.generate(state.colors.length, (index) {
      final color = state.colors[index];
      return Box(index: index, randomColor: color);
    });

    emit(state.copyWidth(boxes: boxes));
  }

  void setBlackColor() async {
    await Future.delayed(const Duration(seconds: 4));

    final boxes = state.boxes
        .map((box) => box.copyWidth(
              status: StatusBox.hidden,
            ))
        .toList();
    emit(state.copyWidth(boxes: boxes));
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
  }

  void _resetAnSelectedColors() {
    final boxes = state.boxes.map((box) {
      final isSelected = state.selectedBoxes.contains(box);
      if (isSelected) {
        return box.copyWidth(status: StatusBox.selected);
      }

      return box.copyWidth(status: StatusBox.hidden);
    }).toList();
    emit(state.copyWidth(
      boxes: boxes,
      selectingBoxes: [],
    ));
  }

  void _selectBox(Box tappedBox) {
    final boxes = state.boxes.map((box) {
      final isTapped = tappedBox == box;
      if (!isTapped) return box;

      return box.copyWidth(status: StatusBox.selecting);
    }).toList();

    emit(state.copyWidth(
      boxes: boxes,
      selectingBoxes: [...state.selectingBoxes, tappedBox],
    ));
  }

  void _checkSelections() {
    final selectingColors =
        state.selectingBoxes.map((box) => box.randomColor).toSet();
    final isApprove = selectingColors.length == 1;

    if (isApprove) {
      emit(state.copyWidth(
        selectedBoxes: [
          ...state.selectedBoxes,
          ...state.selectingBoxes,
        ],
      ));
    } else {
      emit(state.copyWidth(selectingBoxes: []));
    }
  }
}
