import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';

/// The entry point of the application.  Initializes Supabase and
/// reads persisted login state before launching the UI.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Supabase with project credentials.  Developers
  // should supply their own URL and anon key in `core/constants.dart`.
  await Supabase.initialize(
    url: SupabaseConstants.supabaseUrl,
    anonKey: SupabaseConstants.supabaseAnonKey,
  );
  // Read whether the user was previously logged in.
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(
    EBookCatalogueApp(
      initialRoute: isLoggedIn ? AppRoutes.home : AppRoutes.login,
    ),
  );
}

/// The root widget for the application.  Provides theming and
/// configures routes using GetX.
class EBookCatalogueApp extends StatelessWidget {
  final String initialRoute;

  const EBookCatalogueApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF2563EB);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catalogue E‑BOOK',
      initialRoute: initialRoute,
      getPages: AppPages.routes,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(),
        cardTheme: const CardThemeData(
          elevation: 0,
          clipBehavior: Clip.antiAlias,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          clipBehavior: Clip.antiAlias,
        ),
      ),
    );
  }
}
