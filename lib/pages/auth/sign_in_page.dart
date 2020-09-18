import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';

import 'sign_up_page.dart';
import '../../widgets/app/page_title.dart';
import '../../widgets/auth_page/custom_sign_in_form.dart';

class SignInPage extends StatelessWidget {
  static const String route = '/signin';

  const SignInPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final AuthenticationCubit authenticationCubit =
        context.bloc<AuthenticationCubit>();
    //
    final AuthRepository authRepository =
        (authenticationCubit.state as Unauthenticated).authRepository;

    //
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: Container(
                width: 700,
                child: PageTitle(title: 'SignIn'),
              ),
            ),
            BlocProvider<SignInFormBloc>(
              create: (context) => SignInFormBloc(
                authRepository: authRepository,
              ),
              child: Center(
                child: Container(
                  width: 700,
                  child: CustomSignInForm(
                    onTapToSignUpForm: () {
                      Navigator.pushNamed(context, SignUpPage.route);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
