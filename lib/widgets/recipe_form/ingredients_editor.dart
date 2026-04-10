import 'package:flutter/material.dart';

class IngredientsEditor extends StatelessWidget {
  final List<TextEditingController> controllers;
  final VoidCallback onAdd;
  final Function(int) onRemove;

  const IngredientsEditor({
    super.key,
    required this.controllers,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Ingredients',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add'),
              style: TextButton.styleFrom(
                foregroundColor: scheme.secondary,
              ),
            ),
          ],
        ),
        ...List.generate(controllers.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controllers[index],
                    decoration: InputDecoration(
                      hintText: 'Ingredient ${index + 1}',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: scheme.primary, width: 2),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                ),
                if (controllers.length > 1)
                  IconButton(
                    onPressed: () => onRemove(index),
                    icon: const Icon(Icons.remove_circle_outline),
                    color: Colors.red.shade400,
                  ),
              ],
            ),
          );
        }),
        const SizedBox(height: 20),
      ],
    );
  }
}
