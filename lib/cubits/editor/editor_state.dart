part of 'editor_cubit.dart';

abstract class EditorState {
  const EditorState();
}

class EditorInitial extends EditorState {
  // @override
  // List<Object> get props => [];
}

class EditorLoaded extends EditorState {
  final AppChart appChart;

  const EditorLoaded({
    @required this.appChart,
  });

  // @override
  // List<Object> get props => [chartConfig];
}
