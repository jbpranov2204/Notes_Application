import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'bindings/initial_binding.dart';
import 'bindings/app_bindings.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: 'Notes App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        // Add your light theme customizations here
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(foregroundColor: Colors.black87),
      ),
      darkTheme: ThemeData.dark().copyWith(
        // Add your dark theme customizations here
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
      themeMode: ThemeMode.system, // Default to system theme
      initialBinding: AppBindings(),
      getPages: AppRoutes.routes,
      initialRoute: '/',
    ),
  );
}
