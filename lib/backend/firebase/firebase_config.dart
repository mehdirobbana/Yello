import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCzM5DLbafXCtTxgUjeds7zk2eqdUqT8ks",
            authDomain: "movies-fglaj1.firebaseapp.com",
            projectId: "movies-fglaj1",
            storageBucket: "movies-fglaj1.firebasestorage.app",
            messagingSenderId: "1035330222793",
            appId: "1:1035330222793:web:2d032b6130658590346b18",
            measurementId: "G-QMMJFJTFTM"));
  } else {
    await Firebase.initializeApp();
  }
}
