import 'dart:async';
import 'package:meta/meta.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/app_chart.dart';
import 'app_chart_repository.dart';

class AppChartRepositoryFirebase extends AppChartRepository {
  final appChartsCollection = FirebaseFirestore.instance.collection('charts');

  //
  Future<void> addNew(AppChart appChart) async {
    appChartsCollection.add(appChart.toDocument());
  }

  //
  Future<void> update(AppChart appChart) async {
    appChartsCollection
        .doc(appChart.id)
        .update(appChart.toDocument());
  }

  //
  Future<void> delete(AppChart appChart) async {
    appChartsCollection.doc(appChart.id).delete();
  }

  //
  Stream<List<AppChart>> charts({
    @required String userId,
    @required String libraryId,
  }) {
    return appChartsCollection
        .where('userId', isEqualTo: userId)
        .where('libraryId', isEqualTo: libraryId)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (docSnapshot) => AppChart.fromSnapshot(docSnapshot),
              )
              .toList(),
        );
  }

  //
  Stream<AppChart> chart({
    @required String userId,
    @required String chartId,
  }) {
    return appChartsCollection.doc(chartId).snapshots().map(
          (snapshot) => AppChart.fromSnapshot(snapshot),
        );
  }
}
