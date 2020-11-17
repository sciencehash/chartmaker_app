// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:auth/auth.dart';
//
// class CustomSignInForm extends StatefulWidget {
//   const CustomSignInForm({
//     Key key,
//     this.onTapToSignUpForm,
//   }) : super(key: key);
//
//   final Function onTapToSignUpForm;
//
//   @override
//   _CustomSignInFormState createState() => _CustomSignInFormState();
// }
//
// final TextEditingController _emailController = TextEditingController();
// final TextEditingController _passwordController = TextEditingController();
//
// class _CustomSignInFormState extends State<CustomSignInForm> {
//   bool obscurePasswordText = true;
//
//   bool get isPopulated =>
//       _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;
//
//   bool isSignInButtonEnabled(SignInFormState state) {
//     return state.isFormValid && isPopulated && !state.isSubmitting;
//   }
//
//   void _onFormSubmitted() {
//     context.bloc<SignInFormBloc>().add(
//           SignInFormWithCredentialsPressed(
//             email: _emailController.text.trim(),
//             password: _passwordController.text.trim(),
//           ),
//         );
//     _emailController.text = "";
//     _passwordController.text = "";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // temp
//     final Function t = (text) => text;
//
//     return SignInForm(
//       emailController: _emailController,
//       passwordController: _passwordController,
//       child: BlocBuilder<SignInFormBloc, SignInFormState>(
//         builder: (context, state) {
//           return Container(
//             // padding: EdgeInsets.all(20),
//             child: Form(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.email),
//                       labelText: t('Email'),
//                       border: OutlineInputBorder(),
//                     ),
//                     autocorrect: false,
//                     autovalidate: true,
//                     validator: (_) {
//                       return !state.isEmailValid ? t('Invalid Email') : null;
//                     },
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   // Spacer
//                   SizedBox(height: 30),
//                   TextFormField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.lock),
//                       suffixIcon: Padding(
//                         padding: const EdgeInsets.only(right: 4),
//                         child: FloatingActionButton(
//                           child: Icon(obscurePasswordText
//                               ? Icons.visibility_off
//                               : Icons.visibility),
//                           mini: true,
//                           backgroundColor: Colors.transparent,
//                           elevation: 0,
//                           onPressed: () {
//                             setState(() {
//                               obscurePasswordText = !obscurePasswordText;
//                             });
//                           },
//                         ),
//                       ),
//                       labelText: t('Password'),
//                       border: OutlineInputBorder(),
//                       errorMaxLines: 3,
//                     ),
//                     obscureText: obscurePasswordText,
//                     autocorrect: false,
//                     autovalidate: true,
//                     validator: (_) {
//                       return !state.isPasswordValid
//                           ? t('You need 8 characters: uppercase and lowercase letters, numbers and symbols.')
//                           : null;
//                     },
//                     keyboardType: TextInputType.visiblePassword,
//                   ),
//                   // Spacer
//                   SizedBox(height: 30),
//                   // Log in button and 'Create account' row
//                   Row(
//                     children: [
//                       // Log in button
//                       SignInButton(
//                         onPressed: (state.isFormValid &&
//                                 isPopulated &&
//                                 !state.isSubmitting)
//                             ? _onFormSubmitted
//                             : null,
//                         onLongPress: kDebugMode
//                             ? () {
//                                 _emailController.text = 'user@example.com';
//                                 _passwordController.text = '1234A5#6d';
//                                 _onFormSubmitted();
//                               }
//                             : null,
//                       ),
//                       // Spacer
//                       SizedBox(width: 40),
//                       // Link to Create new account
//                       SignUpFormLink(onTap: widget.onTapToSignUpForm),
//                       // Spacer
//                       SizedBox(width: 10),
//                     ],
//                   ),
//
//                   // Spacer
//                   SizedBox(height: 25),
//                   // 'or' horizontal divider
//                   OrDivider(),
//                   // Spacer
//                   SizedBox(height: 10),
//                   // Social Log in buttons
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Row(
//                       mainAxisSize: MainAxisSize.max,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         LogInWithSocialButton(
//                             socialNetwork: 'google',
//                             onPressed: () {
//                               context.bloc<SignInFormBloc>().add(
//                                     SignInFormWithGooglePressed(),
//                                   );
//                             }),
//                         SizedBox(width: 10),
//                         LogInWithSocialButton(socialNetwork: 'twitter'),
//                         SizedBox(width: 10),
//                         LogInWithSocialButton(socialNetwork: 'facebook'),
//                       ],
//                     ),
//                   ),
//                   // Spacer
//                   SizedBox(height: 30),
//                   // Anonymous access
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Just want to try? You can also log in as a demo user:',
//                           style: TextStyle(
//                             fontSize: 18,
//                             height: 1.5,
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 20),
//                       OutlineButton(
//                         child: Text('Demo Log In'),
//                         onPressed: () {
//                           // context.bloc<SignInFormBloc>().add(
//                           //       SignInFormAnonymouslyPressed(),
//                           //     );
//                           context.bloc<SignInFormBloc>().add(
//                                 SignInFormWithCredentialsPressed(
//                                   email: 'demo@example.com',
//                                   password: '1234A5#6d',
//                                 ),
//                               );
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class SignInButton extends StatelessWidget {
//   const SignInButton({
//     Key key,
//     VoidCallback onPressed,
//     VoidCallback onLongPress,
//   })  : _onPressed = onPressed,
//         _onLongPress = onLongPress,
//         super(key: key);
//
//   final VoidCallback _onPressed;
//   final VoidCallback _onLongPress;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         height: 48,
//         child: RaisedButton(
//           padding: const EdgeInsets.all(0),
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
//           child: Ink(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xff41AF54), Color(0xff369846)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Container(
//               // constraints: BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
//               padding: EdgeInsets.only(bottom: 5),
//               alignment: Alignment.center,
//               child: Text(
//                 "Log in",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.white, fontSize: 20),
//               ),
//             ),
//           ),
//           onPressed: _onPressed,
//           onLongPress: _onLongPress,
//         ),
//       ),
//     );
//   }
// }
//
// class SignUpFormLink extends StatelessWidget {
//   const SignUpFormLink({
//     Key key,
//     this.onTap,
//   }) : super(key: key);
//
//   final Function onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       child: Text(
//         'Create a new account',
//         style: TextStyle(
//           fontSize: 18,
//           decoration: TextDecoration.underline,
//         ),
//       ),
//       onTap: onTap,
//     );
//   }
// }
//
// class OrDivider extends StatelessWidget {
//   const OrDivider({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(child: Divider(color: Color(0xff404757), thickness: .8)),
//         Padding(
//           padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
//           child: Text('or',
//               style: TextStyle(color: Color(0xff404757), fontSize: 22)),
//         ),
//         Expanded(child: Divider(color: Color(0xff404757), thickness: .8)),
//       ],
//     );
//   }
// }
//
// class LogInWithSocialButton extends StatelessWidget {
//   const LogInWithSocialButton({
//     Key key,
//     this.socialNetwork = 'google',
//     this.onPressed,
//   }) : super(key: key);
//
//   final String socialNetwork;
//   final Function onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton.icon(
//       icon: Image.asset(
//         'assets/images/${socialNetwork}_logo.png',
//         height: 25,
//         fit: BoxFit.fitHeight,
//       ),
//       label: Padding(
//         padding: const EdgeInsets.only(left: 7, right: 1),
//         child: Text(
//           'Log in',
//           style: TextStyle(
//             fontSize: 18,
//             color: socialNetwork == 'facebook'
//                 ? Color(0xff3B5998)
//                 : socialNetwork == 'twitter'
//                     ? Color(0xff1A91D9)
//                     : Color(0xff4285F4),
//           ),
//         ),
//       ),
//       color: Colors.white,
//       colorBrightness: Brightness.light,
//       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
//       // 19 32
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//       onPressed: onPressed,
//     );
//   }
// }
