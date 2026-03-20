import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../models/recipe_category.dart';

const List<RecipeCategory> appCategories = [
  RecipeCategory(name: 'Breakfast', emoji: '🍳', color: Color(0xFFFF9E80)),
  RecipeCategory(name: 'Lunch', emoji: '🥗', color: Color(0xFF81C784)),
  RecipeCategory(name: 'Dinner', emoji: '🍝', color: Color(0xFFFF8A65)),
  RecipeCategory(name: 'Dessert', emoji: '🍰', color: Color(0xFFF06292)),
  RecipeCategory(name: 'Drinks', emoji: '🍹', color: Color(0xFF4FC3F7)),
  RecipeCategory(name: 'Snacks', emoji: '🥨', color: Color(0xFFBA68C8)),
];

final List<Recipe> sampleRecipes = [
  Recipe(
    id: 's1',
    name: 'Strawberry Pancakes',
    imageUrl:
        'https://images.unsplash.com/photo-1567620905732-2d1ec7ab7445?w=600&q=80',
    category: 'Breakfast',
    prepTimeMinutes: 20,
    tags: ['Easy', 'Fruity', 'Kids'],
    ingredients: [
      '1½ cups flour',
      '3½ tsp baking powder',
      '1 tbsp sugar',
      '1¼ cups milk',
      '1 egg',
      '3 tbsp melted butter',
      '1 cup sliced strawberries',
    ],
    instructions:
        '1. Mix dry ingredients in a bowl.\n'
        '2. Make a well in the center and pour in milk, egg, and melted butter.\n'
        '3. Mix until smooth.\n'
        '4. Heat a griddle over medium-high heat.\n'
        '5. Pour batter onto the griddle, using about ¼ cup for each pancake.\n'
        '6. Cook until bubbles appear, then flip until golden.\n'
        '7. Top with sliced strawberries and serve.',
  ),
  Recipe(
    id: 's2',
    name: 'Berry Yogurt Parfait',
    imageUrl:
        'https://images.unsplash.com/photo-1488477181946-6428a0291777?w=600&q=80',
    category: 'Breakfast',
    prepTimeMinutes: 5,
    tags: ['Healthy', 'Quick'],
    ingredients: [
      '1 cup Greek yogurt',
      '½ cup granola',
      '½ cup mixed berries',
      '1 tbsp honey',
    ],
    instructions:
        '1. Layer yogurt in the bottom of a glass.\n'
        '2. Add a layer of granola.\n'
        '3. Top with mixed berries.\n'
        '4. Drizzle with honey and serve immediately.',
  ),
  Recipe(
    id: 's3',
    name: 'Garden Salad',
    imageUrl:
        'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=600&q=80',
    category: 'Lunch',
    prepTimeMinutes: 10,
    tags: ['Vegan', 'Healthy'],
    ingredients: [
      '2 cups mixed green leaves',
      '1 cucumber, sliced',
      '2 tomatoes, chopped',
      '1 carrot, grated',
      '2 tbsp olive oil',
      '1 tbsp lemon juice',
      'Salt & pepper',
    ],
    instructions:
        '1. Wash and dry all vegetables.\n'
        '2. Combine greens, cucumber, tomato, and carrot in a bowl.\n'
        '3. Drizzle with olive oil and lemon juice.\n'
        '4. Season with salt and pepper, toss and serve.',
  ),
  Recipe(
    id: 's4',
    name: 'Tomato Pasta',
    imageUrl:
        'https://images.unsplash.com/photo-1598866594230-a7c12756260f?w=600&q=80',
    category: 'Dinner',
    prepTimeMinutes: 25,
    tags: ['Italian', 'Classic'],
    ingredients: [
      '400g pasta',
      '2 cups tomato sauce',
      '2 cloves garlic, minced',
      '1 tbsp olive oil',
      'Fresh basil',
      'Salt & pepper',
      'Parmesan to serve',
    ],
    instructions:
        '1. Cook pasta according to package directions until al dente.\n'
        '2. Heat olive oil in a pan and sauté garlic 1 minute.\n'
        '3. Add tomato sauce and simmer 10 minutes.\n'
        '4. Season with salt and pepper.\n'
        '5. Toss with pasta, top with basil and parmesan.',
  ),
  Recipe(
    id: 's5',
    name: 'Green Smoothie',
    imageUrl:
        'https://images.unsplash.com/photo-1610970881699-44a5587cabec?w=600&q=80',
    category: 'Drinks',
    prepTimeMinutes: 5,
    tags: ['Healthy', 'Vegan', 'Quick'],
    ingredients: [
      '1 cup fresh spinach',
      '1 apple, chopped',
      '1 banana',
      '1 cup cold water',
      '1 tbsp lemon juice',
      'Ice cubes',
    ],
    instructions:
        '1. Add spinach and water to blender first.\n'
        '2. Add apple, banana, and lemon juice.\n'
        '3. Blend until completely smooth.\n'
        '4. Add ice and blend again.\n'
        '5. Pour and serve immediately.',
  ),
  Recipe(
    id: 's6',
    name: 'Cheese Plate',
    imageUrl:
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&q=80',
    category: 'Snacks',
    prepTimeMinutes: 10,
    tags: ['Quick', 'Party'],
    ingredients: [
      '100g cheddar cheese',
      '100g brie cheese',
      '100g blue cheese',
      'Assorted crackers',
      'Grapes',
      'Walnuts',
      'Honey',
    ],
    instructions:
        '1. Arrange cheeses on a wooden board.\n'
        '2. Add crackers around the cheeses.\n'
        '3. Fill gaps with grapes and walnuts.\n'
        '4. Drizzle honey over brie.\n'
        '5. Serve at room temperature.',
  ),
  Recipe(
    id: 's7',
    name: 'Grilled Steak',
    imageUrl:
        'https://images.unsplash.com/photo-1558030006-450675393462?w=600&q=80',
    category: 'Dinner',
    prepTimeMinutes: 30,
    tags: ['Meat', 'Premium'],
    ingredients: [
      '2 ribeye steaks (300g each)',
      '2 tsp salt',
      '1 tsp black pepper',
      '2 cloves garlic',
      '2 tbsp butter',
      'Fresh rosemary',
      '1 tbsp olive oil',
    ],
    instructions:
        '1. Take steak out of fridge 30 minutes before cooking.\n'
        '2. Season generously with salt and pepper on both sides.\n'
        '3. Heat a cast iron pan over high heat.\n'
        '4. Drizzle olive oil and sear steak 3-4 minutes per side.\n'
        '5. Add butter, garlic, and rosemary to pan.\n'
        '6. Baste steak with melted butter for 1 minute.\n'
        '7. Rest 5 minutes before serving.',
  ),
  Recipe(
    id: 's8',
    name: 'Avocado Egg Toast',
    imageUrl:
        'https://images.unsplash.com/photo-1525351484163-7529414344d8?w=600&q=80',
    category: 'Breakfast',
    prepTimeMinutes: 10,
    tags: ['Healthy', 'Quick'],
    ingredients: [
      '2 slices sourdough bread',
      '1 ripe avocado',
      '2 eggs',
      'Salt & pepper',
      'Red pepper flakes',
      '1 tsp lemon juice',
    ],
    instructions:
        '1. Toast bread slices until golden and crisp.\n'
        '2. Mash avocado with lemon juice, salt, and pepper.\n'
        '3. Fry or poach eggs to your liking.\n'
        '4. Spread mashed avocado on toast.\n'
        '5. Top with egg and red pepper flakes.',
  ),
  Recipe(
    id: 's9',
    name: 'Popcorn',
    imageUrl:
        'https://images.unsplash.com/photo-1585647347483-22b66260dfff?w=600&q=80',
    category: 'Snacks',
    prepTimeMinutes: 5,
    tags: ['Movie Night', 'Quick', 'Kids'],
    ingredients: [
      '½ cup popcorn kernels',
      '2 tbsp butter',
      '½ tsp salt',
      '½ tsp paprika (optional)',
    ],
    instructions:
        '1. Heat a large pot over medium-high heat.\n'
        '2. Add kernels and cover with lid.\n'
        '3. Shake pot as kernels pop.\n'
        '4. Remove from heat when popping slows.\n'
        '5. Drizzle melted butter and season with salt.',
  ),
  Recipe(
    id: 's10',
    name: 'Classic Pizza',
    imageUrl:
        'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?w=600&q=80',
    category: 'Dinner',
    prepTimeMinutes: 40,
    tags: ['Party', 'Family', 'Italian'],
    ingredients: [
      '1 pizza dough ball',
      '½ cup tomato sauce',
      '200g mozzarella, shredded',
      'Pepperoni slices',
      '1 tsp dried oregano',
      '1 tbsp olive oil',
    ],
    instructions:
        '1. Preheat oven to 220°C.\n'
        '2. Stretch dough on a floured surface.\n'
        '3. Spread tomato sauce leaving a border.\n'
        '4. Top with mozzarella and pepperoni.\n'
        '5. Drizzle olive oil and sprinkle oregano.\n'
        '6. Bake 12-15 minutes until crust is golden.',
  ),
  Recipe(
    id: 's11',
    name: 'Tuna Salad Bowl',
    imageUrl:
        'https://images.unsplash.com/photo-1607532941433-304659e8198a?w=600&q=80',
    category: 'Lunch',
    prepTimeMinutes: 15,
    tags: ['High Protein', 'Quick', 'Healthy'],
    ingredients: [
      '1 can tuna, drained',
      '1 tbsp mayonnaise',
      '1 tsp mustard',
      '1 celery stalk, chopped',
      'Salt & pepper',
      'Mixed greens',
      'Cherry tomatoes',
    ],
    instructions:
        '1. Drain tuna and flake into a bowl.\n'
        '2. Mix with mayo, mustard, and celery.\n'
        '3. Season with salt and pepper.\n'
        '4. Serve over a bed of mixed greens.\n'
        '5. Garnish with cherry tomatoes.',
  ),
  Recipe(
    id: 's12',
    name: 'Tasty Burger',
    imageUrl:
        'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=600&q=80',
    category: 'Dinner',
    prepTimeMinutes: 20,
    tags: ['Classic', 'Family'],
    ingredients: [
      '400g ground beef',
      '2 burger buns',
      'Lettuce leaves',
      '2 tomato slices',
      '2 cheddar slices',
      'Salt & pepper',
      'Ketchup & mustard',
    ],
    instructions:
        '1. Season beef with salt and pepper and form into patties.\n'
        '2. Heat grill or pan over high heat.\n'
        '3. Cook patties 3-4 minutes per side.\n'
        '4. Add cheese in last minute of cooking.\n'
        '5. Toast buns and assemble with toppings.',
  ),
  Recipe(
    id: 's13',
    name: 'Orange Juice',
    imageUrl:
        'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?w=600&q=80',
    category: 'Drinks',
    prepTimeMinutes: 5,
    tags: ['Fresh', 'Healthy', 'Quick'],
    ingredients: [
      '6 large oranges',
      'Ice cubes',
      '1 tsp honey (optional)',
      'Mint for garnish',
    ],
    instructions:
        '1. Roll oranges on the counter to soften.\n'
        '2. Cut in half and juice each orange.\n'
        '3. Strain to remove seeds and pulp if desired.\n'
        '4. Pour over ice and add honey if using.\n'
        '5. Garnish with mint and serve immediately.',
  ),
  Recipe(
    id: 's14',
    name: 'Fruit Mix',
    imageUrl:
        'https://images.unsplash.com/photo-1490474418585-ba9bad8fd0ea?w=600&q=80',
    category: 'Dessert',
    prepTimeMinutes: 10,
    tags: ['Sweet', 'Healthy', 'Vegan'],
    ingredients: [
      '1 apple, cubed',
      '1 cup green grapes',
      '1 cup pineapple chunks',
      '1 cup strawberries, halved',
      '1 tbsp honey',
      '1 tbsp lemon juice',
      'Fresh mint',
    ],
    instructions:
        '1. Combine all fruit in a large bowl.\n'
        '2. Mix honey with lemon juice and drizzle over.\n'
        '3. Toss gently to coat.\n'
        '4. Garnish with fresh mint.\n'
        '5. Serve immediately or chill 15 minutes.',
  ),
  Recipe(
    id: 's15',
    name: 'Waffles',
    imageUrl:
        'https://images.unsplash.com/photo-1562376552-0d160a2f238d?w=600&q=80',
    category: 'Breakfast',
    prepTimeMinutes: 20,
    tags: ['Yummy', 'Kids', 'Weekend'],
    ingredients: [
      '2 cups flour',
      '2 tsp baking powder',
      '½ tsp salt',
      '2 tbsp sugar',
      '2 eggs',
      '1¾ cups milk',
      '½ cup melted butter',
      'Maple syrup to serve',
    ],
    instructions:
        '1. Mix flour, baking powder, salt, and sugar.\n'
        '2. Whisk eggs, milk, and butter together.\n'
        '3. Combine wet and dry ingredients until just mixed.\n'
        '4. Heat and grease waffle maker.\n'
        '5. Pour batter and cook until golden.\n'
        '6. Serve with maple syrup and butter.',
  ),
  Recipe(
    id: 's16',
    name: 'Veggie Chips',
    imageUrl:
        'https://images.unsplash.com/photo-1528712306091-ed0763094c98?w=600&q=80',
    category: 'Snacks',
    prepTimeMinutes: 40,
    tags: ['Healthy', 'Vegan', 'Baked'],
    ingredients: [
      '2 large sweet potatoes',
      '1 tbsp olive oil',
      '½ tsp salt',
      '½ tsp paprika',
      '¼ tsp garlic powder',
    ],
    instructions:
        '1. Preheat oven to 190°C.\n'
        '2. Slice sweet potatoes very thin using a mandoline.\n'
        '3. Toss with olive oil and seasonings.\n'
        '4. Arrange in a single layer on baking sheets.\n'
        '5. Bake 20-25 minutes, flipping halfway through.\n'
        '6. Cool on rack — they crisp up as they cool.',
  ),
  Recipe(
    id: 's17',
    name: 'Beef Stew',
    imageUrl:
        'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=600&q=80',
    category: 'Dinner',
    prepTimeMinutes: 120,
    tags: ['Comfort', 'Family', 'Warm'],
    ingredients: [
      '700g beef chuck, cubed',
      '3 potatoes, cubed',
      '3 carrots, sliced',
      '1 onion, diced',
      '2 cloves garlic',
      '2 cups beef broth',
      '2 tbsp tomato paste',
      'Salt, pepper, thyme',
    ],
    instructions:
        '1. Brown beef in batches in a large pot.\n'
        '2. Sauté onion and garlic until soft.\n'
        '3. Add tomato paste and cook 1 minute.\n'
        '4. Return beef and add broth and thyme.\n'
        '5. Bring to boil, then simmer covered 1 hour.\n'
        '6. Add potatoes and carrots.\n'
        '7. Simmer another 30 minutes until tender.',
  ),
  Recipe(
    id: 's18',
    name: 'Sushi Pack',
    imageUrl:
        'https://images.unsplash.com/photo-1559410545-0bdcd187e0a6?w=600&q=80',
    category: 'Lunch',
    prepTimeMinutes: 45,
    tags: ['Japanese', 'Healthy'],
    ingredients: [
      '2 cups sushi rice',
      '4 nori sheets',
      '200g fresh salmon, sliced',
      '1 avocado, sliced',
      '1 cucumber, julienned',
      '3 tbsp rice vinegar',
      'Soy sauce & wasabi to serve',
    ],
    instructions:
        '1. Cook sushi rice and season with rice vinegar.\n'
        '2. Place nori on bamboo mat, shiny side down.\n'
        '3. Spread rice evenly, leaving 2cm at top.\n'
        '4. Lay salmon, avocado, and cucumber in a line.\n'
        '5. Roll tightly using the mat.\n'
        '6. Slice with a wet sharp knife.\n'
        '7. Serve with soy sauce and wasabi.',
  ),
  Recipe(
    id: 's19',
    name: 'Fried Chicken',
    imageUrl:
        'https://images.unsplash.com/photo-1606755962773-d324e0a13086?w=600&q=80',
    category: 'Dinner',
    prepTimeMinutes: 40,
    tags: ['Crunchy', 'Family', 'Kids'],
    ingredients: [
      '1kg chicken pieces',
      '1 cup flour',
      '1 tsp garlic powder',
      '1 tsp paprika',
      '1 tsp salt',
      '½ tsp pepper',
      '2 eggs, beaten',
      'Oil for frying',
    ],
    instructions:
        '1. Mix flour with garlic powder, paprika, salt, and pepper.\n'
        '2. Dip chicken in egg then coat in seasoned flour.\n'
        '3. Heat oil to 175°C in a deep pan.\n'
        '4. Fry chicken in batches for 12-15 minutes.\n'
        '5. Drain on paper towels.\n'
        '6. Rest 5 minutes before serving.',
  ),
  Recipe(
    id: 's20',
    name: 'Muesli Bowl',
    imageUrl:
        'https://images.unsplash.com/photo-1495214783159-3503fd1b572d?w=600&q=80',
    category: 'Breakfast',
    prepTimeMinutes: 5,
    tags: ['Healthy', 'Quick', 'Vegan'],
    ingredients: [
      '1 cup rolled oats',
      '¼ cup mixed nuts',
      '¼ cup dried fruit',
      '1 cup almond milk',
      '1 tbsp honey',
      'Fresh berries to top',
    ],
    instructions:
        '1. Combine oats, nuts, and dried fruit in a bowl.\n'
        '2. Pour almond milk over the mixture.\n'
        '3. Drizzle with honey.\n'
        '4. Top with fresh berries.\n'
        '5. Let sit 2 minutes and serve.',
  ),
  Recipe(
    id: 's21',
    name: 'Burrito',
    imageUrl:
        'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?w=600&q=80',
    category: 'Lunch',
    prepTimeMinutes: 15,
    tags: ['Mexican', 'Street Food'],
    ingredients: [
      '2 large flour tortillas',
      '1 cup cooked rice',
      '1 can black beans, drained',
      '200g grilled chicken, sliced',
      '½ cup cheddar, grated',
      'Salsa & sour cream',
      'Lettuce & tomato',
    ],
    instructions:
        '1. Warm tortillas in a dry pan.\n'
        '2. Spread rice in the center of each tortilla.\n'
        '3. Add beans, chicken, and cheese.\n'
        '4. Top with salsa, sour cream, lettuce, and tomato.\n'
        '5. Fold sides in and roll tightly.\n'
        '6. Slice in half and serve.',
  ),
  Recipe(
    id: 's22',
    name: 'Mocha',
    imageUrl:
        'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=600&q=80',
    category: 'Drinks',
    prepTimeMinutes: 5,
    tags: ['Coffee', 'Warm', 'Cozy'],
    ingredients: [
      '1 shot espresso',
      '1 tbsp cocoa powder',
      '1 tbsp sugar',
      '200ml steamed milk',
      'Whipped cream',
    ],
    instructions:
        '1. Mix cocoa powder and sugar in a mug.\n'
        '2. Add hot espresso and stir until dissolved.\n'
        '3. Steam milk until frothy.\n'
        '4. Pour milk over the coffee mixture.\n'
        '5. Top with whipped cream and serve.',
  ),
  Recipe(
    id: 's23',
    name: 'Nachos',
    imageUrl:
        'https://images.unsplash.com/photo-1513456852971-30c0b8199d4d?w=600&q=80',
    category: 'Snacks',
    prepTimeMinutes: 10,
    tags: ['Party', 'Cheese', 'Mexican'],
    ingredients: [
      '200g tortilla chips',
      '1½ cups cheddar, grated',
      '½ cup salsa',
      '¼ cup jalapeños',
      '½ cup sour cream',
      'Guacamole',
      'Spring onions',
    ],
    instructions:
        '1. Preheat oven to 200°C.\n'
        '2. Spread chips in a single layer on a tray.\n'
        '3. Sprinkle cheese evenly over chips.\n'
        '4. Add jalapeños on top.\n'
        '5. Bake 8-10 minutes until cheese melts.\n'
        '6. Top with salsa, sour cream, and guacamole.',
  ),
  Recipe(
    id: 's24',
    name: 'Fish & Chips',
    imageUrl:
        'https://images.unsplash.com/photo-1519984388953-d2406bc725e1?w=600&q=80',
    category: 'Dinner',
    prepTimeMinutes: 30,
    tags: ['British', 'Classic', 'Crispy'],
    ingredients: [
      '4 white fish fillets',
      '1 cup flour',
      '1 tsp baking powder',
      '1 cup cold beer',
      '4 large potatoes, cut into chips',
      'Oil for frying',
      'Salt & malt vinegar',
    ],
    instructions:
        '1. Parboil potato chips for 5 minutes, drain and dry.\n'
        '2. Mix flour, baking powder, and beer into a batter.\n'
        '3. Fry chips at 160°C for 5 minutes, set aside.\n'
        '4. Dip fish in batter and fry at 190°C until golden.\n'
        '5. Finish chips at 190°C until crispy.\n'
        '6. Season and serve with malt vinegar.',
  ),
  Recipe(
    id: 's25',
    name: 'Apple Pie',
    imageUrl:
        'https://images.unsplash.com/photo-1568571780765-9276ac8b75a2?w=600&q=80',
    category: 'Dessert',
    prepTimeMinutes: 90,
    tags: ['Classic', 'Sweet', 'Baking'],
    ingredients: [
      '2 pie crusts (top & bottom)',
      '6 apples, peeled and sliced',
      '¾ cup sugar',
      '2 tsp cinnamon',
      '¼ tsp nutmeg',
      '2 tbsp flour',
      '1 tbsp butter',
      '1 egg (for wash)',
    ],
    instructions:
        '1. Preheat oven to 190°C.\n'
        '2. Mix apples with sugar, cinnamon, nutmeg, and flour.\n'
        '3. Line pie dish with bottom crust.\n'
        '4. Fill with apple mixture and dot with butter.\n'
        '5. Cover with top crust, crimp edges, and cut vents.\n'
        '6. Brush with egg wash.\n'
        '7. Bake 45-50 minutes until golden.',
  ),
  Recipe(
    id: 's26',
    name: 'Lemon Tea',
    imageUrl:
        'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=600&q=80',
    category: 'Drinks',
    prepTimeMinutes: 5,
    tags: ['Hot', 'Soothing', 'Quick'],
    ingredients: [
      '2 black tea bags',
      '2 cups boiling water',
      '1 lemon, sliced',
      '2 tsp honey',
      'Fresh mint (optional)',
    ],
    instructions:
        '1. Steep tea bags in boiling water for 3-4 minutes.\n'
        '2. Remove tea bags and add lemon slices.\n'
        '3. Stir in honey until dissolved.\n'
        '4. Add mint if using.\n'
        '5. Serve hot.',
  ),
  Recipe(
    id: 's27',
    name: 'Chicken Wings',
    imageUrl:
        'https://images.unsplash.com/photo-1567620832903-9fc6debc209f?w=600&q=80',
    category: 'Snacks',
    prepTimeMinutes: 20,
    tags: ['Spicy', 'Party', 'Game Night'],
    ingredients: [
      '1kg chicken wings',
      '3 tbsp hot sauce',
      '2 tbsp butter',
      '1 tsp garlic powder',
      '1 tsp salt',
      '½ tsp cayenne pepper',
      'Blue cheese dip to serve',
    ],
    instructions:
        '1. Pat wings dry and season with salt, garlic powder, and cayenne.\n'
        '2. Bake at 220°C for 40 minutes, flipping halfway.\n'
        '3. Melt butter and mix with hot sauce.\n'
        '4. Toss baked wings in sauce.\n'
        '5. Serve immediately with blue cheese dip.',
  ),
  Recipe(
    id: 's28',
    name: 'Lamb Chops',
    imageUrl:
        'https://images.unsplash.com/photo-1611599537845-1c7aca0091c0?w=600&q=80',
    category: 'Dinner',
    prepTimeMinutes: 40,
    tags: ['Premium', 'Special Occasion'],
    ingredients: [
      '4 lamb chops',
      '3 cloves garlic, minced',
      '2 tbsp fresh rosemary',
      '2 tbsp olive oil',
      '1 tbsp lemon juice',
      'Salt & black pepper',
    ],
    instructions:
        '1. Mix garlic, rosemary, olive oil, and lemon juice.\n'
        '2. Rub marinade over lamb chops.\n'
        '3. Marinate at least 20 minutes.\n'
        '4. Heat a pan over high heat until very hot.\n'
        '5. Sear chops 3-4 minutes per side for medium.\n'
        '6. Rest 5 minutes before serving.',
  ),
  Recipe(
    id: 's29',
    name: 'Chocolate Cake',
    imageUrl:
        'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=600&q=80',
    category: 'Dessert',
    prepTimeMinutes: 60,
    tags: ['Special Occasion', 'Sweet', 'Baking'],
    ingredients: [
      '2 cups flour',
      '2 cups sugar',
      '¾ cup cocoa powder',
      '2 tsp baking soda',
      '1 cup buttermilk',
      '1 cup hot coffee',
      '½ cup vegetable oil',
      '2 eggs',
    ],
    instructions:
        '1. Preheat oven to 175°C.\n'
        '2. Combine all dry ingredients in a large bowl.\n'
        '3. Whisk together buttermilk, coffee, oil, and eggs.\n'
        '4. Mix wet into dry until smooth.\n'
        '5. Pour into 2 greased 9-inch cake pans.\n'
        '6. Bake 30-35 minutes until toothpick is clean.\n'
        '7. Cool completely before frosting.',
  ),
  Recipe(
    id: 's30',
    name: 'Roasted Veggies',
    imageUrl:
        'https://images.unsplash.com/photo-1543339308-43e59d6b73a6?w=600&q=80',
    category: 'Lunch',
    prepTimeMinutes: 30,
    tags: ['Vegan', 'Healthy', 'Easy'],
    ingredients: [
      '2 large carrots, chopped',
      '3 potatoes, cubed',
      '1 zucchini, sliced',
      '1 red bell pepper, chopped',
      '3 tbsp olive oil',
      '1 tsp garlic powder',
      'Salt, pepper, thyme',
    ],
    instructions:
        '1. Preheat oven to 200°C.\n'
        '2. Chop all vegetables into similar-sized pieces.\n'
        '3. Toss with olive oil, garlic powder, and seasoning.\n'
        '4. Spread in a single layer on baking sheet.\n'
        '5. Roast 25-30 minutes, tossing halfway through.\n'
        '6. Serve hot as a side or main.',
  ),
];
