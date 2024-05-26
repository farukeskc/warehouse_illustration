import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAvAnflP9042yFnVM03vEjpO8vXeqIdpKg",
      projectId: "warehouse-illustration",
      messagingSenderId: "1000239838873",
      appId: "1:1000239838873:web:93baadce925d3c10a06a08",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warehouse Illustration',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
