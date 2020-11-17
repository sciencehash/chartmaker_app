// import 'package:chartmaker_app/widgets/app/header_isotype.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:auth/auth.dart';
//
// class AuthScaffold extends StatefulWidget {
//   final Widget body;
//
//   AuthScaffold({
//     Key key,
//     @required this.body,
//   }) : super(key: key);
//
//   @override
//   _AuthScaffoldState createState() => _AuthScaffoldState();
// }
//
// class _AuthScaffoldState extends State<AuthScaffold> {
//   @override
//   Widget build(BuildContext context) {
//     //
//     Size screenSize = MediaQuery.of(context).size;
//
//     //
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         title: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Container(
//               width: 40,
//               child: HeaderIsotype(),
//             ),
//             // SizedBox(width: 10),
//             // Text(
//             //   'Chart Maker',
//             //   style: Theme.of(context).textTheme.headline6,
//             // ),
//           ],
//         ),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//         elevation: 0,
//       ),
//       body: Scrollbar(
//         child: Center(
//           child: Container(
//             width: 1000,
//             child: ListView(
//               children: [
//                 SizedBox(height: 0),
//                 // Body (IntrinsicHeight is needed for VerticalDivider)
//                 IntrinsicHeight(
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       // Left content
//                       if (screenSize.width > 850)
//                         Expanded(
//                           child: LeftImages(),
//                         ),
//                       // Vertical separator
//                       if (screenSize.width > 850)
//                         VerticalDivider(
//                           color: Color(0xff343A48),
//                           width: 50,
//                           thickness: 1,
//                         ),
//                       // Right content
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 30, horizontal: 15),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Intro Text 'Sensual Models is ...'
//                               IntroText(),
//                               // Spacer
//                               SizedBox(height: 20),
//                               // CTA Text 'Get FREE access now!'
//                               CTAText(),
//                               // Spacer
//                               SizedBox(height: 40),
//                               Text(
//                                 'Log in',
//                                 style: TextStyle(
//                                   fontSize: 27,
//                                 ),
//                               ),
//                               // Spacer
//                               SizedBox(height: 20),
//                               widget.body,
//                               // Spacer
//                               SizedBox(height: 27),
//                               // 'Secret between us' message
//                               RegisterMessage(),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class LeftImages extends StatelessWidget {
//   const LeftImages({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 50, horizontal: 15),
//       child: Image.asset('assets/images/sign-in-left-images.png'),
//       // child: Image.network(
//       //   '$storageUrl/assets/images/auth_left_images.png',
//       //   loadingBuilder: imageCircularLoadingBuilder,
//       // ),
//     );
//   }
// }
//
// class IntroText extends StatelessWidget {
//   const IntroText({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       'Chart Maker is a graphical interface that allows you to configure charts and insert them into a website.',
//       style: TextStyle(
//         fontSize: 18,
//         height: 1.5,
//         color: Colors.white,
//       ),
//     );
//   }
// }
//
// class CTAText extends StatelessWidget {
//   const CTAText({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return RichText(
//       text: TextSpan(
//         text: 'Get ',
//         style: TextStyle(
//           fontSize: 21,
//           height: 1.5,
//           color: Colors.white,
//         ),
//         children: <TextSpan>[
//           TextSpan(
//             text: 'FREE',
//             style: TextStyle(
//               color: Color(0xff4FE869),
//             ),
//           ),
//           TextSpan(text: ' access now!'),
//         ],
//       ),
//     );
//   }
// }
//
// class RegisterMessage extends StatelessWidget {
//   const RegisterMessage({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(17, 11, 17, 16),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(4),
//           border: Border.all(color: Color(0xff4FE869).withOpacity(.6))),
//       child: Row(
//         children: [
//           Icon(
//             Icons.group_add,
//             size: 39,
//             color: Color(0xff4FE869).withOpacity(.7),
//           ),
//           SizedBox(width: 18),
//           Expanded(
//             child: Text(
//               'Although it is much better to register and avoid losing your work ;)',
//               style: TextStyle(
//                 fontSize: 17,
//                 height: 1.4,
//                 color: Color(0xff4FE869).withOpacity(.7),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
