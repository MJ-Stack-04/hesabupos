import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hesabuapp/data/services/shared_preference.dart';
import 'package:hesabuapp/presentation/bindings/app_binding.dart';
import 'package:hesabuapp/presentation/routes/app_pages.dart';
import 'package:hesabuapp/presentation/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final sharedPrefs = SharedPreference();
  await sharedPrefs.init();
  Get.put(sharedPrefs);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Hesabu App',
      initialRoute: AppRoutes.login,
      initialBinding: AppBinding(),
      getPages: AppPages.pages,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}