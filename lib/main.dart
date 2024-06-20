// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nossos_pontos/firebase_options.dart';
import 'package:nossos_pontos/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// static Future<FirebaseApp> initializeApp({
//   String? name,
//   FirebaseOptions? options,
//   String? demoProjectId,
// }) async {
//   if (demoProjectId != null) {
//     late final String platformString;
//     if (defaultTargetPlatform == TargetPlatform.android) {
//       platformString = 'android';
//     } else if (defaultTargetPlatform == TargetPlatform.iOS ||
//         defaultTargetPlatform == TargetPlatform.macOS) {
//       platformString = 'ios';
//     } else {
//       // We use 'web' as the default platform for unknown platforms.
//       platformString = 'web';
//     }
//     FirebaseAppPlatform app = await _delegate.initializeApp(
//       options: FirebaseOptions(
//         apiKey: '',
//         appId: '1:1:$platformString:1',
//         messagingSenderId: '',
//         projectId: demoProjectId,
//       ),
//     );

//     return FirebaseApp._(app);
//   }
//   FirebaseAppPlatform app = await _delegate.initializeApp(
//     name: name,
//     options: options,
//   );

//   return FirebaseApp._(app);
// }