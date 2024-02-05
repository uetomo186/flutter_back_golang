import 'package:flutter/material.dart';
import 'package:flutter_back_golang/pages/top_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  final String anonKey = dotenv.env['SUPABASE_ANON'] ?? '';
  final String projectUrl = dotenv.env['SUPABASE_URL'] ?? '';

  await Supabase.initialize(
    anonKey: anonKey,
    url: projectUrl,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final String? token = dotenv.env['SUPABASE_ANON'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TopPage(),
    );
  }
}
