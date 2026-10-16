import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_tracking_service/widgets/side_bar_item.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';


class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  static const _routes = ['/home', '/parcels', '/profile', '/help'];

  int _selectedIndex(String location) {
    final i = _routes.indexWhere((r) => location.startsWith(r));
    return i == -1 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final selectedIndex = _selectedIndex(location);

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  child: Text(
                    'PosTrack',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.link,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SideBarItem(
                  icon: Icons.home_outlined,
                  label: "Головна",
                  selected: (0 == selectedIndex),
                  onTap: () => context.go("/home"),
                ),
                SideBarItem(
                  icon: Icons.inventory_2_outlined,
                  label: "Мої посилки",
                  selected: (1 == selectedIndex),
                  onTap: () => context.go("/parcels"),
                ),
                SideBarItem(
                  icon: Icons.person_outline,
                  label: "Профіль",
                  selected: (2 == selectedIndex),
                  onTap: () => context.go("/profile"),
                ),
                SideBarItem(
                  icon: Icons.help_outline,
                  label: "Довідка",
                  selected: (3 == selectedIndex),
                  onTap: () => context.go("/help"),
                ),
              ],
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}