// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:auth/auth.dart';
//
// import 'sign_up_page.dart';
// import '../../widgets/auth_page/auth_scaffold.dart';
// import '../../widgets/app/page_title.dart';
// import '../../widgets/auth_page/custom_sign_in_form.dart';
//
// class SignInPage extends StatelessWidget {
//   static const String route = '/signin';
//
//   const SignInPage({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     //
//     final AuthenticationCubit authenticationCubit =
//         context.bloc<AuthenticationCubit>();
//     //
//     final AuthRepository authRepository =
//         (authenticationCubit.state as Unauthenticated).authRepository;
//
//     //
//     return AuthScaffold(
//       body: Container(
//         // padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             BlocProvider<SignInFormBloc>(
//               create: (context) => SignInFormBloc(
//                 authRepository: authRepository,
//               ),
//               child: Center(
//                 child: Container(
//                   child: CustomSignInForm(
//                     onTapToSignUpForm: () {
//                       Navigator.pushNamed(context, SignUpPage.route);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
