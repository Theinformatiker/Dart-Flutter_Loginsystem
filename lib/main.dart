import 'package:flutter/material.dart';

import 'core/services/database_service.dart';
import 'widgets/login/login.dart';
import 'widgets/page/home_page.dart';
import 'widgets/regist/registation.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    print('Initializing application...');
    await DatabaseService.connect();
    print('Database connection established');
  } catch (e) {
    print('Database initialization error: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/regist': (context) => RegistrationPage(),
        '/home': (context) => HomePage(),
      },
      //home: LoginPage(),
    );
  }
}
