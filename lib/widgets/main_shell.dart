import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mail_tracking_service/widgets/side_bar_item.dart';
import 'package:mail_tracking_service/theme/app_colors.dart';
import 'package:mail_tracking_service/widgets/app_header.dart';
import 'package:mail_tracking_service/services/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:mail_tracking_service/models/current_parcel_provider.dart';

class MainShell extends StatelessWidget {
  final Widget child;
  final AuthRepository _authRepository = AuthRepository();

  MainShell({super.key, required this.child});

  static const _routes = ['/home', '/parcels', '/profile', '/help'];

  int _selectedIndex(String location) {
    final i = _routes.indexWhere((r) => location.startsWith(r));
    return i == -1 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final selectedIndex = _selectedIndex(location);
    final currentParcelProvider = context.read<CurrentParcelProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          Container(
            width: 300,
            color: Colors.white,
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
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: [
                      SideBarItem(
                        icon: Icons.home_outlined,
                        label: "Головна",
                        selected: (0 == selectedIndex),
                        onTap: () {
                          currentParcelProvider.remove();
                          context.go("/home");
                        },
                      ),
                      SideBarItem(
                        icon: Icons.inventory_2_outlined,
                        label: "Мої посилки",
                        selected: (1 == selectedIndex),
                        onTap: () {
                          currentParcelProvider.remove();
                          context.go("/parcels");
                          },
                      ),
                      SideBarItem(
                        icon: Icons.person_outline,
                        label: "Профіль",
                        selected: (2 == selectedIndex),
                        onTap: () {
                          currentParcelProvider.remove();
                          context.go("/profile");
                          },
                      ),
                      SideBarItem(
                        icon: Icons.help_outline,
                        label: "Довідка",
                        selected: (3 == selectedIndex),
                        onTap: () {
                          currentParcelProvider.remove();
                          context.go('/help');
                        },
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StreamBuilder<User?>(
                  stream: _authRepository.userChanges,
                  builder: (context, snapshot) {
                    final user = snapshot.data;
                    final displayName = user?.displayName ?? user?.email ?? 'Користувач';
                    final photo = user?.photoURL;

                    return AppHeader(
                      name: displayName,
                      photoUrl: (photo == null || photo.isEmpty) ? null : photo,
                      onLogout: () async {
                          await _authRepository.signOut();
                          if (context.mounted) context.go('/login');
                        },
                      );
                    },
                ),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}