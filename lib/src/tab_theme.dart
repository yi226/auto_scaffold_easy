import 'package:flutter/material.dart';

enum LabelType {
  /// Only the Destinations are shown.
  hide,

  /// All Destinations will show their label.
  show,

  /// Only the selected Destination will show its label.
  ///
  /// The label will animate in and out as new Destinations are
  /// selected.
  selected;

  NavigationDestinationLabelBehavior getNavigationDestinationLabelBehavior() {
    switch (this) {
      case hide:
        return NavigationDestinationLabelBehavior.alwaysHide;
      case show:
        return NavigationDestinationLabelBehavior.alwaysShow;
      case selected:
        return NavigationDestinationLabelBehavior.onlyShowSelected;
    }
  }

  NavigationRailLabelType getNavigationRailLabelType() {
    switch (this) {
      case hide:
        return NavigationRailLabelType.none;
      case show:
        return NavigationRailLabelType.all;
      case selected:
        return NavigationRailLabelType.selected;
    }
  }
}

class TabTheme {
  /// The theme of Navigation tab
  const TabTheme({
    this.backgroundColor,
    this.elevation,
    this.shortSideLength,
    this.labelType,
  });

  /// The color of the [NavigationBar]  and [NavigationRail].
  final Color? backgroundColor;

  /// The elevation of the [NavigationBar] and [NavigationRail].
  final double? elevation;

  /// The short side length of the [NavigationBar] and [NavigationRail].
  ///
  /// width for [NavigationRail].
  ///
  /// height for [NavigationBar].
  final double? shortSideLength;

  /// hide or show label
  final LabelType? labelType;
}
