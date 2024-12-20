// import 'package:flutter/material.dart';
// import '../services/auth_service.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   _RegisterPageState createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final AuthService _authService = AuthService();
//   String? _errorMessage;

//   Future<void> _handleRegister() async {
//     final username = _usernameController.text.trim();
//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     try {
//       await _authService.register(username, email, password);
//       if(mounted){
//         Navigator.pop(context);
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Registration failed: ${e.toString()}";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24.0),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 const Text(
//                   'Create an Account',
//                   style: TextStyle(
//                     fontSize: 28.0,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.blueAccent,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 20.0),
//                 if (_errorMessage != null)
//                   Text(
//                     _errorMessage!,
//                     style: const TextStyle(color: Colors.red, fontSize: 14.0),
//                     textAlign: TextAlign.center,
//                   ),
//                 const SizedBox(height: 10.0),
//                 TextField(
//                   controller: _usernameController,
//                   decoration: InputDecoration(
//                     labelText: 'Username',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 ElevatedButton(
//                   onPressed: _handleRegister,
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 14.0),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                   child: const Text(
//                     'Register',
//                     style: TextStyle(fontSize: 16.0),
//                   ),
//                 ),
//                 const SizedBox(height: 12.0),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context); // Navigate back to login page
//                   },
//                   child: const Text(
//                     "Already have an account? Login here",
//                     style: TextStyle(fontSize: 14.0, color: Colors.blueAccent),
//                     textAlign: TextAlign.center,
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
