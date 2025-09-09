// import 'package:flutter/material.dart';

// class Responsive extends StatelessWidget{
//   final Widget mobile;
//   final Widget tablet;
//   final Widget desktop;

//   const Responsive({
//     super.key,
//     required this.mobile,
//     required this.tablet,
//     required this.desktop,
//   });

//   static bool isMobile(BuildContext context) =>
//       MediaQuery.of(context).size.width < 650;

//   static bool isTablet(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 650 &&
//       MediaQuery.of(context).size.width < 1100;

//   static bool isDesktop(BuildContext context) =>
//       MediaQuery.of(context).size.width >= 1100;

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if (constraints.maxWidth >= 1100) {
//           return desktop;
//         } else if (constraints.maxWidth >= 650) {
//           return tablet;
//         } else {
//           return mobile;
//         }
//       },
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:ziya_attendence_app/constants/text_constants.dart';
// import 'package:ziya_attendence_app/views/responsive.dart';
// // <-- import your Responsive class

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Responsive(
//         // 📱 Mobile View
//         mobile: _buildMobileLogin(),

//         // 💻 Tablet View
//         tablet: _buildTabletLogin(),

//         // 🖥️ Desktop View
//         desktop: _buildDesktopLogin(),
//       ),
//     );
//   }

//   /// MOBILE UI
//   Widget _buildMobileLogin() {
//     return Center(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const Text("Login - Mobile", style: TextStyle(fontSize: 24)),
//               const SizedBox(height: 20),
//               const TextField(decoration: InputDecoration(labelText: "Email")),
//               const SizedBox(height: 10),
//               const TextField(
//                 decoration: InputDecoration(labelText: "Password"),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton(onPressed: () {}, child: const Text("Login")),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// TABLET UI
//   Widget _buildTabletLogin() {
//     return Row(
//       children: [
//         Expanded(
//           flex: 3,

//           child: Container(
//             color: Colors.blueGrey.shade100,
//             child: const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircleAvatar(radius: 40, backgroundColor: Colors.blue,backgroundImage: AssetImage(TextConstants.ziyalogoImageUrl),),
//                   Text("Welcome Back!", style: TextStyle(fontSize: 32)),
//                 ],
//               ),
//             ),
//           ),
//         ), // Left panel
//         Expanded(
//           flex: 2,
//           child: _buildMobileLogin(), // Reuse mobile form (centered)
//         ),
//       ],
//     );
//   }

//   /// DESKTOP UI
//   Widget _buildDesktopLogin() {
//     return Row(
//       children: [
//         Expanded(
//           flex: 3,
//           child: Container(
//             color: Colors.blueGrey.shade200,
//             child: const Center(
//               child: Text("Welcome Back!", style: TextStyle(fontSize: 32)),
//             ),
//           ),
//         ),
//         Expanded(
//           flex: 2,
//           child: _buildMobileLogin(), // reuse same login form
//         ),
//       ],
//     );
//   }
// }
