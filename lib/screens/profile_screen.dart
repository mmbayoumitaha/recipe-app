import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/login/login_cubit.dart';
import '../cubit/recipe/recipe_cubit.dart';
import '../cubit/theme/theme_cubit.dart';
import '../widgets/profile/profile_stat_card.dart';
import '../widgets/profile/profile_list_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final userEmail =
        context.watch<RecipeCubit>().currentUserEmail ?? 'Guest@cookcraft.com';

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _ProfileHeader(userEmail: userEmail, scheme: scheme),
            const _ProfileStatsSection(),
            const _ProfileSettingsSection(),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final String userEmail;
  final ColorScheme scheme;

  const _ProfileHeader({required this.userEmail, required this.scheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 60, bottom: 40),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
      ),
      child: Column(
        children: [
          _buildAvatar(),
          const SizedBox(height: 16),
          Text(
            userEmail.split('@')[0].toUpperCase(),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: 1,
            ),
          ),
          Text(
            userEmail,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 45,
        backgroundColor: scheme.primary.withValues(alpha: 0.1),
        child: Icon(Icons.person_rounded, size: 50, color: scheme.primary),
      ),
    );
  }
}

class _ProfileStatsSection extends StatelessWidget {
  const _ProfileStatsSection();

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<RecipeCubit>();
    final state = cubit.state;
    final userEmail = cubit.currentUserEmail;

    final myRecipesCount = state.recipes
        .where((r) => r.creatorEmail == userEmail)
        .length;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          ProfileStatCard(
            label: 'My Recipes',
            value: '$myRecipesCount',
            icon: Icons.restaurant_menu_rounded,
            color: Colors.orange,
          ),
          const SizedBox(width: 16),
          ProfileStatCard(
            label: 'Favorites',
            value: '${state.favoriteIds.length}',
            icon: Icons.favorite_rounded,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}

class _ProfileSettingsSection extends StatelessWidget {
  const _ProfileSettingsSection();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('App Preferences'),
          ProfileListItem(
            icon: Icons.dark_mode_rounded,
            label: 'Dark Mode',
            trailing: BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, mode) => Switch(
                value: mode == ThemeMode.dark,
                onChanged: (v) => context.read<ThemeCubit>().toggleTheme(v),
                activeThumbColor: scheme.primary,
              ),
            ),
          ),
          _buildSectionTitle('Account'),
          ProfileListItem(
            icon: Icons.info_outline_rounded,
            label: 'About CookCraft',
            onTap: () => _showAboutDialog(context),
          ),
          ProfileListItem(
            icon: Icons.logout_rounded,
            label: 'Logout',
            onTap: () => _showLogoutConfirmation(context),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: theme.cardTheme.color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        titlePadding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        contentPadding: const EdgeInsets.all(24),
        title: Row(
          children: [
            const Icon(Icons.restaurant_menu, color: Colors.orange, size: 32),
            const SizedBox(width: 16),
            const Text(
              'CookCraft',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'CookCraft is your personal cookbook for sharing and discovering best recipes.',
              style: TextStyle(height: 1.5, fontSize: 15),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Close',
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              loginCubit.logout();
            },
            child: const Text('Logout', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12, top: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
