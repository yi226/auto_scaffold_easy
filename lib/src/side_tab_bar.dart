import 'package:flutter/material.dart';

import 'auto_scaffold.dart';
import 'tab_item.dart';

class SideTabBar extends StatefulWidget {
  final List<TabItem> tabPages;
  const SideTabBar({super.key, required this.tabPages});

  @override
  State<SideTabBar> createState() => _SideTabBarState();
}

class _SideTabBarState extends State<SideTabBar> {
  @override
  Widget build(BuildContext context) {
    final theme = AutoScaffold.of(context).widget.theme;
    return Row(
      children: [
        if (!AutoScaffold.of(context).bottomMode)
          NavigationRail(
            selectedIndex: AutoScaffold.of(context).currentIndex,
            onDestinationSelected: (value) => setState(() {
              AutoScaffold.of(context).currentIndex = value;
            }),
            backgroundColor: theme?.backgroundColor,
            elevation: theme?.elevation ?? 2,
            minWidth: theme?.shortSideLength,
            labelType: theme?.labelType?.getNavigationRailLabelType(),
            destinations: widget.tabPages
                .map((e) => NavigationRailDestination(
                      icon: e.icon,
                      selectedIcon: e.selectedIcon,
                      label: Text(e.label),
                    ))
                .toList(),
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
