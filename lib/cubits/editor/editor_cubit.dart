import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/chart_template_repository.dart';

part 'editor_state.dart';

class EditorCubit extends Cubit<EditorState> {
  final ChartTemplateRepository chartTemplateRepository;

  EditorCubit({
    @required this.chartTemplateRepository,
  }) : super(EditorInitial());

  void loadEditor({@required String templateId}) {
    emit(EditorLoaded(
      chartConfig: chartTemplateRepository.getTemplate(templateId),
    ));
  }

  void updateChart({@required Map chartConfig}) {
    emit(EditorLoaded(
      chartConfig: chartConfig,
    ));
  }
}
