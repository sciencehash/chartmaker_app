// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:auth/auth.dart';
//
// class CustomSignUpForm extends StatefulWidget {
//   const CustomSignUpForm({
//     Key key,
//     this.onTapToSignInForm,
//   }) : super(key: key);
//
//   final Function onTapToSignInForm;
//
//   @override
//   _CustomSignUpFormState createState() => _CustomSignUpFormState();
// }
//
// final TextEditingController _nameController = TextEditingController();
// final TextEditingController _emailController = TextEditingController();
// final TextEditingController _passwordController = TextEditingController();
//
// class _CustomSignUpFormState extends State<CustomSignUpForm> {
//   bool obscurePasswordText = true;
//
//   bool get isPopulated =>
//       _nameController.text.isNotEmpty &&
//       _emailController.text.isNotEmpty &&
//       _passwordController.text.isNotEmpty;
//
//   bool isSignUpButtonEnabled(SignUpFormState state) {
//     return state.isFormValid && isPopulated && !state.isSubmitting;
//   }
//
//   void _onFormSubmitted() {
//     context.bloc<SignUpFormBloc>().add(
//           SignUpFormSubmitted(
//             name: _nameController.text.trim(),
//             email: _emailController.text.trim(),
//             password: _passwordController.text.trim(),
//           ),
//         );
//     _nameController.text = "";
//     _emailController.text = "";
//     _passwordController.text = "";
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // temp
//     final Function t = (text) => text;
//
//     return SignUpForm(
//       nameController: _nameController,
//       emailController: _emailController,
//       passwordController: _passwordController,
//       child: BlocBuilder<SignUpFormBloc, SignUpFormState>(
//         builder: (context, state) {
//           return Padding(
//             padding: EdgeInsets.symmetric(
//               vertical: 20,
//               horizontal: 0,
//             ),
//             child: Form(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   TextFormField(
//                     controller: _nameController,
//                     decoration: InputDecoration(
//                       prefixIcon: Icon(Icons.note),
//                       labelText: t('Name'),
//                       border: OutlineInputBorder(),
//                     ),
//                     autocorrect: false,
//                     autovalidate: true,
//                     validator: (_) {
//                       return !state.isEmailValid ? t('Invalid Name') : null;
//                     },
//                     keyboardType: TextInputType.text,
//                   ),
//                   // Spacer
//                   SizedBox(height: 30),
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
//                       SignUpButton(
//                         onPressed: (state.isFormValid &&
//                                 isPopulated &&
//                                 !state.isSubmitting)
//                             ? _onFormSubmitted
//                             : null,
//                       ),
//                       // Spacer
//                       SizedBox(width: 40),
//                       // Link to Create new account
//                       SignInFormLink(onTap: widget.onTapToSignInForm),
//                       // Spacer
//                       SizedBox(width: 10),
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
// class SignUpButton extends StatelessWidget {
//   const SignUpButton({
//     Key key,
//     VoidCallback onPressed,
//   })  : _onPressed = onPressed,
//         super(key: key);
//
//   final VoidCallback _onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         height: 48,
//         child: RaisedButton(
//           padding: const EdgeInsets.all(0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
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
//               padding: EdgeInsets.only(bottom: 5),
//               alignment: Alignment.center,
//               child: Text(
//                 "Sign up",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.white, fontSize: 22),
//               ),
//             ),
//           ),
//           onPressed: _onPressed,
//         ),
//       ),
//     );
//   }
// }
//
// class SignInFormLink extends StatelessWidget {
//   const SignInFormLink({
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
//         'Have an account?',
//         style: TextStyle(
//           fontSize: 19,
//           decoration: TextDecoration.underline,
//         ),
//       ),
//       onTap: onTap,
//     );
//   }
// }
