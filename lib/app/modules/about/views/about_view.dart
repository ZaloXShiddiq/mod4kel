import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Simple static page describing the application.  This view
/// highlights some of the design considerations and usage hints.
class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang Aplikasi')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [cs.primary, cs.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.local_library_rounded,
                    size: 42,
                    color: cs.onPrimary,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      '',
                      style: GoogleFonts.inter(
                        color: cs.onPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Katalog e‑book terhubung langsung ke folder Google Drive per kategori. '
              'Desain ringan, responsif, dan ramah baterai.',
              style: GoogleFonts.inter(fontSize: 14, color: cs.onSurface),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.link),
              title: const Text('Struktur kategori mengikuti Google Drive'),
              subtitle: const Text(
                'Jika link berubah, cukup update URL di data kategori.',
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.energy_savings_leaf_outlined),
              title: const Text('Efisiensi daya'),
              subtitle: const Text(
                'Animasi mikro (Hero, ripple) tanpa beban GPU berlebih.',
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
