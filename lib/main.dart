import 'package:flutter/material.dart';
import 'package:vp12_api_app/screens/auth/forget_password_screen.dart';
import 'package:vp12_api_app/screens/images/images_screen.dart';
import 'package:vp12_api_app/screens/images/upload_image_screen.dart';
import 'package:vp12_api_app/screens/launch_screen.dart';
import 'package:vp12_api_app/screens/auth/login_screen.dart';
import 'package:vp12_api_app/screens/auth/register_screen.dart';
import 'package:vp12_api_app/screens/users_screen.dart';
import 'package:vp12_api_app/storage/shared_pref_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => const LaunchScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/register_screen': (context) => const RegisterScreen(),
        '/users_screen': (context) => const UsersScreen(),
        '/forget_password_screen': (context) => const ForgetPasswordScreen(),
        '/images_screen': (context) => const ImagesScreen(),
        '/upload_image_screen': (context) => const UploadImageScreen(),
      },
    );
  }
}
