import '../models/recipe.dart';

class CategoryInfo {
  final String name;
  final String emoji;

  const CategoryInfo({required this.name, required this.emoji});
}

const List<CategoryInfo> categories = [
  CategoryInfo(name: 'Breakfast', emoji: '🍳'),
  CategoryInfo(name: 'Lunch', emoji: '🥗'),
  CategoryInfo(name: 'Dinner', emoji: '🍝'),
  CategoryInfo(name: 'Dessert', emoji: '🍰'),
  CategoryInfo(name: 'Snacks', emoji: '🍿'),
  CategoryInfo(name: 'Drinks', emoji: '🥤'),
];

List<Recipe> sampleRecipes = [
  Recipe(
    id: '1',
    name: 'Pancakes',
    imageUrl:
        'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=600',
    category: 'Breakfast',
    ingredients: [
      '1½ cups flour',
      '3½ tsp baking powder',
      '1 tbsp sugar',
      '1¼ cups milk',
      '1 egg',
      '3 tbsp melted butter',
    ],
    instructions:
        '1. Mix dry ingredients in a bowl.\n'
        '2. Make a well in the center and pour in milk, egg, and melted butter.\n'
        '3. Mix until smooth.\n'
        '4. Heat a griddle over medium-high heat.\n'
        '5. Pour batter onto the griddle, using about ¼ cup for each pancake.\n'
        '6. Cook until bubbles appear on the surface, then flip and cook until golden.',
    tags: ['Easy', 'Quick', 'Kids'],
    prepTimeMinutes: 20,
  ),
  Recipe(
    id: '2',
    name: 'Avocado Toast',
    imageUrl:
        'https://images.unsplash.com/photo-1541519227354-08fa5d50c44d?w=600',
    category: 'Breakfast',
    ingredients: [
      '2 slices bread',
      '1 ripe avocado',
      'Salt & pepper',
      'Red pepper flakes',
      'Lemon juice',
    ],
    instructions:
        '1. Toast the bread slices until golden.\n'
        '2. Mash the avocado with a fork.\n'
        '3. Season with salt, pepper, and lemon juice.\n'
        '4. Spread the mashed avocado on toast.\n'
        '5. Sprinkle with red pepper flakes.',
    tags: ['Healthy', 'Quick', 'Vegan'],
    prepTimeMinutes: 10,
  ),
  Recipe(
    id: '3',
    name: 'Caesar Salad',
    imageUrl: 'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=600',
    category: 'Lunch',
    ingredients: [
      '1 head romaine lettuce',
      '½ cup croutons',
      '¼ cup parmesan cheese',
      '3 tbsp Caesar dressing',
      'Grilled chicken (optional)',
    ],
    instructions:
        '1. Wash and chop the romaine lettuce.\n'
        '2. Toss with Caesar dressing.\n'
        '3. Add croutons and shaved parmesan.\n'
        '4. Top with grilled chicken if desired.',
    tags: ['Healthy', 'Classic'],
    prepTimeMinutes: 15,
  ),
  Recipe(
    id: '4',
    name: 'Grilled Cheese Sandwich',
    imageUrl:
        'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=600',
    category: 'Lunch',
    ingredients: ['2 slices bread', '2 slices cheddar cheese', '1 tbsp butter'],
    instructions:
        '1. Butter the outside of each bread slice.\n'
        '2. Place cheese between the bread slices.\n'
        '3. Heat a skillet over medium heat.\n'
        '4. Cook sandwich for 3-4 minutes per side until golden and cheese is melted.',
    tags: ['Quick', 'Easy', 'Kids'],
    prepTimeMinutes: 10,
  ),
  Recipe(
    id: '5',
    name: 'Spaghetti Bolognese',
    imageUrl:
        'https://images.unsplash.com/photo-1622973536968-3ead9e780960?w=600',
    category: 'Dinner',
    ingredients: [
      '400g spaghetti',
      '500g ground beef',
      '1 onion, diced',
      '2 cloves garlic',
      '400g canned tomatoes',
      '2 tbsp tomato paste',
      'Salt, pepper, oregano',
    ],
    instructions:
        '1. Cook spaghetti according to package directions.\n'
        '2. Brown ground beef in a large pan.\n'
        '3. Add onion and garlic, cook until soft.\n'
        '4. Stir in canned tomatoes and tomato paste.\n'
        '5. Season with salt, pepper, and oregano.\n'
        '6. Simmer for 20 minutes.\n'
        '7. Serve sauce over spaghetti.',
    tags: ['Classic', 'Family'],
    prepTimeMinutes: 40,
  ),
  Recipe(
    id: '6',
    name: 'Chocolate Brownies',
    imageUrl:
        'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=600',
    category: 'Dessert',
    ingredients: [
      '½ cup butter',
      '1 cup sugar',
      '2 eggs',
      '⅓ cup cocoa powder',
      '½ cup flour',
      '¼ tsp salt',
      '¼ tsp baking powder',
    ],
    instructions:
        '1. Preheat oven to 350°F (175°C).\n'
        '2. Melt butter and mix with sugar, eggs, and vanilla.\n'
        '3. Add cocoa, flour, salt, and baking powder.\n'
        '4. Pour into a greased 8x8 pan.\n'
        '5. Bake for 25-30 minutes.\n'
        '6. Let cool before cutting.',
    tags: ['Sweet', 'Kids'],
    prepTimeMinutes: 45,
  ),
  Recipe(
    id: '7',
    name: 'Hummus & Veggies',
    imageUrl:
        'https://images.unsplash.com/photo-1505576399279-0d8e3f4b8944?w=600',
    category: 'Snacks',
    ingredients: [
      '1 can chickpeas',
      '2 tbsp tahini',
      '1 clove garlic',
      '2 tbsp lemon juice',
      '2 tbsp olive oil',
      'Carrot & cucumber sticks',
    ],
    instructions:
        '1. Blend chickpeas, tahini, garlic, lemon juice, and olive oil.\n'
        '2. Blend until smooth, adding water if needed.\n'
        '3. Serve with fresh carrot and cucumber sticks.',
    tags: ['Healthy', 'Vegan'],
    prepTimeMinutes: 10,
  ),
  Recipe(
    id: '8',
    name: 'Mango Smoothie',
    imageUrl:
        'https://images.unsplash.com/photo-1623065422902-30a2d299bbe4?w=600',
    category: 'Drinks',
    ingredients: [
      '1 cup frozen mango chunks',
      '1 banana',
      '½ cup yogurt',
      '½ cup orange juice',
      '1 tbsp honey',
    ],
    instructions:
        '1. Add all ingredients to a blender.\n'
        '2. Blend until smooth.\n'
        '3. Pour into a glass and enjoy!',
    tags: ['Quick', 'Healthy', 'Refreshing'],
    prepTimeMinutes: 5,
  ),
];
