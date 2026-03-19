import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../data/dummy_data.dart';
import '../widgets/recipe_form/recipe_input_field.dart';
import '../widgets/recipe_form/ingredients_editor.dart';
import '../widgets/recipe_form/tags_editor.dart';

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
  late List<TextEditingController> _ingredientControllers;
  late String _selectedCategory;
  late List<String> _tags;

  bool get _isEditing => widget.existingRecipe != null;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    final recipe = widget.existingRecipe;
    _nameController = TextEditingController(text: recipe?.name ?? '');
    _imageUrlController = TextEditingController(text: recipe?.imageUrl ?? '');
    _instructionsController = TextEditingController(text: recipe?.instructions ?? '');
    _prepTimeController = TextEditingController(
      text: recipe != null ? recipe.prepTimeMinutes.toString() : '30',
    );

    if (recipe != null && recipe.ingredients.isNotEmpty) {
      _ingredientControllers = recipe.ingredients.map((i) => TextEditingController(text: i)).toList();
    } else {
      _ingredientControllers = List.generate(3, (_) => TextEditingController());
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
    for (var c in _ingredientControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addIngredient() {
    setState(() => _ingredientControllers.add(TextEditingController()));
  }

  void _removeIngredient(int index) {
    if (_ingredientControllers.length > 1) {
      setState(() {
        _ingredientControllers[index].dispose();
        _ingredientControllers.removeAt(index);
      });
    }
  }

  void _addTag(String tag) {
    if (!_tags.contains(tag)) {
      setState(() => _tags.add(tag));
    }
  }

  void _removeTag(String tag) {
    setState(() => _tags.remove(tag));
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;

    final ingredients = _ingredientControllers
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    if (ingredients.isEmpty) {
      _showSnackBar('Please add at least one ingredient', Colors.red);
      return;
    }

    final recipe = Recipe(
      id: widget.existingRecipe?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
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

  void _showSnackBar(String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: bgColor));
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Recipe' : 'Add New Recipe', style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        actions: [
          IconButton(onPressed: _onSave, icon: const Icon(Icons.check)),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecipeInputField(
                label: 'Recipe Name',
                hint: 'e.g. Chicken Pasta',
                controller: _nameController,
                validator: (v) => v != null && v.trim().isEmpty ? 'Enter a name' : null,
              ),
              RecipeInputField(
                label: 'Image URL (optional)',
                hint: 'https://...',
                controller: _imageUrlController,
                keyboardType: TextInputType.url,
              ),
              _buildCategoryDropdown(scheme),
              RecipeInputField(
                label: 'Prep Time (minutes)',
                hint: '30',
                controller: _prepTimeController,
                keyboardType: TextInputType.number,
                validator: (v) => v == null || int.tryParse(v) == null ? 'Enter minutes' : null,
              ),
              IngredientsEditor(
                controllers: _ingredientControllers,
                onAdd: _addIngredient,
                onRemove: _removeIngredient,
              ),
              TagsEditor(tags: _tags, onAdd: _addTag, onRemove: _removeTag),
              RecipeInputField(
                label: 'Instructions',
                hint: 'Step 1: ...',
                controller: _instructionsController,
                maxLines: 6,
                validator: (v) => v != null && v.trim().isEmpty ? 'Enter instructions' : null,
              ),
              const SizedBox(height: 20),
              _buildSaveButton(scheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryDropdown(ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Category', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              items: categories.map((cat) => DropdownMenuItem(value: cat.name, child: Text('${cat.emoji}  ${cat.name}'))).toList(),
              onChanged: (v) => v != null ? setState(() => _selectedCategory = v) : null,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSaveButton(ColorScheme scheme) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton.icon(
        onPressed: _onSave,
        icon: const Icon(Icons.save),
        label: Text(_isEditing ? 'Update Recipe' : 'Save Recipe', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
