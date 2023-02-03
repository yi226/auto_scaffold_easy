import 'package:flutter/material.dart';

import 'side_tab_bar.dart';
import 'tab_item.dart';
import 'tab_theme.dart';

class AutoScaffold extends StatefulWidget {
  /// Create a Scaffold which is ability to automatically select
  /// between [NavigationDestination] and [NavigationRailDestination]
  /// as the screen size changes
  ///
  /// useMaterial3 is recommended to set to true
  const AutoScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.saveState = true,
    this.theme,
  });

  /// Navigation settings and Corresponding pages.
  final List<TabItem> body;

  /// An app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// Whether to save the state of each page.
  ///
  /// If true then the state of each page will be saved
  /// When switching between different pages.
  ///
  /// The default value of this property is true.
  final bool saveState;

  /// The theme of the navigation tab
  final TabTheme? theme;

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
      body: SideTabBar(tabPages: widget.body),
      bottomNavigationBar: bottomMode
          ? NavigationBar(
              selectedIndex: currentIndex,
              onDestinationSelected: (value) => setState(() {
                currentIndex = value;
              }),
              backgroundColor: widget.theme?.backgroundColor,
              elevation: widget.theme?.elevation,
              height: widget.theme?.shortSideLength,
              labelBehavior: widget.theme?.labelType
                  ?.getNavigationDestinationLabelBehavior(),
              destinations: widget.body
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
