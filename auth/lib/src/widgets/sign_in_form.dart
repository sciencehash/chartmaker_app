import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/authentication/authentication_cubit.dart';
import '../blocs/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key key,
    @required TextEditingController emailController,
    @required TextEditingController passwordController,
    @required Widget child,
  })  : _emailController = emailController,
        _passwordController = passwordController,
        _child = child,
        super(key: key);

  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final Widget _child;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  SignInFormBloc _signUpBloc;

  // temp
  Function t;

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignInFormBloc>(context);
    widget._emailController.addListener(_onEmailChanged);
    widget._passwordController.addListener(_onPasswordChanged);

    // t = widget.t;
    // temp
    t = (text) => text;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(t('Logging In...')),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationCubit>(context).signIn();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(t('Login Failure'), style: TextStyle(color: Colors.white)),
                    Icon(Icons.error, color: Colors.white),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: widget._child,
    );
  }

  @override
  void dispose() {
    // widget._emailController.dispose();
    // widget._passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _signUpBloc.add(
      SignInFormEmailChanged(email: widget._emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signUpBloc.add(
      SignInFormPasswordChanged(password: widget._passwordController.text),
    );
  }
}
