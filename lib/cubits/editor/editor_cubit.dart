import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import '../../repositories/chart_template_repository.dart';

import '../../models/app_chart.dart';
import '../../repositories/app_chart_repository.dart';

part 'editor_state.dart';

class EditorCubit extends Cubit<EditorState> {
  final AppChartRepository _appChartRepository;

  final String templateId;

  EditorCubit({
    AppChartRepository appChartRepository,
    this.templateId,
  })  : _appChartRepository = appChartRepository,
        super(EditorInitial());

  Window _window;
  IFrameElement _iframeElement;

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

  void loadEditorFromAppChart({
    @required String userId,
    @required String appChartId,
  }) async {
    //
    AppChart appChart = await _appChartRepository.onceChart(
      userId: userId,
      chartId: appChartId,
    );
    //
    emit(EditorLoaded(
      appChart: appChart,
    ));
  }

  void updateChart({@required AppChart appChart}) {
    emit(EditorLoaded(
      appChart: appChart,
    ));
  }

  ///
  void setCurrentWindowAndIFrame(Window win, IFrameElement iframe) {
    _window = win;
    _iframeElement = iframe;
  }

  ///
  void downloadAsPNG({String filename}) {
    filename ??= templateId != null ? '$templateId.png' : 'chartimage.png';
    if (_window != null && _iframeElement != null) {
      //
      onMessage(event) {
        //
        String data = (event as MessageEvent).data;
        //
        if (data.startsWith('base64ImageURI')) {
          // Remove listener
          _window.removeEventListener('message', onMessage);
          //
          data = data.substring(14);
          //
          AnchorElement anchorElement = AnchorElement(
            href: data,
          );
          anchorElement.download = filename;
          anchorElement.click();
        }
      }

      // Add listener
      _window.addEventListener('message', onMessage);

      //
      _iframeElement.contentWindow.postMessage(
        'getBase64ImageURI',
        '*',
      );
    }
  }
}
