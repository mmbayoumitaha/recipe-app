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
  Recipe(
    id: '9',
    name: 'Shakshuka',
    imageUrl:
        'https://images.unsplash.com/photo-1604908176997-125f25cc500e?w=600',
    category: 'Breakfast',
    ingredients: [
      '2 tbsp olive oil',
      '1 onion, diced',
      '1 red bell pepper, diced',
      '2 cloves garlic, minced',
      '1 tsp cumin',
      '1 tsp paprika',
      '1 can crushed tomatoes',
      '4 eggs',
      'Salt & pepper',
    ],
    instructions:
        '1. Sauté onion and pepper in olive oil until soft.\n'
        '2. Add garlic, cumin, and paprika; cook 1 minute.\n'
        '3. Stir in tomatoes and simmer 10 minutes.\n'
        '4. Make wells and crack in eggs.\n'
        '5. Cover and cook until eggs set.\n'
        '6. Season and serve with bread.',
    tags: ['Savory', 'One-pan'],
    prepTimeMinutes: 25,
  ),
  Recipe(
    id: '10',
    name: 'Greek Yogurt Parfait',
    imageUrl:
        'https://images.unsplash.com/photo-1511690743698-d9d85f2fbf38?w=600',
    category: 'Breakfast',
    ingredients: [
      '1 cup Greek yogurt',
      '½ cup granola',
      '½ cup berries',
      '1 tbsp honey',
    ],
    instructions:
        '1. Layer yogurt, granola, and berries in a glass.\n'
        '2. Drizzle with honey.\n'
        '3. Serve immediately.',
    tags: ['Quick', 'Healthy'],
    prepTimeMinutes: 5,
  ),
  Recipe(
    id: '11',
    name: 'Chicken Shawarma Wrap',
    imageUrl:
        'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?w=600',
    category: 'Lunch',
    ingredients: [
      '2 chicken breasts, sliced',
      '2 tbsp yogurt',
      '1 tbsp lemon juice',
      '2 tsp shawarma spice',
      'Salt',
      'Pita bread',
      'Garlic sauce',
      'Pickles',
    ],
    instructions:
        '1. Marinate chicken with yogurt, lemon, spices, and salt for 15 minutes.\n'
        '2. Sear in a hot pan until cooked through.\n'
        '3. Fill pita with chicken, sauce, and pickles.\n'
        '4. Wrap and serve.',
    tags: ['Middle Eastern', 'Street Food'],
    prepTimeMinutes: 25,
  ),
  Recipe(
    id: '12',
    name: 'Tuna Salad Bowl',
    imageUrl:
        'https://images.unsplash.com/photo-1523986371872-9d3ba2e2f5f8?w=600',
    category: 'Lunch',
    ingredients: [
      '1 can tuna, drained',
      '1 tbsp mayonnaise',
      '1 tsp mustard',
      '1 celery stalk, chopped',
      'Salt & pepper',
      'Mixed greens',
    ],
    instructions:
        '1. Mix tuna with mayo, mustard, celery, salt, and pepper.\n'
        '2. Serve over mixed greens.',
    tags: ['High Protein', 'Quick'],
    prepTimeMinutes: 10,
  ),
  Recipe(
    id: '13',
    name: 'Tomato Basil Soup',
    imageUrl:
        'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=600',
    category: 'Dinner',
    ingredients: [
      '1 tbsp olive oil',
      '1 onion, chopped',
      '2 cloves garlic',
      '1 can tomatoes',
      '2 cups vegetable broth',
      'Fresh basil',
      'Salt & pepper',
    ],
    instructions:
        '1. Sauté onion and garlic in olive oil.\n'
        '2. Add tomatoes and broth, simmer 15 minutes.\n'
        '3. Blend until smooth.\n'
        '4. Stir in basil and season.',
    tags: ['Comfort', 'Vegetarian'],
    prepTimeMinutes: 25,
  ),
  Recipe(
    id: '14',
    name: 'Baked Salmon & Lemon',
    imageUrl:
        'https://images.unsplash.com/photo-1467003909585-2f8a72700288?w=600',
    category: 'Dinner',
    ingredients: [
      '2 salmon fillets',
      '1 lemon, sliced',
      '1 tbsp olive oil',
      'Salt & pepper',
      'Dill (optional)',
    ],
    instructions:
        '1. Preheat oven to 200°C.\n'
        '2. Place salmon on a tray, drizzle olive oil, season.\n'
        '3. Top with lemon slices.\n'
        '4. Bake 12-15 minutes until flaky.',
    tags: ['Healthy', 'Seafood'],
    prepTimeMinutes: 20,
  ),
  Recipe(
    id: '15',
    name: 'Vegetable Stir-Fry',
    imageUrl:
        'https://images.unsplash.com/photo-1512058564366-c9e3e0464b19?w=600',
    category: 'Dinner',
    ingredients: [
      '2 cups mixed vegetables',
      '2 tbsp soy sauce',
      '1 tbsp sesame oil',
      '1 tsp ginger, minced',
      '1 clove garlic',
      'Cooked rice',
    ],
    instructions:
        '1. Heat sesame oil in a wok.\n'
        '2. Add ginger and garlic for 30 seconds.\n'
        '3. Stir-fry vegetables until crisp-tender.\n'
        '4. Add soy sauce and toss.\n'
        '5. Serve over rice.',
    tags: ['Vegan', 'Quick'],
    prepTimeMinutes: 20,
  ),
  Recipe(
    id: '16',
    name: 'Beef Tacos',
    imageUrl:
        'https://images.unsplash.com/photo-1552332386-f8dd00dc2f85?w=600',
    category: 'Dinner',
    ingredients: [
      '300g ground beef',
      'Taco seasoning',
      'Tortillas',
      'Lettuce, shredded',
      'Tomato, diced',
      'Cheddar, grated',
      'Salsa',
    ],
    instructions:
        '1. Cook beef in a skillet and add seasoning.\n'
        '2. Warm tortillas.\n'
        '3. Assemble with beef, lettuce, tomato, cheese, and salsa.',
    tags: ['Family', 'Mexican'],
    prepTimeMinutes: 25,
  ),
  Recipe(
    id: '17',
    name: 'Classic Cheesecake Cups',
    imageUrl:
        'https://images.unsplash.com/photo-1551024601-bec78aea704b?w=600',
    category: 'Dessert',
    ingredients: [
      '200g cream cheese',
      '2 tbsp sugar',
      '½ tsp vanilla',
      '½ cup whipped cream',
      'Crushed biscuits',
    ],
    instructions:
        '1. Beat cream cheese, sugar, and vanilla until smooth.\n'
        '2. Fold in whipped cream.\n'
        '3. Layer with crushed biscuits in cups.\n'
        '4. Chill 1 hour.',
    tags: ['No-bake', 'Sweet'],
    prepTimeMinutes: 15,
  ),
  Recipe(
    id: '18',
    name: 'Fruit Salad',
    imageUrl:
        'https://images.unsplash.com/photo-1490474418585-ba9bad8fd0ea?w=600',
    category: 'Dessert',
    ingredients: [
      '2 cups mixed fruit',
      '1 tbsp honey',
      '1 tbsp lemon juice',
      'Mint (optional)',
    ],
    instructions:
        '1. Combine fruit in a bowl.\n'
        '2. Mix honey with lemon juice and drizzle.\n'
        '3. Toss gently and serve.',
    tags: ['Healthy', 'Vegan'],
    prepTimeMinutes: 10,
  ),
  Recipe(
    id: '19',
    name: 'Popcorn Seasoning Mix',
    imageUrl:
        'https://images.unsplash.com/photo-1497034825429-c343d7c6a68f?w=600',
    category: 'Snacks',
    ingredients: [
      '5 cups popcorn',
      '1 tbsp melted butter',
      'Salt',
      'Paprika',
      'Garlic powder',
    ],
    instructions:
        '1. Toss popcorn with melted butter.\n'
        '2. Sprinkle seasonings and toss again.',
    tags: ['Movie Night', 'Quick'],
    prepTimeMinutes: 5,
  ),
  Recipe(
    id: '20',
    name: 'Energy Balls',
    imageUrl:
        'https://images.unsplash.com/photo-1546554137-f86b9593a222?w=600',
    category: 'Snacks',
    ingredients: [
      '1 cup oats',
      '½ cup peanut butter',
      '⅓ cup honey',
      '2 tbsp cocoa',
      '2 tbsp chia seeds',
    ],
    instructions:
        '1. Mix all ingredients in a bowl.\n'
        '2. Roll into small balls.\n'
        '3. Chill 30 minutes.',
    tags: ['Healthy', 'No-bake'],
    prepTimeMinutes: 15,
  ),
  Recipe(
    id: '21',
    name: 'Iced Coffee',
    imageUrl:
        'https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=600',
    category: 'Drinks',
    ingredients: [
      '1 cup brewed coffee, cooled',
      'Ice cubes',
      'Milk',
      'Sugar or syrup (optional)',
    ],
    instructions:
        '1. Fill a glass with ice.\n'
        '2. Pour coffee and add milk.\n'
        '3. Sweeten if desired and stir.',
    tags: ['Coffee', 'Refreshing'],
    prepTimeMinutes: 5,
  ),
  Recipe(
    id: '22',
    name: 'Mint Lemonade',
    imageUrl:
        'https://images.unsplash.com/photo-1528823872057-9c018a7b6f9b?w=600',
    category: 'Drinks',
    ingredients: [
      '3 lemons, juiced',
      '3 cups cold water',
      '2 tbsp sugar (or to taste)',
      'Fresh mint',
      'Ice',
    ],
    instructions:
        '1. Mix lemon juice with sugar until dissolved.\n'
        '2. Add water, mint, and ice.\n'
        '3. Serve cold.',
    tags: ['Summer', 'Refreshing'],
    prepTimeMinutes: 10,
  ),
  Recipe(
    id: '23',
    name: 'Caprese Sandwich',
    imageUrl:
        'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=600',
    category: 'Lunch',
    ingredients: [
      'Ciabatta bread',
      'Fresh mozzarella',
      'Tomato slices',
      'Basil leaves',
      'Olive oil',
      'Balsamic glaze',
      'Salt & pepper',
    ],
    instructions:
        '1. Slice bread and layer mozzarella, tomato, and basil.\n'
        '2. Drizzle olive oil and balsamic.\n'
        '3. Season and serve.',
    tags: ['Italian', 'Vegetarian'],
    prepTimeMinutes: 10,
  ),
  Recipe(
    id: '24',
    name: 'Garlic Butter Shrimp',
    imageUrl:
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600',
    category: 'Dinner',
    ingredients: [
      '400g shrimp, peeled',
      '2 tbsp butter',
      '3 cloves garlic, minced',
      'Salt & pepper',
      'Parsley',
      'Lemon wedges',
    ],
    instructions:
        '1. Melt butter in a pan and sauté garlic 30 seconds.\n'
        '2. Add shrimp and cook 2-3 minutes per side.\n'
        '3. Season, garnish with parsley, and serve with lemon.',
    tags: ['Seafood', 'Quick'],
    prepTimeMinutes: 15,
  ),
  Recipe(
    id: '25',
    name: 'Banana Bread',
    imageUrl:
        'https://images.unsplash.com/photo-1559628233-100c798642d4?w=600',
    category: 'Dessert',
    ingredients: [
      '3 ripe bananas, mashed',
      '2 eggs',
      '⅓ cup melted butter',
      '½ cup sugar',
      '1½ cups flour',
      '1 tsp baking soda',
      'Pinch of salt',
    ],
    instructions:
        '1. Preheat oven to 175°C.\n'
        '2. Mix bananas, eggs, butter, and sugar.\n'
        '3. Fold in flour, baking soda, and salt.\n'
        '4. Bake 45-55 minutes until a toothpick comes out clean.',
    tags: ['Baking', 'Classic'],
    prepTimeMinutes: 60,
  ),
];
