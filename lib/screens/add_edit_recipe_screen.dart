import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../data/constants/app_categories.dart';
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
    _initializeFormControllers();
  }

  void _initializeFormControllers() {
    final recipe = widget.existingRecipe;
    _nameController = TextEditingController(text: recipe?.name ?? '');
    _imageUrlController = TextEditingController(text: recipe?.imageUrl ?? '');
    _instructionsController = TextEditingController(text: recipe?.instructions ?? '');
    _prepTimeController = TextEditingController(
      text: recipe != null ? recipe.prepTimeMinutes.toString() : '30',
    );

    _initializeIngredientList(recipe);
    
    _selectedCategory = recipe?.category ?? globalAppCategories.first.name;
    _tags = recipe != null ? List.from(recipe.tags) : [];
  }

  void _initializeIngredientList(Recipe? recipe) {
    if (recipe != null && recipe.ingredients.isNotEmpty) {
      _ingredientControllers = recipe.ingredients.map((i) => TextEditingController(text: i)).toList();
    } else {
      _ingredientControllers = List.generate(3, (_) => TextEditingController());
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _imageUrlController.dispose();
    _instructionsController.dispose();
    _prepTimeController.dispose();
    for (final controller in _ingredientControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addNewIngredientField() {
    setState(() => _ingredientControllers.add(TextEditingController()));
  }

  void _removeIngredientField(int index) {
    if (_ingredientControllers.length <= 1) return;
    
    setState(() {
      _ingredientControllers[index].dispose();
      _ingredientControllers.removeAt(index);
    });
  }

  void _toggleTag(String tag) {
    if (_tags.contains(tag)) {
      setState(() => _tags.remove(tag));
    } else {
      setState(() => _tags.add(tag));
    }
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final processedIngredients = _ingredientControllers
        .map((c) => c.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    _validateAndSubmit(processedIngredients);
  }

  void _validateAndSubmit(List<String> ingredients) {
    if (ingredients.isEmpty) {
      _showFeedbackMessage('Please add at least one ingredient', Colors.red);
      return;
    }

    final finalRecipe = Recipe(
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
      creatorEmail: widget.existingRecipe?.creatorEmail,
    );

    Navigator.pop(context, finalRecipe);
  }

  void _showFeedbackMessage(String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: bgColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Recipe' : 'Add Recipe', style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        actions: [
          IconButton(onPressed: _handleSubmit, icon: const Icon(Icons.check)),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RecipeInputField(
                label: 'Recipe Name',
                hint: 'e.g. Grandma\'s Pasta',
                controller: _nameController,
                validator: (value) => value?.trim().isEmpty ?? true ? 'Enter a name' : null,
              ),
              RecipeInputField(
                label: 'Image URL (optional)',
                hint: 'https://...',
                controller: _imageUrlController,
                keyboardType: TextInputType.url,
              ),
              _buildCategorySelector(scheme),
              RecipeInputField(
                label: 'Prep Time (minutes)',
                hint: '30',
                controller: _prepTimeController,
                keyboardType: TextInputType.number,
                validator: (value) => int.tryParse(value ?? '') == null ? 'Enter valid minutes' : null,
              ),
              IngredientsEditor(
                controllers: _ingredientControllers,
                onAdd: _addNewIngredientField,
                onRemove: _removeIngredientField,
              ),
              TagsEditor(tags: _tags, onAdd: (tag) => _toggleTag(tag), onRemove: (tag) => _toggleTag(tag)),
              RecipeInputField(
                label: 'Cooking Instructions',
                hint: '1. Prepare oven...',
                controller: _instructionsController,
                maxLines: 6,
                validator: (value) => value?.trim().isEmpty ?? true ? 'Enter instructions' : null,
              ),
              const SizedBox(height: 32),
              _buildStickySaveButton(scheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategorySelector(ColorScheme scheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Category', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedCategory,
              isExpanded: true,
              borderRadius: BorderRadius.circular(16),
              items: globalAppCategories
                  .map((category) => DropdownMenuItem(
                        value: category.name,
                        child: Text('${category.emoji}  ${category.name}'),
                      ))
                  .toList(),
              onChanged: (selection) => selection != null ? setState(() => _selectedCategory = selection) : null,
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildStickySaveButton(ColorScheme scheme) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: _handleSubmit,
        icon: const Icon(Icons.save_rounded),
        label: Text(_isEditing ? 'Update Recipe' : 'Persist Recipe', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          shadowColor: scheme.primary.withAlpha(100),
        ),
      ),
    );
  }
}
