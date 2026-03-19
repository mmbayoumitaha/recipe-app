import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'cubit/login/login_cubit.dart';
import 'cubit/recipe/recipe_cubit.dart';
import 'cubit/onboarding/onboarding_cubit.dart';
import 'models/app_user.dart';
import 'models/recipe.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(AppUserAdapter());
  try {
    await Hive.openBox<Recipe>('recipes', crashRecovery: true);
  } catch (_) {
    try {
      await Hive.deleteBoxFromDisk('recipes');
    } catch (_) {}
    await Hive.openBox<Recipe>('recipes', crashRecovery: true);
  }

  try {
    await Hive.openBox<AppUser>('users', crashRecovery: true);
  } catch (_) {
    try {
      await Hive.deleteBoxFromDisk('users');
    } catch (_) {}
    await Hive.openBox<AppUser>('users', crashRecovery: true);
  }

  try {
    await Hive.openBox('auth', crashRecovery: true);
  } catch (_) {
    try {
      await Hive.deleteBoxFromDisk('auth');
    } catch (_) {}
    await Hive.openBox('auth', crashRecovery: true);
  }

  final settingsBox = await Hive.openBox('settings');
  final onboardingCompleted = settingsBox.get(
    'onboarding_completed',
    defaultValue: false,
  );

  final authBox = Hive.box('auth');
  final loggedIn = authBox.get('loggedIn') == true;

  Widget startScreen;
  if (!onboardingCompleted) {
    startScreen = const OnboardingScreen();
  } else if (loggedIn) {
    startScreen = const HomeScreen();
  } else {
    startScreen = const LoginScreen();
  }

  runApp(RecipeApp(startScreen: startScreen));
}

class RecipeApp extends StatelessWidget {
  final Widget startScreen;

  const RecipeApp({super.key, required this.startScreen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnboardingCubit()),
        BlocProvider(create: (_) => LoginCubit()),
        BlocProvider(create: (_) => RecipeCubit()),
      ],
      child: MaterialApp(
        title: 'CookCraft',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: startScreen,
      ),
    );
  }
}
