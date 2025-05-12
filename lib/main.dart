import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_preview/device_preview.dart';
import 'package:studentlist_firebase/firebase_options.dart';
import 'package:studentlist_firebase/screens/home_screen.dart';
import 'package:studentlist_firebase/providers/student_provider.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StudentProvider()),
      ],
      child: DevicePreview(
        enabled: !kReleaseMode,
        builder: (context) => const MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}