import 'chart_template_repository/chartjs/charts/line/simple.dart';
import 'chart_template_repository/chartjs/charts/line/basic.dart';
import 'chart_template_repository/chartjs/charts/line/multi_axis.dart';
import 'chart_template_repository/chartjs/charts/line/stepped.dart';
import 'chart_template_repository/chartjs/charts/line/interpolation_modes.dart';
import 'chart_template_repository/chartjs/charts/line/line_styles.dart';
import 'chart_template_repository/chartjs/charts/line/point_styles.dart';
import 'chart_template_repository/chartjs/charts/line/point_sizes.dart';

import 'chart_template_repository/chartjs/charts/bar/simple.dart';
import 'chart_template_repository/chartjs/charts/bar/horizontal.dart';
import 'chart_template_repository/chartjs/charts/bar/vertical.dart';
import 'chart_template_repository/chartjs/charts/bar/multi_axis.dart';
import 'chart_template_repository/chartjs/charts/bar/stacked.dart';
import 'chart_template_repository/chartjs/charts/bar/stacked_group.dart';

import 'chart_template_repository/apexcharts/line/simple_line.dart';
import 'chart_template_repository/apexcharts/line/basic_line.dart';
import 'chart_template_repository/apexcharts/line/line_with_data_labels.dart';
// import 'chart_template_repository/apexcharts/line/zoomable_timeseries.dart';
import 'chart_template_repository/apexcharts/line/line_with_annotations.dart';
import 'chart_template_repository/apexcharts/line/stepline.dart';
import 'chart_template_repository/apexcharts/line/gradient_line.dart';
import 'chart_template_repository/apexcharts/line/line_with_missing_data.dart';
import 'chart_template_repository/apexcharts/line/dashed_line.dart';

import 'chart_template_repository/apexcharts/bar/basic_bar.dart';
import 'chart_template_repository/apexcharts/bar/grouped_bar.dart';
import 'chart_template_repository/apexcharts/bar/stacked_bar.dart';
import 'chart_template_repository/apexcharts/bar/stacked_bar_100.dart';
import 'chart_template_repository/apexcharts/bar/bar_with_negative.dart';
import 'chart_template_repository/apexcharts/bar/reversed_bar.dart';
import 'chart_template_repository/apexcharts/bar/bar_with_custom_data_labels.dart';
import 'chart_template_repository/apexcharts/bar/patterned_bar.dart';

class ChartTemplateRepository {
  static final Map<String, Map<String, dynamic>> _templates = {
    // ===========================================
    // ============ Chartjs Templates ============
    // ===========================================
    'chartjs': {
      'line': {
        'title': 'Line charts',
        'templates': [
          chartjs_simple_line,
          chartjs_basic_line,
          chartjs_multi_axis_line,
          chartjs_steeped_line_line,
          chartjs_interpolation_line,
          chartjs_line_style,
          chartjs_point_style_line,
          chartjs_point_size_line,
        ],
      },
      'bar': {
        'title': 'Bar charts',
        'templates': [
          chartjs_simple_bar,
          chartjs_horizontal_bar,
          chartjs_vertical_bar,
          chartjs_multi_axis_bar,
          chartjs_stacked_bar,
          chartjs_stacked_group_bar,
        ],
      },
    },
    // ============================================
    // =========== ApexCharts Templates ===========
    // ============================================
    'apexcharts': {
      'line': {
        'title': 'Line charts',
        'templates': [
          apexcharts_simple_line,
          apexcharts_basic_line,
          apexcharts_data_labels_line,
          // apexcharts_zoomable_timeseries_line,
          apexcharts_annotations_line,
          apexcharts_step_line,
          apexcharts_gradient_line,
          apexcharts_missing_line,
          apexcharts_dashed_line,
        ],
      },
      'bar': {
        'title': 'Bar charts',
        'templates': [
          apexcharts_basic_bar,
          apexcharts_grouped_bar,
          apexcharts_stacked_bar,
          apexcharts_full_stacked_bar,
          apexcharts_stacked_negative_bar,
          apexcharts_reversed_bar,
          apexcharts_datalabels_bar,
          apexcharts_pattern_bar,
        ],
      },
    }
  };

  static Map getTemplateById(String templateId) {
    // Iterate libraries
    for (Map libValue in _templates.values) {
      // Iterate categories
      for (Map categoryValue in libValue.values) {
        // Find in templates
        final Map template = categoryValue['templates'].firstWhere(
          (element) => element['id'] == templateId,
          orElse: () => null,
        );
        //
        if (template != null) return template;
      }
    }

    return null;
  }

  static Map getFirstTemplate() {
    return _templates['chartjs']['line']['templates'].first;
  }

  static Map<String, dynamic> getTemplatesByLibrary(String lib) {
    return _templates[lib];
  }
}
