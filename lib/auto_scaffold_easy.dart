library auto_scaffold_easy;

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

class AutoScaffold extends StatefulWidget {
  /// Create a Scaffold which is ability to automatically select
  /// between [NavigationDestination] and [NavigationRailDestination]
  /// as the screen size changes
  ///
  /// useMaterial3 is recommended to set to true
  const AutoScaffold({
    super.key,
    required this.tabPages,
    this.appBar,
    this.saveState = true,
  });

  /// Navigation settings and Corresponding pages.
  final List<TabItem> tabPages;

  /// An app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// Whether to save the state of each page.
  ///
  /// If true then the state of each page will be saved
  /// When switching between different pages.
  ///
  /// The default value of this property is true.
  final bool saveState;

  static AutoScaffoldState of(BuildContext context) {
    final AutoScaffoldState? result =
        context.findAncestorStateOfType<AutoScaffoldState>();
    if (result != null) {
      return result;
    }
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
        'AutoScaffold.of() called with a context that does not contain a AutoScaffold.',
      ),
      context.describeElement('The context used was'),
    ]);
  }

  @override
  State<AutoScaffold> createState() => AutoScaffoldState();
}

class AutoScaffoldState extends State<AutoScaffold> {
  /// Current index of pages
  int currentIndex = 0;

  /// whether to use NavigationBar or NavigationRail
  ///
  /// If true then use NavigationBar
  ///
  /// Depends on the size of the device
  bool bottomMode = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    bottomMode = size.width < size.height;
    return Scaffold(
      appBar: widget.appBar,
      body: _SideTabBar(tabPages: widget.tabPages),
      bottomNavigationBar: bottomMode
          ? NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (value) => setState(() {
                currentIndex = value;
              }),
              destinations: widget.tabPages
                  .map((e) => NavigationDestination(
                        icon: e.icon,
                        selectedIcon: e.selectedIcon,
                        label: e.label,
                      ))
                  .toList(),
            )
          : null,
    );
  }
}

class _SideTabBar extends StatefulWidget {
  final List<TabItem> tabPages;
  const _SideTabBar({required this.tabPages});

  @override
  State<_SideTabBar> createState() => _SideTabBarState();
}

class _SideTabBarState extends State<_SideTabBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!AutoScaffold.of(context).bottomMode)
          NavigationRail(
            selectedIndex: AutoScaffold.of(context).currentIndex,
            destinations: widget.tabPages
                .map((e) => NavigationRailDestination(
                      icon: e.icon,
                      selectedIcon: e.selectedIcon,
                      label: Text(e.label),
                    ))
                .toList(),
            onDestinationSelected: (value) => setState(() {
              AutoScaffold.of(context).currentIndex = value;
            }),
            elevation: 2,
            labelType: NavigationRailLabelType.all,
          ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoScaffold.of(context).widget.saveState
                  ? IndexedStack(
                      index: AutoScaffold.of(context).currentIndex,
                      children: widget.tabPages.map((e) => e.widget).toList(),
                    )
                  : widget
                      .tabPages[AutoScaffold.of(context).currentIndex].widget,
            ],
          ),
        ),
      ],
    );
  }
}
