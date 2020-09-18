import 'package:chartmaker_app/cubits/app_library/app_library_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';

import 'pages/redirection_page.dart';
import 'pages/auth/sign_in_page.dart';
import 'pages/auth/sign_up_page.dart';

import 'pages/root_page.dart';

import 'cubits/editor/editor_cubit.dart';
import 'repositories/chart_template_repository.dart';
import 'cubits/app_document/app_document_cubit.dart';
import 'repositories/app_document_repository_firebase.dart';
import 'pages/libraries/documents_page.dart';

import 'pages/editor.dart';

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
    // -------------------
    // --- Auth routes ---
    // -------------------
    //
    Path(
      r'^' + SignInPage.route,
      (context, match) => SignInPage(),
    ),
    Path(
      r'^' + SignUpPage.route,
      (context, match) => SignUpPage(),
    ),
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
    // --- Libraries 'Library documents' routes ---
    // --------------------------------------------
    //
    Path(
      r'^' + LibraryDocumentsPage.baseRoute + r'/([\w-]+)$',
      (context, match) => BlocProvider<AppDocumentCubit>(
        create: (BuildContext context) => AppDocumentCubit(
          appDocumentRepository: AppDocumentRepositoryFirebase(),
        ),
        child: LibraryDocumentsPage(libraryId: match),
      ),
    ),
    //
    // ------------------------
    // --- Chart Editor route ---
    // ------------------------
    //
    Path(
      r'^' + ChartEditor.baseRoute + r'/([\w-]+)$',
      (context, match) => MultiBlocProvider(
        providers: [
          BlocProvider<AppDocumentCubit>(
            create: (BuildContext context) => AppDocumentCubit(
              appDocumentRepository: AppDocumentRepositoryFirebase(),
            ),
          ),
          BlocProvider<EditorCubit>(
            create: (BuildContext context) => EditorCubit(
              chartTemplateRepository: ChartTemplateRepository(),
            ),
          ),
        ],
        child: ChartEditor(documentId: match),
      ),
    ),
    Path(
      r'^' + ChartEditor.baseRoute,
      (context, match) => MultiBlocProvider(
        providers: [
          BlocProvider<AppDocumentCubit>(
            create: (BuildContext context) => AppDocumentCubit(
              appDocumentRepository: AppDocumentRepositoryFirebase(),
            ),
          ),
          BlocProvider<EditorCubit>(
            create: (BuildContext context) => EditorCubit(
              chartTemplateRepository: ChartTemplateRepository(),
            ),
          ),
        ],
        child: ChartEditor(documentId: null),
      ),
    ),
    //
    // -------------------------------------------
    // --- Root page (Home) route ---
    // -------------------------------------------
    //
    Path(
      r'^' + RootPage.route,
      (context, match) => RootPage(),
    ),
    //
    // --------------------------------------------------
    // ---  Error 404 page, to root page (Home) route ---
    // --------------------------------------------------
    //
    Path(
      r'^',
      (context, match) => RootPage(),
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
        return MaterialPageRoute<void>(
          builder: (context) {
            return BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                //
                final List<String> unauthenticatedRoutes = [
                  SignInPage.route,
                  SignUpPage.route
                ];

                //
                if (settings.name == '/signout') {
                  // Close AppLibrary subscription
                  context.bloc<AppLibraryCubit>().close();
                  // Sign out
                  context.bloc<AuthenticationCubit>().signOut();
                  // Redirect to Sign in page
                  return RedirectionPage(
                    routeName: SignInPage.route,
                    clearHistory: true,
                  );
                } else if (state is Unauthenticated &&
                    !unauthenticatedRoutes.contains(settings.name)) {
                  // Redirect to Sign in page
                  return RedirectionPage(
                    routeName: SignInPage.route,
                    clearHistory: true,
                  );
                } else if (state is Unauthenticated &&
                    unauthenticatedRoutes.contains(settings.name)) {
                  // Auth pages
                  return path.builder(context, match);
                } else if (state is Authenticated &&
                    unauthenticatedRoutes.contains(settings.name)) {
                  // Redirect to root page
                  return RedirectionPage(
                    routeName: RootPage.route,
                    clearHistory: true,
                  );
                } else if (state is Authenticated &&
                    state.user != null &&
                    !unauthenticatedRoutes.contains(settings.name)) {
                  // Authenticated pages
                  return path.builder(context, match);
                } else {
                  // Processing page
                  return Scaffold(
                    body: Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  );
                }
              },
            );
          },
          settings: settings,
        );
      }
    }

    // If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
    return null;
  }
}