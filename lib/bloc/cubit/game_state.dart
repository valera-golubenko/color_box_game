part of 'game_cubit.dart';

class GameState {
  final String errorMessage;
  final List<Box> boxes;
  final List<Box> selectedBoxes;
  final List<Box> selectingBoxes;

  GameState({
    this.errorMessage = '',
    this.boxes = const <Box>[],
    this.selectedBoxes = const <Box>[],
    this.selectingBoxes = const <Box>[],
  });

  GameState copyWidth({
    String? errorMessage,
    List<Box>? boxes,
    List<Box>? selectedBoxes,
    List<Box>? selectingBoxes,
  }) {
    return GameState(
      errorMessage: errorMessage ?? this.errorMessage,
      boxes: boxes ?? this.boxes,
      selectedBoxes: selectedBoxes ?? this.selectedBoxes,
      selectingBoxes: selectingBoxes ?? this.selectingBoxes,
    );
  }
}
