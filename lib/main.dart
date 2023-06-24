import 'package:famto_admin_app/firebase_options.dart';
import 'package:famto_admin_app/views/delivery_person_registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'views/create_task_screen.dart';
import 'views/delivery_person_dashboard.dart';
import 'views/home_screen.dart';
import 'views/login_screen.dart';
import 'views/login_with_phone_number.dart';
import 'views/map_view_agent_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    title: 'Famto Admin App',
    home: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginWithPhone()),
              );
            },
            child: Text('Welcome Admin')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateTask()),
          );
        },
        child: const Icon(Icons.login),
      ),
    );
  }
}
