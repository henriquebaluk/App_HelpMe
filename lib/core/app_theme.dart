import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Cores por categoria (cards, chips, ícones)
Color categoryColor(String c) {
  switch (c) {
    case 'Serviço':
      return const Color(0xFF2E7D32); // verde
    case 'Doação':
      return const Color(0xFF7C4DFF); // roxo
    case 'Transporte':
      return const Color(0xFFFF7043); // laranja
    case 'Companhia':
      return const Color(0xFF00897B); // teal
    default:
      return const Color(0xFF546E7A); // blueGrey
  }
}

/// Matiz (0–360) para marcador do Google Maps por categoria
double categoryHue(String c) {
  switch (c) {
    case 'Serviço':
      return 120.0; // green
    case 'Doação':
      return 270.0; // purple
    case 'Transporte':
      return 16.0; // orange
    case 'Companhia':
      return 174.0; // teal
    default:
      return 210.0; // blueGrey-ish
  }
}

class AppTheme {
  static ThemeData light() {
    // Seed verde (identidade do app)
    const seed = Color(0xFF2E7D32);
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: GoogleFonts.poppinsTextTheme(),

      // Fundo neutro que combina com o topo roxo
      scaffoldBackgroundColor: const Color(0xFFF6F8FB),

      // 🔹 AppBar roxa (global)
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF7C4DFF),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary, width: 1.8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.primary,
        contentTextStyle: TextStyle(color: scheme.onPrimary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      chipTheme: ChipThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        side: BorderSide(color: Colors.grey.shade300),
        backgroundColor: const Color(0xFFF0F3F9),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),

      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: scheme.secondaryContainer,
        labelTextStyle: WidgetStateTextStyle.resolveWith(
          (s) => TextStyle(
            fontWeight: s.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
          ),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.secondary,
        foregroundColor: scheme.onSecondary,
      ),

      // compat
      cardColor: Colors.white,
    );
  }
}
