import 'package:chartmaker_app/utils/template_data/apexcharts_annotations_line.dart';

import '../utils/chartjs_template_utils.dart';

class ChartTemplateRepository {
  static final List<Map> _templates = [
    // ===========================================
    // ============ Chartjs Templates ============
    // ===========================================
    // Template
    {
      'id': 'lineTemplate01',
      'lib': 'chartjs',
      'title': 'Simple Line Chart',
      'config': {
        'type': 'line',
        'data': {
          'labels': [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July',
          ],
          'datasets': [
            {
              'label': 'My First dataset',
              'backgroundColor': 'rgb(255, 99, 132)',
              'borderColor': 'rgb(255, 99, 132)',
              'data': [0, 10, 15, 2, 20, 30, 45]
            }
          ]
        },
        'options': {},
      },
    },
// Template
    {
      'id': 'chartjs-basic-line',
      'lib': 'chartjs',
      'title': 'Basic Line Chart',
      'config': {
        'type': 'line',
        'data': {
          'labels': [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July'
          ],
          'datasets': [
            {
              'label': 'My First dataset',
              'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
              'borderColor': ChartjsTemplateUtils.chartColors['red'],
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ],
              'fill': false,
            },
            {
              'label': 'My Second dataset',
              'fill': false,
              'backgroundColor': ChartjsTemplateUtils.chartColors['blue'],
              'borderColor': ChartjsTemplateUtils.chartColors['blue'],
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ],
            }
          ]
        },
        'options': {
          'responsive': true,
          'title': {'display': true, 'text': 'Chart.js Line Chart'},
          'tooltips': {
            'mode': 'index',
            'intersect': false,
          },
          'hover': {'mode': 'nearest', 'intersect': true},
          'scales': {
            'x': {
              'display': true,
              'scaleLabel': {'display': true, 'labelString': 'Month'}
            },
            'y': {
              'display': true,
              'scaleLabel': {'display': true, 'labelString': 'Value'}
            }
          }
        }
      },
    },
// Template
    {
      'id': 'chartjs-multi-axis-line',
      'lib': 'chartjs',
      'title': 'Multi Axis Line Chart',
      'config': {
        'type': 'line',
        'data': {
          'labels': [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July'
          ],
          'datasets': [
            {
              'label': 'My First dataset',
              'borderColor': ChartjsTemplateUtils.chartColors['red'],
              'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
              'fill': false,
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ],
              'yAxisID': 'y',
            },
            {
              'label': 'My Second dataset',
              'borderColor': ChartjsTemplateUtils.chartColors['blue'],
              'backgroundColor': ChartjsTemplateUtils.chartColors['blue'],
              'fill': false,
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ],
              'yAxisID': 'y1'
            }
          ]
        },
        'options': {
          'responsive': true,
          'hoverMode': 'index',
          'stacked': false,
          'title': {
            'display': true,
            'text': 'Chart.js Line Chart - Multi Axis'
          },
          'scales': {
            'y': {
              'type': 'linear',
// only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
              'display': true,
              'position': 'left',
            },
            'y1': {
              'type': 'linear',
// only linear but allow scale type registration. This allows extensions to exist solely for log scale for instance
              'display': true,
              'position': 'right',
// grid line settings
              'gridLines': {
                'drawOnChartArea': false,
// only want the grid lines for one axis to show up
              },
            },
          }
        }
      },
    },
// Template
    {
      'id': 'chartjs-stepped-line',
      'lib': 'chartjs',
      'title': 'Stepped Line Chart',
      'config': {
        'type': 'line',
        'data': {
          'labels': ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6'],
          'datasets': [
            {
              'label': 'stepped: true',
              'stepped': true,
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ],
              'borderColor': ChartjsTemplateUtils.chartColors['green'],
              'fill': false,
            }
          ]
        },
        'options': {
          'responsive': true,
          'title': {
            'display': true,
            'text': 'Step Before Interpolation',
          }
        }
      },
    },
// Template
    {
      'id': 'chartjs-interpolation-line',
      'lib': 'chartjs',
      'title': 'Interpolation Line Chart',
      'config': {
        'type': 'line',
        'data': {
          'labels': [
            '0',
            '1',
            '2',
            '3',
            '4',
            '5',
            '6',
            '7',
            '8',
            '9',
            '10',
            '11',
            '12'
          ],
          'datasets': [
            {
              'label': 'Cubic interpolation (monotone)',
              'data': [
                0,
                20,
                20,
                60,
                60,
                120,
                100,
                180,
                120,
                125,
                105,
                110,
                170
              ],
              'borderColor': ChartjsTemplateUtils.chartColors['red'],
              'backgroundColor': 'rgba(0, 0, 0, 0)',
              'fill': false,
              'cubicInterpolationMode': 'monotone'
            },
            {
              'label': 'Cubic interpolation (default)',
              'data': [
                0,
                20,
                20,
                60,
                60,
                120,
                100,
                180,
                120,
                125,
                105,
                110,
                170
              ],
              'borderColor': ChartjsTemplateUtils.chartColors['blue'],
              'backgroundColor': 'rgba(0, 0, 0, 0)',
              'fill': false,
            },
            {
              'label': 'Linear interpolation',
              'data': [
                0,
                20,
                20,
                60,
                60,
                120,
                100,
                180,
                120,
                125,
                105,
                110,
                170
              ],
              'borderColor': ChartjsTemplateUtils.chartColors['green'],
              'backgroundColor': 'rgba(0, 0, 0, 0)',
              'fill': false,
              'lineTension': 0
            }
          ]
        },
        'options': {
          'responsive': true,
          'title': {
            'display': true,
            'text': 'Chart.js Line Chart - Cubic interpolation mode'
          },
          'tooltips': {'mode': 'index'},
          'scales': {
            'x': {
              'display': true,
              'scaleLabel': {'display': true}
            },
            'y': {
              'display': true,
              'scaleLabel': {'display': true, 'labelString': 'Value'},
              'suggestedMin': -10,
              'suggestedMax': 200
            }
          }
        }
      },
    },
// Template
    {
      'id': 'chartjs-line-style',
      'lib': 'chartjs',
      'title': 'Line Style Chart',
      'config': {
        'type': 'line',
        'data': {
          'labels': [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July'
          ],
          'datasets': [
            {
              'label': 'Unfilled',
              'fill': false,
              'backgroundColor': ChartjsTemplateUtils.chartColors['blue'],
              'borderColor': ChartjsTemplateUtils.chartColors['blue'],
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ],
            },
            {
              'label': 'Dashed',
              'fill': false,
              'backgroundColor': ChartjsTemplateUtils.chartColors['green'],
              'borderColor': ChartjsTemplateUtils.chartColors['green'],
              'borderDash': [5, 5],
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ],
            },
            {
              'label': 'Filled',
              'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
              'borderColor': ChartjsTemplateUtils.chartColors['red'],
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ],
              'fill': true,
            }
          ]
        },
        'options': {
          'responsive': true,
          'title': {'display': true, 'text': 'Chart.js Line Chart'},
          'tooltips': {
            'mode': 'index',
            'intersect': false,
          },
          'hover': {'mode': 'nearest', 'intersect': true},
          'scales': {
            'x': {
              'display': true,
              'scaleLabel': {'display': true, 'labelString': 'Month'}
            },
            'y': {
              'display': true,
              'scaleLabel': {'display': true, 'labelString': 'Value'}
            }
          }
        }
      },
    },
// Template
    {
      'id': 'chartjs-point-style-line',
      'lib': 'chartjs',
      'title': 'Point Style Line Chart',
      'config': {
        'type': 'line',
        'data': {
          'labels': [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July'
          ],
          'datasets': [
            {
              'label': 'My First dataset',
              'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
              'borderColor': ChartjsTemplateUtils.chartColors['red'],
              'data': [10, 23, 5, 99, 67, 43, 0],
              'fill': false,
              'pointRadius': 10,
              'pointHoverRadius': 15,
              'showLine': false // no line shown
            }
          ]
        },
        'options': {
          'responsive': true,
          'title': {'display': true, 'text': 'Point Style: circle'},
          'legend': {'display': false},
          'elements': {
            'point': {'pointStyle': 'circle'}
          }
        }
      },
    },
// Template
    {
      'id': 'chartjs-point-size-line',
      'lib': 'chartjs',
      'title': 'Point Size Line Chart',
      'config': {
        'type': 'line',
        'data': {
          'labels': [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July'
          ],
          'datasets': [
            {
              'label': 'dataset - big points',
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ],
              'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
              'borderColor': ChartjsTemplateUtils.chartColors['red'],
              'fill': false,
              'borderDash': [5, 5],
              'pointRadius': 15,
              'pointHoverRadius': 10,
            },
            {
              'label': 'dataset - individual point sizes',
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ],
              'backgroundColor': ChartjsTemplateUtils.chartColors['blue'],
              'borderColor': ChartjsTemplateUtils.chartColors['blue'],
              'fill': false,
              'borderDash': [5, 5],
              'pointRadius': [2, 4, 6, 18, 0, 12, 20],
            },
            {
              'label': 'dataset - large pointHoverRadius',
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ],
              'backgroundColor': ChartjsTemplateUtils.chartColors['green'],
              'borderColor': ChartjsTemplateUtils.chartColors['green'],
              'fill': false,
              'pointHoverRadius': 30,
            },
            {
              'label': 'dataset - large pointHitRadius',
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ],
              'backgroundColor': ChartjsTemplateUtils.chartColors['yellow'],
              'borderColor': ChartjsTemplateUtils.chartColors['yellow'],
              'fill': false,
              'pointHitRadius': 20,
            }
          ]
        },
        'options': {
          'responsive': true,
          'legend': {
            'position': 'bottom',
          },
          'hover': {'mode': 'index'},
          'scales': {
            'x': {
              'display': true,
              'scaleLabel': {'display': true, 'labelString': 'Month'}
            },
            'y': {
              'display': true,
              'scaleLabel': {'display': true, 'labelString': 'Value'}
            }
          },
          'title': {
            'display': true,
            'text': 'Chart.js Line Chart - Different point sizes'
          }
        }
      },
    },
// Template
    {
      'id': 'chartjs-simple-bar',
      'lib': 'chartjs',
      'title': 'Simple Bar Chart',
      'config': {
        'type': 'bar',
        'data': {
          'labels': ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
          'datasets': [
            {
              'label': '# of Votes',
              'data': [12, 19, 3, 5, 2, 3],
              'backgroundColor': [
                'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'
              ],
              'borderColor': [
                'rgba(255, 99, 132, 1)',
                'rgba(54, 162, 235, 1)',
                'rgba(255, 206, 86, 1)',
                'rgba(75, 192, 192, 1)',
                'rgba(153, 102, 255, 1)',
                'rgba(255, 159, 64, 1)'
              ],
              'borderWidth': 1
            }
          ]
        },
        'options': {
          'scales': {
            'yAxes': [
              {
                'ticks': {'beginAtZero': true}
              }
            ]
          }
        }
      },
    },
// Template
    {
      'id': 'chartjs-horizontal-bar',
      'lib': 'chartjs',
      'title': 'Horizontal Bar Chart',
      'config': {
        'type': 'bar',
        'data': {
          'labels': [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July'
          ],
          'datasets': [
            {
              'label': 'Dataset 1',
              'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
              'borderColor': ChartjsTemplateUtils.chartColors['red'],
              'borderWidth': 1,
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ]
            },
            {
              'label': 'Dataset 2',
              'backgroundColor': ChartjsTemplateUtils.chartColors['blue'],
              'borderColor': ChartjsTemplateUtils.chartColors['blue'],
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ]
            }
          ]
        },
        'options': {
          'indexAxis': 'y',
// Elements options apply to all of the options unless overridden in a dataset
// In this case, we are setting the border of each horizontal bar to be 2px wide
          'elements': {
            'rectangle': {
              'borderWidth': 2,
            }
          },
          'responsive': true,
          'legend': {
            'position': 'right',
          },
          'title': {'display': true, 'text': 'Chart.js Horizontal Bar Chart'}
        }
      },
    },
// Template
    {
      'id': 'chartjs-vertical-bar',
      'lib': 'chartjs',
      'title': 'Vertical Bar Chart',
      'config': {
        'type': 'bar',
        'data': {
          'labels': [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July'
          ],
          'datasets': [
            {
              'label': 'Dataset 1',
              'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
              'borderColor': ChartjsTemplateUtils.chartColors['red'],
              'borderWidth': 1,
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ]
            },
            {
              'label': 'Dataset 2',
              'backgroundColor': ChartjsTemplateUtils.chartColors['blue'],
              'borderColor': ChartjsTemplateUtils.chartColors['blue'],
              'borderWidth': 1,
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ]
            }
          ]
        },
        'options': {
          'responsive': true,
          'legend': {
            'position': 'top',
          },
          'title': {'display': true, 'text': 'Chart.js Bar Chart'}
        }
      },
    },
// Template
    {
      'id': 'chartjs-multi-axis-bar',
      'lib': 'chartjs',
      'title': 'Multi Axis Bar Chart',
      'config': {
        'type': 'bar',
        'data': {
          'labels': [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July'
          ],
          'datasets': [
            {
              'label': 'Dataset 1',
              'backgroundColor': [
                ChartjsTemplateUtils.chartColors['red'],
                ChartjsTemplateUtils.chartColors['orange'],
                ChartjsTemplateUtils.chartColors['yellow'],
                ChartjsTemplateUtils.chartColors['green'],
                ChartjsTemplateUtils.chartColors['blue'],
                ChartjsTemplateUtils.chartColors['purple'],
                ChartjsTemplateUtils.chartColors['red'],
              ],
              'yAxisID': 'y',
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ]
            },
            {
              'label': 'Dataset 2',
              'backgroundColor': ChartjsTemplateUtils.chartColors['grey'],
              'yAxisID': 'y1',
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ]
            }
          ]
        },
        'options': {
          'responsive': true,
          'title': {'display': true, 'text': 'Chart.js Bar Chart - Multi Axis'},
          'tooltips': {'mode': 'index', 'intersect': true},
          'scales': {
            'y': {
              'type': 'linear',
              'display': true,
              'position': 'left',
            },
            'y1': {
              'type': 'linear',
              'display': true,
              'position': 'right',
              'gridLines': {'drawOnChartArea': false}
            },
          }
        }
      },
    },
// Template
    {
      'id': 'chartjs-stacked-bar',
      'lib': 'chartjs',
      'title': 'Stacked Bar Chart',
      'config': {
        'type': 'bar',
        'data': {
          'labels': [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July'
          ],
          'datasets': [
            {
              'label': 'Dataset 1',
              'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ]
            },
            {
              'label': 'Dataset 2',
              'backgroundColor': ChartjsTemplateUtils.chartColors['blue'],
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ]
            },
            {
              'label': 'Dataset 3',
              'backgroundColor': ChartjsTemplateUtils.chartColors['green'],
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ]
            }
          ]
        },
        'options': {
          'title': {'display': true, 'text': 'Chart.js Bar Chart - Stacked'},
          'tooltips': {'mode': 'index', 'intersect': false},
          'responsive': true,
          'scales': {
            'x': {
              'stacked': true,
            },
            'y': {'stacked': true}
          }
        }
      },
    },
// Template
    {
      'id': 'chartjs-stacked-group-bar',
      'lib': 'chartjs',
      'title': 'Stacked Group Bar Chart',
      'config': {
        'type': 'bar',
        'data': {
          'labels': [
            'January',
            'February',
            'March',
            'April',
            'May',
            'June',
            'July'
          ],
          'datasets': [
            {
              'label': 'Dataset 1',
              'backgroundColor': ChartjsTemplateUtils.chartColors['red'],
              'stack': 'Stack 0',
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ]
            },
            {
              'label': 'Dataset 2',
              'backgroundColor': ChartjsTemplateUtils.chartColors['blue'],
              'stack': 'Stack 0',
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ]
            },
            {
              'label': 'Dataset 3',
              'backgroundColor': ChartjsTemplateUtils.chartColors['green'],
              'stack': 'Stack 1',
              'data': [
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor(),
                ChartjsTemplateUtils.randomScalingFactor()
              ]
            }
          ]
        },
        'options': {
          'title': {'display': true, 'text': 'Chart.js Bar Chart - Stacked'},
          'tooltips': {'mode': 'index', 'intersect': false},
          'responsive': true,
          'scales': {
            'x': {
              'stacked': true,
            },
            'y': {'stacked': true}
          }
        }
      },
    },
// Template
// {
//   'id': 'chartjs-aa-bar',
//   'lib': 'chartjs',
//   'title': 'AA Bar Chart',
//   'config': {},
// },
// ============================================
// =========== ApexCharts Templates ===========
// ============================================
// Template
    {
      'id': 'lineTemplateA01',
      'lib': 'apexcharts',
      'title': 'Simple Line Chart A1',
      'config': {
        'chart': {'type': 'line'},
        'series': [
          {
            'name': 'sales',
            'data': [30, 40, 35, 50, 49, 60, 70, 91, 125]
          }
        ],
        'xaxis': {
          'categories': [1991, 1992, 1993, 1994, 1995, 1996, 1997, 1998, 1999]
        }
      },
    },
// Template
    {
      'id': 'apexcharts-basic-line',
      'lib': 'apexcharts',
      'title': 'Basic Line Chart',
      'config': {
        'chart': {
          'height': 350,
          'type': 'line',
          'zoom': {'enabled': false}
        },
        'dataLabels': {'enabled': false},
        'stroke': {'curve': 'straight'},
        'title': {'text': 'Product Trends by Month', 'align': 'left'},
        'grid': {
          'row': {
            'colors': ['#f3f3f3', 'transparent'],
// takes an array which will be repeated on columns
            'opacity': 0.5
          },
        },
        'xaxis': {
          'categories': [
            'Jan',
            'Feb',
            'Mar',
            'Apr',
            'May',
            'Jun',
            'Jul',
            'Aug',
            'Sep'
          ],
        },
        'series': [
          {
            'name': "Desktops",
            'data': [10, 41, 35, 51, 49, 62, 69, 91, 148]
          }
        ]
      },
    },
// Template
    {
      'id': 'apexcharts-data-labels-line',
      'lib': 'apexcharts',
      'title': 'Line Chart with Data Labels',
      'config': {
        'chart': {
          'height': 350,
          'type': 'line',
          'dropShadow': {
            'enabled': true,
            'color': '#000',
            'top': 18,
            'left': 7,
            'blur': 10,
            'opacity': 0.2
          },
          'toolbar': {'show': false}
        },
        'colors': ['#77B6EA', '#545454'],
        'dataLabels': {
          'enabled': true,
        },
        'stroke': {'curve': 'smooth'},
        'title': {'text': 'Average High & Low Temperature', 'align': 'left'},
        'grid': {
          'borderColor': '#e7e7e7',
          'row': {
            'colors': ['#f3f3f3', 'transparent'],
// takes an array which will be repeated on columns
            'opacity': 0.5
          },
        },
        'markers': {'size': 1},
        'xaxis': {
          'categories': ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
          'title': {'text': 'Month'}
        },
        'yaxis': {
          'title': {'text': 'Temperature'},
          'min': 5,
          'max': 40
        },
        'legend': {
          'position': 'top',
          'horizontalAlign': 'right',
          'floating': true,
          'offsetY': -25,
          'offsetX': -5
        },
        'series': [
          {
            'name': "High - 2013",
            'data': [28, 29, 33, 36, 32, 32, 33]
          },
          {
            'name': "Low - 2013",
            'data': [12, 11, 14, 18, 17, 13, 13]
          }
        ]
      },
    },
// Template
//     {
//       'id': 'apexcharts-zoomable-timeseries-line',
//       'lib': 'apexcharts',
//       'title': 'Zoomable TimeSeries Line Chart',
//       'config': {
//         'chart': {
//           'type': 'area',
//           'stacked': false,
//           'height': 350,
//           'zoom': {
//             'type': 'x',
//             'enabled': true,
//             'autoScaleYaxis': true
//           },
//           'toolbar': {
//             'autoSelected': 'zoom'
//           }
//         },
//         'dataLabels': {
//           'enabled': false
//         },
//         'markers': {
//           'size': 0,
//         },
//         'title': {
//           'text': 'Stock Price Movement',
//           'align': 'left'
//         },
//         'fill': {
//           'type': 'gradient',
//           'gradient': {
//             'shadeIntensity': 1,
//             'inverseColors': false,
//             'opacityFrom': 0.5,
//             'opacityTo': 0,
//             'stops': [0, 90, 100]
//           },
//         },
//         'yaxis': {
//           'labels': {
//             'formatter': (val) {
//               return (val / 1000000).toFixed(0);
//             },
//           },
//           'title': {
//             'text': 'Price'
//           },
//         },
//         'xaxis': {
//           'type': 'datetime',
//         },
//         'tooltip': {
//           'shared': false,
//           'y': {
//             'formatter': (val) {
//               return (val / 1000000).toFixed(0);
//             }
//           }
//         },
//         'series': [{
//           'name': 'XYZ MOTORS',
//           'data': getData(),
//         }
//         ]
//       },
//     },
// Template
    {
      'id': 'apexcharts-annotations-line',
      'lib': 'apexcharts',
      'title': 'Line Chart with Annotations',
      'config': {
        'chart': {'height': 350, 'type': 'line', 'id': 'areachart-2'},
        'annotations': {
          'yaxis': [
            {
              'y': 8200,
              'borderColor': '#00E396',
              'label': {
                'borderColor': '#00E396',
                'style': {
                  'color': '#fff',
                  'background': '#00E396',
                },
                'text': 'Support',
              }
            },
            {
              'y': 8600,
              'y2': 9000,
              'borderColor': '#000',
              'fillColor': '#FEB019',
              'opacity': 0.2,
              'label': {
                'borderColor': '#333',
                'style': {
                  'fontSize': '10px',
                  'color': '#333',
                  'background': '#FEB019',
                },
                'text': 'Y-axis range',
              }
            }
          ],
          'xaxis': [
            {
              'x': DateTime.parse('2017-11-23').millisecondsSinceEpoch,
              'strokeDashArray': 0,
              'borderColor': '#775DD0',
              'label': {
                'borderColor': '#775DD0',
                'style': {
                  'color': '#fff',
                  'background': '#775DD0',
                },
                'text': 'Anno Test',
              }
            },
            {
              'x': DateTime.parse('2017-11-26').millisecondsSinceEpoch,
              'x2': DateTime.parse('2017-11-28').millisecondsSinceEpoch,
              'fillColor': '#B3F7CA',
              'opacity': 0.4,
              'label': {
                'borderColor': '#B3F7CA',
                'style': {
                  'fontSize': '10px',
                  'color': '#fff',
                  'background': '#00E396',
                },
                'offsetY': -10,
                'text': 'X-axis range',
              }
            }
          ],
          'points': [
            {
              'x': DateTime.parse('2017-12-01').millisecondsSinceEpoch,
              'y': 8607.55,
              'marker': {
                'size': 8,
                'fillColor': '#fff',
                'strokeColor': 'red',
                'radius': 2,
                'cssClass': 'apexcharts-custom-class'
              },
              'label': {
                'borderColor': '#FF4560',
                'offsetY': 0,
                'style': {
                  'color': '#fff',
                  'background': '#FF4560',
                },
                'text': 'Point Annotation',
              }
            },
            {
              'x': DateTime.parse('2017-12-08').millisecondsSinceEpoch,
              'y': 9340.85,
              'marker': {'size': 0},
              // 'image': {'path': '../../assets/images/ico-instagram.png'}
            }
          ]
        },
        'dataLabels': {'enabled': false},
        'stroke': {'curve': 'straight'},
        'grid': {
          'padding': {'right': 30, 'left': 20}
        },
        'title': {'text': 'Line with Annotations', 'align': 'left'},
        'labels': apexcharts_annotations_line_series['monthDataSeries1']
            ['dates'],
        'xaxis': {
          'type': 'datetime',
        },
        'series': [
          {
            'data': apexcharts_annotations_line_series['monthDataSeries1']
                ['prices']
          }
        ],
      },
    },
// Template
    {
      'id': 'apexcharts-step-line',
      'lib': 'apexcharts',
      'title': 'Stepline Chart',
      'config': {
        'chart': {'type': 'line', 'height': 350},
        'stroke': {
          'curve': 'stepline',
        },
        'dataLabels': {'enabled': false},
        'title': {'text': 'Stepline Chart', 'align': 'left'},
        'markers': {
          'hover': {'sizeOffset': 4}
        },
        'series': [
          {
            'data': [34, 44, 54, 21, 12, 43, 33, 23, 66, 66, 58]
          }
        ]
      },
    },
    // Template
    {
      'id': 'apexcharts-gradient-line',
      'lib': 'apexcharts',
      'title': 'Gradient Line Chart',
      'config': {
        'chart': {
          'height': 350,
          'type': 'line',
        },
        'stroke': {'width': 7, 'curve': 'smooth'},
        'xaxis': {
          'type': 'datetime',
          'categories': [
            '1/11/2000',
            '2/11/2000',
            '3/11/2000',
            '4/11/2000',
            '5/11/2000',
            '6/11/2000',
            '7/11/2000',
            '8/11/2000',
            '9/11/2000',
            '10/11/2000',
            '11/11/2000',
            '12/11/2000',
            '1/11/2001',
            '2/11/2001',
            '3/11/2001',
            '4/11/2001',
            '5/11/2001',
            '6/11/2001'
          ],
        },
        'title': {
          'text': 'Social Media',
          'align': 'left',
          'style': {'fontSize': "16px", 'color': '#666'}
        },
        'fill': {
          'type': 'gradient',
          'gradient': {
            'shade': 'dark',
            'gradientToColors': ['#FDD835'],
            'shadeIntensity': 1,
            'type': 'horizontal',
            'opacityFrom': 1,
            'opacityTo': 1,
            'stops': [0, 100, 100, 100]
          },
        },
        'markers': {
          'size': 4,
          'colors': ["#FFA41B"],
          'strokeColors': "#fff",
          'strokeWidth': 2,
          'hover': {
            'size': 7,
          }
        },
        'yaxis': {
          'min': -10,
          'max': 40,
          'title': {
            'text': 'Engagement',
          },
        },
        'series': [
          {
            'name': 'Likes',
            'data': [
              4,
              3,
              10,
              9,
              29,
              19,
              22,
              9,
              12,
              7,
              19,
              5,
              13,
              9,
              17,
              2,
              7,
              5
            ]
          }
        ]
      },
    },
    // Template
    {
      'id': 'apexcharts-missing-line',
      'lib': 'apexcharts',
      'title': 'Line Chart with missing data',
      'config': {
        'chart': {
          'height': 350,
          'type': 'line',
          'zoom': {'enabled': false},
          'animations': {'enabled': false}
        },
        'stroke': {
          'width': [5, 5, 4],
          'curve': 'straight'
        },
        'labels': [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16],
        'title': {'text': 'Missing data (null values)'},
        'xaxis': {},
        'series': [
          {
            'name': 'Peter',
            'data': [5, 5, 10, 8, 7, 5, 4, null, null, null, 10, 10, 7, 8, 6, 9]
          },
          {
            'name': 'Johnny',
            'data': [
              10,
              15,
              null,
              12,
              null,
              10,
              12,
              15,
              null,
              null,
              12,
              null,
              14,
              null,
              null,
              null
            ]
          },
          {
            'name': 'David',
            'data': [
              null,
              null,
              null,
              null,
              3,
              4,
              1,
              3,
              4,
              6,
              7,
              9,
              5,
              null,
              null,
              null
            ]
          }
        ]
      },
    },
    // Template
    {
      'id': 'apexcharts-dashed-line',
      'lib': 'apexcharts',
      'title': 'Dashed Line Chart',
      'config': {
        'chart': {
          'height': 350,
          'type': 'line',
          'zoom': {'enabled': false},
        },
        'dataLabels': {'enabled': false},
        'stroke': {
          'width': [5, 7, 5],
          'curve': 'straight',
          'dashArray': [0, 8, 5]
        },
        'title': {'text': 'Page Statistics', 'align': 'left'},
        'legend': {
          // 'tooltipHoverFormatter': (val, opts) {
          //   return val +
          //       ' - <strong>' +
          //       opts.w.globals.series[opts.seriesIndex][opts.dataPointIndex] +
          //       '</strong>';
          // }
        },
        'markers': {
          'size': 0,
          'hover': {'sizeOffset': 6}
        },
        'xaxis': {
          'categories': [
            '01 Jan',
            '02 Jan',
            '03 Jan',
            '04 Jan',
            '05 Jan',
            '06 Jan',
            '07 Jan',
            '08 Jan',
            '09 Jan',
            '10 Jan',
            '11 Jan',
            '12 Jan'
          ],
        },
        'tooltip': {
          'y': [
            {
              'title': {
                // 'formatter': (val) {
                //   return val + " (mins)";
                // }
              }
            },
            {
              'title': {
                // 'formatter': (val) {
                //   return val + " per session";
                // }
              }
            },
            {
              'title': {
                // 'formatter': (val) {
                //   return val;
                // }
              }
            }
          ]
        },
        'grid': {
          'borderColor': '#f1f1f1',
        },
        'series': [
          {
            'name': "Session Duration",
            'data': [45, 52, 38, 24, 33, 26, 21, 20, 6, 8, 15, 10]
          },
          {
            'name': "Page Views",
            'data': [35, 41, 62, 42, 13, 18, 29, 37, 36, 51, 32, 35]
          },
          {
            'name': 'Total Visits',
            'data': [87, 57, 74, 99, 75, 38, 62, 47, 82, 56, 45, 47]
          }
        ]
      },
    },
    // Template
    {
      'id': 'apexcharts-basic-bar',
      'lib': 'apexcharts',
      'title': 'Basic Bar Chart',
      'config': {
        'chart': {'type': 'bar', 'height': 350},
        'plotOptions': {
          'bar': {
            'horizontal': true,
          }
        },
        'dataLabels': {'enabled': false},
        'xaxis': {
          'categories': [
            'South Korea',
            'Canada',
            'United Kingdom',
            'Netherlands',
            'Italy',
            'France',
            'Japan',
            'United States',
            'China',
            'Germany'
          ],
        },
        'series': [
          {
            'data': [400, 430, 448, 470, 540, 580, 690, 1100, 1200, 1380]
          }
        ]
      },
    },
    // Template
    {
      'id': 'apexcharts-grouped-bar',
      'lib': 'apexcharts',
      'title': 'Grouped Bar Chart',
      'config': {
        'chart': {'type': 'bar', 'height': 430},
        'plotOptions': {
          'bar': {
            'horizontal': true,
            'dataLabels': {
              'position': 'top',
            },
          }
        },
        'dataLabels': {
          'enabled': true,
          'offsetX': -6,
          'style': {
            'fontSize': '12px',
            'colors': ['#fff']
          }
        },
        'stroke': {
          'show': true,
          'width': 1,
          'colors': ['#fff']
        },
        'xaxis': {
          'categories': [2001, 2002, 2003, 2004, 2005, 2006, 2007],
        },
        'series': [
          {
            'data': [44, 55, 41, 64, 22, 43, 21]
          },
          {
            'data': [53, 32, 33, 52, 13, 44, 32]
          }
        ]
      },
    },
    // Template
    {
      'id': 'apexcharts-stacked-bar',
      'lib': 'apexcharts',
      'title': 'Stacked Bar Chart',
      'config': {
        'chart': {
          'type': 'bar',
          'height': 350,
          'stacked': true,
        },
        'plotOptions': {
          'bar': {
            'horizontal': true,
          },
        },
        'stroke': {
          'width': 1,
          'colors': ['#fff']
        },
        'title': {'text': 'Fiction Books Sales'},
        'xaxis': {
          'categories': [2008, 2009, 2010, 2011, 2012, 2013, 2014],
          'labels': {
            // 'formatter': function (val) {
            // return val + "K";
            // }
          }
        },
        'yaxis': {
          'title': {'text': ''},
        },
        'tooltip': {
          'y': {
            // formatter: function (val) {
            // return val + "K";
            // }
          }
        },
        'fill': {'opacity': 1},
        'legend': {'position': 'top', 'horizontalAlign': 'left', 'offsetX': 40},
        'series': [
          {
            'name': 'Marine Sprite',
            'data': [44, 55, 41, 37, 22, 43, 21]
          },
          {
            'name': 'Striking Calf',
            'data': [53, 32, 33, 52, 13, 43, 32]
          },
          {
            'name': 'Tank Picture',
            'data': [12, 17, 11, 9, 15, 11, 20]
          },
          {
            'name': 'Bucket Slope',
            'data': [9, 7, 5, 8, 6, 9, 4]
          },
          {
            'name': 'Reborn Kid',
            'data': [25, 12, 19, 32, 25, 24, 10]
          }
        ]
      },
    },
    // Template
    {
      'id': 'apexcharts-full-stacked-bar',
      'lib': 'apexcharts',
      'title': 'Full Stacked Bar Chart',
      'config': {
        'chart': {
          'type': 'bar',
          'height': 350,
          'stacked': true,
          'stackType': '100%'
        },
        'plotOptions': {
          'bar': {
            'horizontal': true,
          },
        },
        'stroke': {
          'width': 1,
          'colors': ['#fff']
        },
        'title': {'text': '100% Stacked Bar'},
        'xaxis': {
          'categories': [2008, 2009, 2010, 2011, 2012, 2013, 2014],
        },
        'tooltip': {
          'y': {
            // formatter: function (val) {
            // return val + "K"
            // }
          }
        },
        'fill': {'opacity': 1},
        'legend': {'position': 'top', 'horizontalAlign': 'left', 'offsetX': 40},
        'series': [
          {
            'name': 'Marine Sprite',
            'data': [44, 55, 41, 37, 22, 43, 21]
          },
          {
            'name': 'Striking Calf',
            'data': [53, 32, 33, 52, 13, 43, 32]
          },
          {
            'name': 'Tank Picture',
            'data': [12, 17, 11, 9, 15, 11, 20]
          },
          {
            'name': 'Bucket Slope',
            'data': [9, 7, 5, 8, 6, 9, 4]
          },
          {
            'name': 'Reborn Kid',
            'data': [25, 12, 19, 32, 25, 24, 10]
          }
        ]
      },
    },
    // Template
    {
      'id': 'apexcharts-stacked-negative-bar',
      'lib': 'apexcharts',
      'title': 'Stacked Bar Chart with Negative Values',
      'config': {
        'chart': {'type': 'bar', 'height': 440, 'stacked': true},
        'colors': ['#008FFB', '#FF4560'],
        'plotOptions': {
          'bar': {
            'horizontal': true,
            'barHeight': '80%',
          },
        },
        'dataLabels': {'enabled': false},
        'stroke': {
          'width': 1,
          'colors': ["#fff"]
        },
        'grid': {
          'xaxis': {
            'lines': {'show': false}
          }
        },
        'yaxis': {
          'min': -5,
          'max': 5,
          'title': {
            // text: 'Age',
          },
        },
        'tooltip': {
          'shared': false,
          'x': {
            // formatter: function (val) {
            // return val
            // }
          },
          'y': {
            // formatter: function (val) {
            // return Math.abs(val) + "%"
            // }
          }
        },
        'title': {'text': 'Mauritius population pyramid 2011'},
        'xaxis': {
          'categories': [
            '85+',
            '80-84',
            '75-79',
            '70-74',
            '65-69',
            '60-64',
            '55-59',
            '50-54',
            '45-49',
            '40-44',
            '35-39',
            '30-34',
            '25-29',
            '20-24',
            '15-19',
            '10-14',
            '5-9',
            '0-4'
          ],
          'title': {'text': 'Percent'},
          'labels': {
            // formatter: function (val) {
            // return Math.abs(Math.round(val)) + "%"
            // }
          }
        },
        'series': [
          {
            'name': 'Males',
            'data': [
              0.4,
              0.65,
              0.76,
              0.88,
              1.5,
              2.1,
              2.9,
              3.8,
              3.9,
              4.2,
              4,
              4.3,
              4.1,
              4.2,
              4.5,
              3.9,
              3.5,
              3
            ]
          },
          {
            'name': 'Females',
            'data': [
              -0.8,
              -1.05,
              -1.06,
              -1.18,
              -1.4,
              -2.2,
              -2.85,
              -3.7,
              -3.96,
              -4.22,
              -4.3,
              -4.4,
              -4.1,
              -4,
              -4.1,
              -3.4,
              -3.1,
              -2.8
            ]
          }
        ]
      },
    },
    // Template
    {
      'id': 'apexcharts-reversed-bar',
      'lib': 'apexcharts',
      'title': 'Reversed Bar Chart',
      'config': {
        'chart': {'type': 'bar', 'height': 350},
        'annotations': {
          'xaxis': [
            {
              'x': 500,
              'borderColor': '#00E396',
              'label': {
                'borderColor': '#00E396',
                'style': {
                  'color': '#fff',
                  'background': '#00E396',
                },
                'text': 'X annotation',
              }
            }
          ],
          'yaxis': [
            {
              'y': 'July',
              'y2': 'September',
              'label': {'text': 'Y annotation'}
            }
          ]
        },
        'plotOptions': {
          'bar': {
            'horizontal': true,
          }
        },
        'dataLabels': {'enabled': true},
        'xaxis': {
          'categories': [
            'June',
            'July',
            'August',
            'September',
            'October',
            'November',
            'December'
          ],
        },
        'grid': {
          'xaxis': {
            'lines': {'show': true}
          }
        },
        'yaxis': {
          'reversed': true,
          'axisTicks': {'show': true}
        },
        'series': [
          {
            'data': [400, 430, 448, 470, 540, 580, 690]
          }
        ]
      },
    },
    // Template
    {
      'id': 'apexcharts-datalabels-bar',
      'lib': 'apexcharts',
      'title': 'Bar with Custom DataLabels',
      'config': {
        'chart': {'type': 'bar', 'height': 380},
        'plotOptions': {
          'bar': {
            'barHeight': '100%',
            'distributed': true,
            'horizontal': true,
            'dataLabels': {'position': 'bottom'},
          }
        },
        'colors': [
          '#33b2df',
          '#546E7A',
          '#d4526e',
          '#13d8aa',
          '#A5978B',
          '#2b908f',
          '#f9a3a4',
          '#90ee7e',
          '#f48024',
          '#69d2e7'
        ],
        'dataLabels': {
          'enabled': true,
          'textAnchor': 'start',
          'style': {
            'colors': ['#fff']
          },
          // formatter: function (val, opt) {
          // return opt.w.globals.labels[opt.dataPointIndex] + ":  " + val
          // },
          'offsetX': 0,
          'dropShadow': {'enabled': true}
        },
        'stroke': {
          'width': 1,
          'colors': ['#fff']
        },
        'xaxis': {
          'categories': [
            'South Korea',
            'Canada',
            'United Kingdom',
            'Netherlands',
            'Italy',
            'France',
            'Japan',
            'United States',
            'China',
            'India'
          ],
        },
        'yaxis': {
          'labels': {'show': false}
        },
        'title': {
          'text': 'Custom DataLabels',
          'align': 'center',
          'floating': true
        },
        'subtitle': {
          'text': 'Category Names as DataLabels inside bars',
          'align': 'center',
        },
        'tooltip': {
          'theme': 'dark',
          'x': {'show': false},
          'y': {
            'title': {
              // formatter: function () {
              // return ''
              // }
            }
          }
        },
        'series': [
          {
            'data': [400, 430, 448, 470, 540, 580, 690, 1100, 1200, 1380]
          }
        ]
      },
    },
    // Template
    {
      'id': 'apexcharts-pattern-bar',
      'lib': 'apexcharts',
      'title': 'Bar Chart with Pattern Fill',
      'config': {
        'chart': {
          'type': 'bar',
          'height': 350,
          'stacked': true,
          'dropShadow': {'enabled': true, 'blur': 1, 'opacity': 0.25}
        },
        'plotOptions': {
          'bar': {
            'horizontal': true,
            'barHeight': '60%',
          },
        },
        'dataLabels': {'enabled': false},
        'stroke': {
          'width': 2,
        },
        'title': {'text': 'Compare Sales Strategy'},
        'xaxis': {
          'categories': [2008, 2009, 2010, 2011, 2012, 2013, 2014],
        },
        'yaxis': {
          'title': {'text': ''},
        },
        'tooltip': {
          'shared': false,
          'y': {
// formatter: function (val) {
// return val + "K"
// }
          }
        },
        'fill': {
          'type': 'pattern',
          'opacity': 1,
          'pattern': {
            'style': [
              'circles',
              'slantedLines',
              'verticalLines',
              'horizontalLines'
            ], // string or array of strings
          }
        },
        'states': {
          'hover': {'filter': 'none'}
        },
        'legend': {'position': 'right', 'offsetY': 40},
        'series': [
          {
            'name': 'Marine Sprite',
            'data': [44, 55, 41, 37, 22, 43, 21]
          },
          {
            'name': 'Striking Calf',
            'data': [53, 32, 33, 52, 13, 43, 32]
          },
          {
            'name': 'Tank Picture',
            'data': [12, 17, 11, 9, 15, 11, 20]
          },
          {
            'name': 'Bucket Slope',
            'data': [9, 7, 5, 8, 6, 9, 4]
          }
        ]
      },
    },
    // Template
    // {
    //   'id': 'apexcharts-aa-bar',
    //   'lib': 'apexcharts',
    //   'title': 'AA Bar Chart',
    //   'config': {
    //     // 'series':
    //   },
    // },
  ];

  static Map getTemplateById(String templateId) {
    return _templates.firstWhere(
      (element) => element['id'] == templateId,
      orElse: () => {},
    );
  }

  static Map getFirstTemplate() {
    return _templates.first;
  }

  static List<Map> getTemplatesByLibrary(String lib) {
    return _templates.where((element) => element['lib'] == lib).toList();
  }
}
