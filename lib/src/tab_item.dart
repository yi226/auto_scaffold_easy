import 'package:flutter/material.dart';

class TabItem {
  /// Used to create a navigation destination with an icon and a label
  const TabItem({
    required this.label,
    required this.icon,
    required this.widget,
    this.selectedIcon,
  });

  /// The text label that appears below the icon of this
  /// [NavigationDestination] and [NavigationRailDestination].
  ///
  /// The default
  /// text style would use [TextTheme.labelSmall] with [ColorScheme.onSurface].
  final String label;

  /// The [Widget] (usually an [Icon]) that's displayed for
  /// [NavigationDestination] and [NavigationRailDestination].
  ///
  /// The default [IconThemeData] would use a size of 24.0 and
  /// [ColorScheme.onSurface].
  final Widget icon;

  /// The optional [Widget] (usually an [Icon]) that's displayed when this
  /// [NavigationDestination] or [NavigationRailDestination] is selected.
  ///
  /// If [selectedIcon] is non-null, the destination will fade from
  /// [icon] to [selectedIcon] when this destination goes from unselected to
  /// selected.
  ///
  /// The default [IconThemeData]
  /// would use a size of 24.0 and [ColorScheme.onSurface].
  final Widget? selectedIcon;

  /// The widget of this page
  final Widget widget;
}
