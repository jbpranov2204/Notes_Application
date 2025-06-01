import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'bindings/app_bindings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(foregroundColor: Colors.black87),
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey[900],
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(color: Colors.white),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      themeMode: ThemeMode.light, // This forces light mode
      initialBinding: AppBindings(),
      getPages: AppRoutes.routes,
      initialRoute: '/',
    );
  }
}
