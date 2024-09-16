// ignore_for_file: prefer_const_constructors


import 'package:flutter_stripe/flutter_stripe.dart';

import 'Widgets/AllExport.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey = "pk_test_TYooMQauvdEDq54NiTphI7jx";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent)
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Flutter Demo', 
        home: const SplashScreen());
  }
}
