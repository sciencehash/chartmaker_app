import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth/auth.dart';

class CustomSignInForm extends StatefulWidget {
  const CustomSignInForm({
    Key key,
    this.onTapToSignUpForm,
  }) : super(key: key);

  final Function onTapToSignUpForm;

  @override
  _CustomSignInFormState createState() => _CustomSignInFormState();
}

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

class _CustomSignInFormState extends State<CustomSignInForm> {
  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isSignInButtonEnabled(SignInFormState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  void _onFormSubmitted() {
    context.bloc<SignInFormBloc>().add(
          SignInFormWithCredentialsPressed(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    // temp
    final Function t = (text) => text;

    return SignInForm(
      emailController: _emailController,
      passwordController: _passwordController,
      child: BlocBuilder<SignInFormBloc, SignInFormState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                      child: Text('Google'),
                      onPressed: () {
                        context.bloc<SignInFormBloc>().add(
                              SignInFormWithGooglePressed(),
                            );
                      }),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: t('Email'),
                      border: OutlineInputBorder(),
                    ),
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isEmailValid ? t('Invalid Email') : null;
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  // Spacer
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: Icon(Icons.visibility_off),
                      labelText: t('Password'),
                      border: OutlineInputBorder(),
                      errorMaxLines: 3,
                    ),
                    obscureText: true,
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isPasswordValid
                          ? t('You need 8 characters: uppercase and lowercase letters, numbers and symbols.')
                          : null;
                    },
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  // Spacer
                  SizedBox(height: 30),
                  // TEMP
                  if (kDebugMode)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        child: Text('Mock Sign in'),
                        onPressed: () {
                          _emailController.text = 'user@example.com';
                          _passwordController.text = '1234A5#6d';
                          _onFormSubmitted();
                        },
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      child: Text('Anonymous Sign in'),
                      onPressed: () {
                        context.bloc<SignInFormBloc>().add(
                          SignInFormAnonymouslyPressed(),
                        );
                      },
                    ),
                  ),
                  // Log in button and 'Create account' row
                  Row(
                    children: [
                      // Log in button
                      SignInButton(
                        onPressed: (state.isFormValid && isPopulated && !state.isSubmitting)
                            ? _onFormSubmitted
                            : null,
                      ),
                      // Spacer
                      SizedBox(width: 40),
                      // Link to Create new account
                      SignUpFormLink(onTap: widget.onTapToSignUpForm),
                      // Spacer
                      SizedBox(width: 10),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SignInButton extends StatelessWidget {
  const SignInButton({
    Key key,
    VoidCallback onPressed,
  })  : _onPressed = onPressed,
        super(key: key);

  final VoidCallback _onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 48,
        child: RaisedButton(
          padding: const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff41AF54), Color(0xff369846)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Container(
              // constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
              padding: EdgeInsets.only(bottom: 5),
              alignment: Alignment.center,
              child: Text(
                "Log in",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),
          onPressed: _onPressed,
        ),
      ),
    );
  }
}

class SignUpFormLink extends StatelessWidget {
  const SignUpFormLink({
    Key key,
    this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(
        'Create a new account',
        style: TextStyle(
          fontSize: 19,
          decoration: TextDecoration.underline,
        ),
      ),
      onTap: onTap,
    );
  }
}
