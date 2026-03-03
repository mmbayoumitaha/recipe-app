import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../data/dummy_data.dart';

class AddEditRecipeScreen extends StatefulWidget {
  final Recipe? existingRecipe;

  const AddEditRecipeScreen({super.key, this.existingRecipe});

  @override
  State<AddEditRecipeScreen> createState() => _AddEditRecipeScreenState();
}

class _AddEditRecipeScreenState extends State<AddEditRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _imageUrlController;
  late TextEditingController _instructionsController;
  late TextEditingController _prepTimeController;
  late TextEditingController _tagController;
  late List<TextEditingController> _ingredientControllers;
  late String _selectedCategory;
  late List<String> _tags;

  bool get _isEditing => widget.existingRecipe != null;

  @override
  void initState() {
    super.initState();

    final recipe = widget.existingRecipe;

    _nameController = TextEditingController(text: recipe?.name ?? '');
    _imageUrlController = TextEditingController(text: recipe?.imageUrl ?? '');
    _instructionsController = TextEditingController(
      text: recipe?.instructions ?? '',
    );
    _prepTimeController = TextEditingController(
      text: recipe != null ? recipe.prepTimeMinutes.toString() : '30',
    );
    _tagController = TextEditingController();

    if (recipe != null && recipe.ingredients.isNotEmpty) {
      _ingredientControllers = recipe.ingredients
          .map((i) => TextEditingController(text: i))
          .toList();
    } else {
      _ingredientControllers = [
        TextEditingController(),
        TextEditingController(),
        TextEditingController(),
      ];
    }

    _selectedCategory = recipe?.category ?? categories.first.name;
    _tags = recipe != null ? List.from(recipe.tags) : [];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _imageUrlController.dispose();
    _instructionsController.dispose();
    _prepTimeController.dispose();
    _tagController.dispose();
    for (var c in _ingredientControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addIngredientField() {
    setState(() {
      _ingredientControllers.add(TextEditingController());
    });
  }

  void _removeIngredientField(int index) {
    if (_ingredientControllers.length > 1) {
      setState(() {
        _ingredientControllers[index].dispose();
        _ingredientControllers.removeAt(index);
      });
    }
  }

  void _addTag() {
    final tag = _tagController.text.trim();
    if (tag.isNotEmpty && !_tags.contains(tag)) {
      setState(() {
        _tags.add(tag);
        _tagController.clear();
      });
    }
  }

  void _removeTag(String tag) {
    setState(() {
      _tags.remove(tag);
    });
  }

  void _saveRecipe() {
    if (!_formKey.currentState!.validate()) return;

    final ingredients = _ingredientControllers
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    if (ingredients.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one ingredient'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final recipe = Recipe(
      id:
          widget.existingRecipe?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      imageUrl: _imageUrlController.text.trim().isEmpty
          ? 'https://images.unsplash.com/photo-1495195134817-aeb325a55b65?w=600'
          : _imageUrlController.text.trim(),
      category: _selectedCategory,
      ingredients: ingredients,
      instructions: _instructionsController.text.trim(),
      tags: _tags,
      prepTimeMinutes: int.tryParse(_prepTimeController.text) ?? 30,
    );

    Navigator.pop(context, recipe);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Recipe' : 'Add New Recipe',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: _saveRecipe,
            icon: const Icon(Icons.check, color: Colors.white),
            label: const Text(
              'Save',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Recipe Name'),
              TextFormField(
                controller: _nameController,
                decoration: _inputDecoration('e.g. Chicken Pasta'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a recipe name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Image URL (optional)'),
              TextFormField(
                controller: _imageUrlController,
                decoration: _inputDecoration('https://example.com/photo.jpg'),
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Category'),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items: categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat.name,
                        child: Text('${cat.emoji}  ${cat.name}'),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildSectionTitle('Prep Time (minutes)'),
              TextFormField(
                controller: _prepTimeController,
                decoration: _inputDecoration('30'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionTitle('Ingredients'),
                  TextButton.icon(
                    onPressed: _addIngredientField,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.orange.shade700,
                    ),
                  ),
                ],
              ),
              ...List.generate(_ingredientControllers.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _ingredientControllers[index],
                          decoration: _inputDecoration(
                            'Ingredient ${index + 1}',
                          ),
                        ),
                      ),
                      if (_ingredientControllers.length > 1)
                        IconButton(
                          onPressed: () => _removeIngredientField(index),
                          icon: const Icon(Icons.remove_circle_outline),
                          color: Colors.red.shade400,
                        ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
              _buildSectionTitle('Tags'),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _tagController,
                      decoration: _inputDecoration('e.g. Easy, Vegan'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _addTag,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    child: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (_tags.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: _tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      deleteIcon: const Icon(Icons.close, size: 16),
                      onDeleted: () => _removeTag(tag),
                      backgroundColor: Colors.orange.shade50,
                      side: BorderSide(color: Colors.orange.shade200),
                    );
                  }).toList(),
                ),
              const SizedBox(height: 20),
              _buildSectionTitle('Instructions'),
              TextFormField(
                controller: _instructionsController,
                decoration: _inputDecoration('Step 1: ...\nStep 2: ...'),
                maxLines: 6,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please add instructions';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _saveRecipe,
                  icon: const Icon(Icons.save),
                  label: Text(
                    _isEditing ? 'Update Recipe' : 'Save Recipe',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: Colors.orange.shade600, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}
