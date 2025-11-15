import 'package:flutter/material.dart';

/// Model representing a single category of e‑books.  Each category
/// includes a name, a URL pointing to its Google Drive folder, an
/// icon to display in the UI, a gradient for styling, and an
/// optional badge.
class Category {
  final String name;
  final String url;
  final IconData icon;
  final List<Color> gradient;
  final String? badge;

  const Category({
    required this.name,
    required this.url,
    required this.icon,
    required this.gradient,
    this.badge,
  });
}