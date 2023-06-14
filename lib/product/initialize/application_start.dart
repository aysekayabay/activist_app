import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../core/services/firebase/firebase_options.dart';

class ApplicationStart {
  const ApplicationStart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
