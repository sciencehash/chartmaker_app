import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

import '../../repositories/chart_template_repository.dart';

import '../../models/app_chart.dart';

part 'editor_state.dart';

class EditorCubit extends Cubit<EditorState> {
  final String templateId;

  EditorCubit({this.templateId}) : super(EditorInitial());

  void loadEditorFromChartTemplate({
    @required String userId,
    @required String libraryId,
  }) {
    Map template = ChartTemplateRepository.getTemplateById(templateId);
    if (template.isEmpty) {
      template = ChartTemplateRepository.getFirstTemplate();
    }

    emit(EditorLoaded(
      appChart: AppChart(
        id: null,
        userId: userId,
        libraryId: libraryId,
        title: 'New ${template['title']}',
        config: {
          'lib': template['lib'],
          'config': template['config'],
        },
        thumbnail: null,
        utcLastUpdate: DateTime.now().toUtc(),
        activated: true,
      ),
    ));
  }

  void loadEditorFromAppChart({@required AppChart appChart}) {}

  void updateChart({@required AppChart appChart}) {
    emit(EditorLoaded(
      appChart: appChart,
    ));
  }
}
