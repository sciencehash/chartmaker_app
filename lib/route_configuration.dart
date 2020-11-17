import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'pages/redirection_page.dart';

import 'pages/root_page.dart';

import 'cubits/editor/editor_cubit.dart';
import 'cubits/app_chart/app_chart_cubit.dart';
import 'repositories/app_chart_repository_sembast.dart';
import 'pages/charts_page.dart';
import 'pages/engines_page.dart';
import 'pages/templates_page.dart';

import 'pages/chart_editor/chart_editor_page.dart';

import 'pages/settings_page.dart';
import 'pages/help_page.dart';
import 'pages/send_feedback_page.dart';
import 'pages/profile_page.dart';

class Path {
  /// A RegEx string for route matching.
  final String pattern;

  /// The builder for the associated pattern route. The first argument is the
  /// [BuildContext] and the second argument is a RegEx match if it is
  /// included inside of the pattern.
  final Widget Function(BuildContext, String) builder;

  const Path(this.pattern, this.builder);
}

class RouteConfiguration {
  /// List of [Path] to for route matching. When a named route is pushed with
  /// [Navigator.pushNamed], the route name is matched with the [Path.pattern]
  /// in the list below. As soon as there is a match, the associated builder
  /// will be returned. This means that the paths higher up in the list will
  /// take priority.
  static List<Path> paths = [
    //
    // -----------------------
    // --- Settings routes ---
    // -----------------------
    //
    Path(
      r'^' + SettingsPage.route,
      (context, match) => SettingsPage(),
    ),
    //
    // -------------------
    // --- Help routes ---
    // -------------------
    //
    Path(
      r'^' + HelpPage.route,
      (context, match) => HelpPage(),
    ),
    //
    // -----------------------
    // --- Feedback routes ---
    // -----------------------
    //
    Path(
      r'^' + SendFeedbackPage.route,
      (context, match) => SendFeedbackPage(),
    ),
    //
    // ---------------------------
    // --- User profile routes ---
    // ---------------------------
    //
    Path(
      r'^' + ProfilePage.route,
      (context, match) => ProfilePage(),
    ),
    //
    // --------------------------------------------
    // --- Libraries 'Library charts' routes ---
    // --------------------------------------------
    //
    Path(
      r'^' + LibraryChartsPage.baseRoute + r'/([\w-]+)$',
      (context, match) => BlocProvider<AppChartCubit>(
        create: (BuildContext context) => AppChartCubit(
          appChartRepository: AppChartRepositorySembast(),
        ),
        child: LibraryChartsPage(libraryId: int.tryParse(match)),
      ),
    ),
    //
    // ---------------------------
    // --- Engines page routes ---
    // ---------------------------
    //
    Path(
      r'^' + EnginesPage.route,
      (context, match) => EnginesPage(),
    ),
    //
    // ------------------------
    // --- Templates page route ---
    // ------------------------
    //
    Path(
      r'^' + TemplatesPage.baseRoute + r'/([\w-]+)$',
      (context, match) => TemplatesPage(
        lib: match,
      ),
    ), //
    // ------------------------
    // --- Chart Editor route ---
    // ------------------------
    //
    Path(
      r'^' + ChartEditor.baseRoute + r'/([\w-]+)$',
      (context, match) => MultiBlocProvider(
        providers: [
          BlocProvider<AppChartCubit>(
            create: (BuildContext context) => AppChartCubit(
              appChartRepository: AppChartRepositorySembast(),
            ),
          ),
          BlocProvider<EditorCubit>(
            create: (BuildContext context) => EditorCubit(
              appChartRepository: AppChartRepositorySembast(),
            ),
          ),
        ],
        child: ChartEditor(chartId: int.tryParse(match)),
      ),
    ),
    Path(
      r'^' + ChartEditor.baseRoute + r'/template/([\w-]+)$',
      (context, match) => MultiBlocProvider(
        providers: [
          BlocProvider<AppChartCubit>(
            create: (BuildContext context) => AppChartCubit(
              appChartRepository: AppChartRepositorySembast(),
            ),
          ),
          BlocProvider<EditorCubit>(
            create: (BuildContext context) => EditorCubit(
              templateId: match,
            ),
          ),
        ],
        child: ChartEditor(),
      ),
    ),
    Path(
      r'^' + ChartEditor.baseRoute,
      (context, match) => MultiBlocProvider(
        providers: [
          BlocProvider<AppChartCubit>(
            create: (BuildContext context) => AppChartCubit(
              appChartRepository: AppChartRepositorySembast(),
            ),
          ),
          BlocProvider<EditorCubit>(
            create: (BuildContext context) => EditorCubit(),
          ),
        ],
        child: ChartEditor(chartId: null),
      ),
    ),
    //
    // -------------------------------------------
    // --- Root page (Home) route ---
    // -------------------------------------------
    //
    Path(
      r'^' + RootPage.route,
      (context, match) => const RootPage(),
    ),
    //
    // --------------------------------------------------
    // ---  Error 404 page, to root page (Home) route ---
    // --------------------------------------------------
    //
    Path(
      r'^',
      (context, match) => const RootPage(),
    ),
  ];

  /// The route generator callback used when the app is navigated to a named
  /// route. Set it on the [MaterialApp.onGenerateRoute] or
  /// [WidgetsApp.onGenerateRoute] to make use of the [paths] for route
  /// matching.
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name)) {
        final RegExpMatch firstMatch = regExpPattern.firstMatch(settings.name);
        final String match =
            (firstMatch.groupCount == 1) ? firstMatch.group(1) : null;

        //
        return MaterialPageRoute<void>(builder: (context) {
          return path.builder(context, match);
        });
      }
    }

    // If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
    return null;
  }
}
