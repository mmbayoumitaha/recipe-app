import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/recipe/recipe_cubit.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      color: scheme.primary,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: TextField(
        onChanged: (value) {
          context.read<RecipeCubit>().updateSearchQuery(value);
        },
        decoration: InputDecoration(
          hintText: 'Search recipes...',
          prefixIcon: Icon(
            Icons.search,
            color: scheme.onSurface.withValues(alpha: 0.6),
          ),
          filled: true,
          fillColor: scheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }
}
