import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'route_configuration.dart';
import 'themes/dark.dart';

import 'cubits/user/user_cubit.dart';
import 'repositories/user_repository_sembast.dart';

import 'cubits/app_library/app_library_cubit.dart';
import 'repositories/app_library_repository_sembast.dart';

// import 'blocs/bloc_observer.dart';

void main() {
  //  Bloc.observer = AppBlocObserver();

  runApp(
    App(),
  );
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(
            userRepository: UserRepositorySembast(),
          ),
        ),
        BlocProvider<AppLibraryCubit>(
          create: (context) => AppLibraryCubit(
            appLibraryRepository: AppLibraryRepositorySembast(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Chart Maker',
        theme: DarkTheme.themeData,
        onGenerateRoute: RouteConfiguration.onGenerateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
