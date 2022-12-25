part of 'game_cubit.dart';

@immutable
class GameState {
  final String errorMessage;
  final List<Color> colors;
  final List<Box> boxes;
  final List<Box> selectedBoxes;
  final List<Box> selectingBoxes;

  const GameState({
    this.errorMessage = '',
    this.boxes = const [],
    this.colors = const [],
    this.selectedBoxes = const [],
    this.selectingBoxes = const [],
  });

  GameState copyWidth({
    String? errorMessage,
    List<Color>? colors,
    List<Box>? boxes,
    List<Box>? selectedBoxes,
    List<Box>? selectingBoxes,
  }) {
    return GameState(
      errorMessage: errorMessage ?? this.errorMessage,
      colors: colors ?? this.colors,
      boxes: boxes ?? this.boxes,
      selectedBoxes: selectedBoxes ?? this.selectedBoxes,
      selectingBoxes: selectingBoxes ?? this.selectingBoxes,
    );
  }
}
