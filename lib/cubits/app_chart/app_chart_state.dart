part of 'app_chart_cubit.dart';

abstract class AppChartState extends Equatable {
  const AppChartState();
}

class AppChartInitial extends AppChartState {
  @override
  List<Object> get props => [];
}

class AppChartsLoaded extends AppChartState {
  final String libraryId;
  final List<AppChart> appCharts;

  const AppChartsLoaded({
    this.libraryId,
    this.appCharts,
  });

  @override
  List<Object> get props => [appCharts, libraryId];

  @override
  bool get stringify => true;
}

class AppChartLoaded extends AppChartState {
  final AppChart appChart;

  const AppChartLoaded([this.appChart]);

  @override
  List<Object> get props => [appChart];

  @override
  bool get stringify => true;
}
