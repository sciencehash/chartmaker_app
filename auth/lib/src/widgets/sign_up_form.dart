import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/authentication/authentication_cubit.dart';
import '../blocs/sign_up_form/sign_up_form_bloc.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key key,
    @required TextEditingController nameController,
    @required TextEditingController emailController,
    @required TextEditingController passwordController,
    @required Widget child,
  })  : _nameController = nameController,
        _emailController = emailController,
        _passwordController = passwordController,
        _child = child,
        super(key: key);

  final TextEditingController _nameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final Widget _child;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  SignUpFormBloc _signUpBloc;

  // temp
  Function t;

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpFormBloc>(context);
    widget._nameController.addListener(_onNameChanged);
    widget._emailController.addListener(_onEmailChanged);
    widget._passwordController.addListener(_onPasswordChanged);

    // t = widget.t;
    // temp
    t = (text) => text;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpFormBloc, SignUpFormState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(t('Registering...')),
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
                    Text(t('Registration Failure'), style: TextStyle(color: Colors.white)),
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

  void _onNameChanged() {
    _signUpBloc.add(
      SignUpFormNameChanged(name: widget._nameController.text),
    );
  }

  void _onEmailChanged() {
    _signUpBloc.add(
      SignUpFormEmailChanged(email: widget._emailController.text),
    );
  }

  void _onPasswordChanged() {
    _signUpBloc.add(
      SignUpFormPasswordChanged(password: widget._passwordController.text),
    );
  }
}
