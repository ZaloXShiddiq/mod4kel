import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/models/category_model.dart';
import '../../../../services/api_http_service.dart';
import '../../../../services/api_dio_service.dart';
import '../../../routes/app_routes.dart';

/// Controller for the home module.  Manages category data and
/// performs API comparisons between `http` and `dio` libraries.
class HomeController extends GetxController {
  /// Service instance for HTTP client experiments.
  final httpService = ApiHttpService();

  /// Service instance for Dio client experiments.
  final dioService = ApiDioService();

  /// Observables for tracking response times.
  var httpTime = 0.obs;
  var dioTime = 0.obs;

  /// Observables for storing API results.
  var httpResult = {}.obs;
  var dioResult = {}.obs;

  /// Initiates a comparison between the two API clients.  Measures
  /// response times and stores a snippet of the returned data for
  /// display in the UI.
  Future<void> compareApis() async {
    try {
      final httpResponse = await httpService.fetchPosts();
      httpTime.value = httpResponse['time'];
      httpResult.value = httpResponse['data'];

      final dioResponse = await dioService.fetchPosts();
      dioTime.value = dioResponse['time'];
      dioResult.value = dioResponse['data'];

      // Print to console for debugging
      // ignore: avoid_print
      print(
          'HTTP Time: ${httpTime.value} ms | DIO Time: ${dioTime.value} ms');
    } catch (e) {
      // ignore: avoid_print
      print('Comparison error: $e');
    }
  }

  /// List of categories displayed on the home page.  Each category
  /// links to a Google Drive folder.  The list is observable so that
  /// updates can be propagated to the UI automatically.
  final categories = <Category>[
    const Category(
      name: 'AGAMA',
      url:
          'https://drive.google.com/drive/folders/1oxJW8RJlsOSvHrfhzhJ8e0BwotpksAro',
      icon: Icons.self_improvement,
      gradient: [Color(0xFF10B981), Color(0xFF059669)],
    ),
    const Category(
      name: 'ENGLISH EDITION',
      url:
          'https://drive.google.com/drive/folders/1x74GS0nfyiOQTLmVDIDJyywDAHE4WAPx',
      icon: Icons.language,
      gradient: [Color(0xFF60A5FA), Color(0xFF2563EB)],
    ),
    const Category(
      name: 'FILSAFAT',
      url:
          'https://drive.google.com/drive/folders/1o4KnMppaDyyXkReuHfIMpVuy7QncWP9c',
      icon: Icons.psychology_alt,
      gradient: [Color(0xFFF59E0B), Color(0xFFEA580C)],
    ),
    const Category(
      name: 'IDEOLOGI',
      url:
          'https://drive.google.com/drive/folders/1FAWCwAkfpydhPl6F_Iq9Ux8Ae9sN1xtE',
      icon: Icons.flag_circle,
      gradient: [Color(0xFFE879F9), Color(0xFFA855F7)],
    ),
    const Category(
      name: 'KE-HMI-AN',
      url:
          'https://drive.google.com/drive/folders/1ooQDD-aL1f25NYlC7XcN9vLI_HSAUKSX',
      icon: Icons.groups_2,
      gradient: [Color(0xFF22C55E), Color(0xFF16A34A)],
      badge: 'Mitra',
    ),
    const Category(
      name: 'NOVEL',
      url:
          'https://drive.google.com/drive/folders/1XEFzZIvNlbBRIwJ4-iZUlazIYzBI60yE',
      icon: Icons.menu_book_rounded,
      gradient: [Color(0xFF4DD0E1), Color(0xFF0288D1)],
    ),
    const Category(
      name: 'PERGERAKAN',
      url:
          'https://drive.google.com/drive/folders/1xPsg-M21kwMKhTiKZMcEXrgsjIwmgmnb',
      icon: Icons.travel_explore,
      gradient: [Color(0xFF34D399), Color(0xFF14B8A6)],
    ),
    const Category(
      name: 'POLITIK DAN HUKUM',
      url:
          'https://drive.google.com/drive/folders/13T9nuMNQ6Xe2rMUG5EMsNauQx1aYjUzE',
      icon: Icons.gavel_rounded,
      gradient: [Color(0xFFEF4444), Color(0xFFB91C1C)],
    ),
    const Category(
      name: 'PROFESI',
      url:
          'https://drive.google.com/drive/folders/1EX0DfJo-J3QiDchIJFazbDKtvdij_hpi',
      icon: Icons.badge_rounded,
      gradient: [Color(0xFF93C5FD), Color(0xFF3B82F6)],
    ),
    const Category(
      name: 'SEJARAH DAN SASTRA',
      url:
          'https://drive.google.com/drive/folders/18ohX5D838H0ugvm7mXgw6mz3bYStLccg',
      icon: Icons.history_edu_rounded,
      gradient: [Color(0xFFFB7185), Color(0xFFF43F5E)],
    ),
    const Category(
      name: 'UMUM',
      url:
          'https://drive.google.com/drive/folders/1wEAcY-g7ob5zIg8QPLxwWZAUb86Tti22',
      icon: Icons.grid_view_rounded,
      gradient: [Color(0xFFA3A3A3), Color(0xFF525252)],
    ),
  ].obs;

  /// Opens the URL associated with a given [Category].  If the URL is
  /// invalid or fails to launch, a snackbar informs the user.
  Future<void> openUrl(Category category) async {
    final uri = Uri.tryParse(category.url);
    if (uri == null || (uri.scheme != 'http' && uri.scheme != 'https')) {
      Get.snackbar(
        'URL tidak valid',
        category.name,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final launchMode = LaunchMode.platformDefault;
    final webName = kIsWeb ? '_blank' : null;

    final ok = await launchUrl(
      uri,
      mode: launchMode,
      webOnlyWindowName: webName,
    );

    if (!ok) {
      Get.snackbar(
        'Gagal membuka',
        category.name,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Navigates to the About page.
  void toAbout() {
    Get.toNamed(AppRoutes.about);
  }
}