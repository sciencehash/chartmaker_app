final Map apexcharts_basic_bar = {
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
};