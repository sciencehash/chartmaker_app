part of 'editor_cubit.dart';

abstract class EditorState {
  const EditorState();
}

class EditorInitial extends EditorState {
  // @override
  // List<Object> get props => [];
}

class EditorLoaded extends EditorState {
  final Map chartConfig;

  const EditorLoaded({
    @required this.chartConfig,
  });

  // @override
  // List<Object> get props => [chartConfig];
}
