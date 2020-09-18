import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';

import 'route_configuration.dart';
import 'themes/dark.dart';
import 'pages/root_page.dart';
// import 'blocs/bloc_observer.dart';

// import 'cubits/local_storage/local_storage_cubit.dart';

import 'cubits/user/user_cubit.dart';
import 'repositories/user_repository_firebase.dart';

import 'cubits/app_library/app_library_cubit.dart';
import 'repositories/app_library_repository_firebase.dart';

void main() {
//  Bloc.observer = AppBlocObserver();

  //
  final AuthRepository authRepository = FirebaseAuthRepository();

  runApp(
    App(authRepository: authRepository),
  );
}

class App extends StatelessWidget {
  const App({Key key, @required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(key: key);

  final AuthRepository _authRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //
    // LocalStorageCubit localStorageCubit = LocalStorageCubit();
    // localStorageCubit.loadLocalStorage(dbName: 'chartmaker');
    //
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(
            authRepository: _authRepository,
          )..loadAppAuth(),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(
            userRepository: UserRepositoryFirebase(),
          ),
        ),
        // BlocProvider<LocalStorageCubit>(
        //   create: (context) => localStorageCubit,
        // ),
        BlocProvider<AppLibraryCubit>(
          create: (context) => AppLibraryCubit(
            appLibraryRepository: AppLibraryRepositoryFirebase(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Chart Maker',
        theme: DarkTheme.themeData,
        // initialRoute: RootPage.route,
        onGenerateRoute: RouteConfiguration.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}