import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:sembast/sembast.dart';
import '../../stubs/sembast/sembast_stub.dart'
if (dart.library.io) '../../stubs/sembast/sembast_io.dart'
if (dart.library.html) '../../stubs/sembast/sembast_web.dart';

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

  //
  Database db;

  Window _window;
  IFrameElement _iframeElement;

  void loadEditorFromChartTemplate({
    @required int userId,
    @required int libraryId,
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
    @required int userId,
    @required int appChartId,
  }) async {
    // We use the database factory to open the database
    db ??= await openSembastDB();

    //
    AppChart appChart = await _appChartRepository.onceChart(
      db: db,
      userId: userId,
      chartId: appChartId,
    );
    //
    emit(EditorLoaded(
      appChart: appChart,
    ));
  }

  void updateChart({
    AppChart appChart,
    bool hideViewer,
  }) {
    emit(EditorLoaded(
      appChart: appChart ?? (this.state as EditorLoaded).appChart,
      hideViewer: hideViewer ?? (this.state as EditorLoaded).hideViewer,
    ));
  }

  ///
  void setCurrentWindowAndIFrame(Window win, IFrameElement iframe) {
    _window = win;
    _iframeElement = iframe;
  }

  ///
  void downloadAsPNG({String filename}) async {
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
      for (int i = 0; i < 100; i++) {
        if (_iframeElement.contentWindow != null) {
          _iframeElement.contentWindow.postMessage(
            'getBase64ImageURI',
            '*',
          );
          break;
        }
        await Future.delayed(Duration(milliseconds: 250));
      }
    }
  }
}
