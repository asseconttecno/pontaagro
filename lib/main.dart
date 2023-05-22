import 'package:flutter/material.dart';


import 'package:provider/provider.dart';


import 'app/config/providers.dart';
import 'app/config/theme_colors.dart';
import 'app/presentation/views/home.dart';

void main() {
  runApp(
      MultiProvider(
        providers: Providers.listDefault(),
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ponta Agro',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: ThemeColors.priColor, surfaceTint: Colors.white ),
        primaryColor: ThemeColors.priColor,
        appBarTheme: AppBarTheme(
          color: Colors.white, centerTitle: true,
          iconTheme: IconThemeData(color: ThemeColors.priColor),
          titleTextStyle: TextStyle(color: ThemeColors.priColor,
              fontWeight: FontWeight.bold, fontSize: 20)
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: ThemeColors.mainColor,
          shape: CircleBorder(),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        final MediaQueryData data = MediaQuery.of(context);
        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      home: const HomeView()
    );
  }
}
