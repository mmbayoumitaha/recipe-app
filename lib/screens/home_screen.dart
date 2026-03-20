import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/recipe/recipe_cubit.dart';
import '../cubit/recipe/recipe_state.dart';
import '../widgets/home/home_search_bar.dart';
import '../widgets/home/categories_section.dart';
import '../widgets/home/recipes_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (context, state) {
          final isSearching = state.searchQuery.isNotEmpty;

          return RefreshIndicator(
            onRefresh: () => context.read<RecipeCubit>().refresh(),
            color: scheme.primary,
            backgroundColor: theme.cardTheme.color,
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _buildAppBar(isDarkMode, scheme, theme),
                _buildHeaderSection(isSearching),
                RecipesSection(
                  recipes: state.filteredRecipes,
                  isSearching: isSearching,
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(bool isDarkMode, ColorScheme scheme, ThemeData theme) {
    return SliverAppBar(
      title: const Text('🍳 CookCraft', style: TextStyle(fontWeight: FontWeight.bold)),
      backgroundColor: isDarkMode ? theme.scaffoldBackgroundColor : scheme.primary,
      foregroundColor: isDarkMode ? scheme.onSurface : Colors.white,
      floating: true,
      pinned: true,
      elevation: 0,
      centerTitle: false,
    );
  }

  Widget _buildHeaderSection(bool isSearching) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const HomeSearchBar(),
          if (!isSearching) ...[
            const CategoriesSection(),
          ],
        ],
      ),
    );
  }
}
