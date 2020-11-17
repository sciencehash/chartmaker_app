// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:auth/auth.dart';
//
// import 'sign_in_page.dart';
// // import '../../widgets/app/primary_scaffold.dart';
// import '../../widgets/app/page_title.dart';
// import '../../widgets/auth_page/custom_sign_up_form.dart';
//
// class SignUpPage extends StatelessWidget {
//   static const String route = '/signup';
//
//   const SignUpPage({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     //
//     final AuthenticationCubit authenticationCubit = context.bloc<AuthenticationCubit>();
//     //
//     final AuthRepository authRepository = (authenticationCubit.state as Unauthenticated).authRepository;
//
//     //
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(20),
//         child: ListView(
//           children: [
//             Center(
//               child: Container(
//                 width: 700,
//                 child: PageTitle(title: 'Create a new account'),
//               ),
//             ),
//             BlocProvider<SignUpFormBloc>(
//               create: (context) => SignUpFormBloc(
//                 authRepository: authRepository,
//               ),
//               child: Center(
//                 child: Container(
//                   width: 700,
//                   child: CustomSignUpForm(onTapToSignInForm: () {
//                     Navigator.pushNamed(context, SignInPage.route);
//                   }),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
