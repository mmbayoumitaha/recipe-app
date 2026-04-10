import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'cubit/login/login_cubit.dart';
import 'cubit/login/login_state.dart';
import 'cubit/recipe/recipe_cubit.dart';
import 'cubit/onboarding/onboarding_cubit.dart';
import 'cubit/theme/theme_cubit.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/recipe_repository.dart';
import 'models/app_user.dart';
import 'models/recipe.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/main_screen.dart';
import 'theme/app_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  Hive.registerAdapter(RecipeAdapter());
  Hive.registerAdapter(AppUserAdapter());

  await _initializeHiveBoxes();

  final authRepository = AuthRepository();
  final recipeRepository = RecipeRepository();

  runApp(RecipeApp(
    authRepository: authRepository,
    recipeRepository: recipeRepository,
  ));
}

Future<void> _initializeHiveBoxes() async {
  final List<String> boxesToOpen = ['recipes', 'users', 'auth', 'favorites', 'settings'];
  
  for (final boxName in boxesToOpen) {
    try {
      if (boxName == 'recipes') {
        await Hive.openBox<Recipe>(boxName, crashRecovery: true);
      } else if (boxName == 'users') {
        await Hive.openBox<AppUser>(boxName, crashRecovery: true);
      } else {
        await Hive.openBox(boxName, crashRecovery: true);
      }
    } catch (_) {
      await Hive.deleteBoxFromDisk(boxName);
      if (boxName == 'recipes') {
        await Hive.openBox<Recipe>(boxName, crashRecovery: true);
      } else if (boxName == 'users') {
        await Hive.openBox<AppUser>(boxName, crashRecovery: true);
      } else {
        await Hive.openBox(boxName, crashRecovery: true);
      }
    }
  }
}

class RecipeApp extends StatelessWidget {
  final AuthRepository authRepository;
  final RecipeRepository recipeRepository;
  final Widget? startScreen;

  const RecipeApp({
    super.key, 
    required this.authRepository,
    required this.recipeRepository,
    this.startScreen,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnboardingCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LoginCubit(authRepository: authRepository)),
        BlocProvider(create: (_) => RecipeCubit(
          recipeRepository: recipeRepository,
          authRepository: authRepository,
        )),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MultiBlocListener(
            listeners: [
              BlocListener<LoginCubit, LoginState>(
                listenWhen: (previous, current) => previous.status != current.status,
                listener: (context, state) {
                  if (state.status == LoginStatus.success) {
                    navigatorKey.currentState?.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const MainScreen()),
                      (_) => false,
                    );
                    context.read<RecipeCubit>().loadUserContent();
                  } else if (state.status == LoginStatus.initial && !authRepository.isLoggedIn()) {
                    navigatorKey.currentState?.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (_) => false,
                    );
                  }
                },
              ),
              BlocListener<OnboardingCubit, OnboardingState>(
                listenWhen: (previous, current) => previous.status != current.status,
                listener: (context, state) {
                  if (state.status == OnboardingStatus.completed) {
                    navigatorKey.currentState?.pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (_) => false,
                    );
                  }
                },
              ),
            ],
            child: MaterialApp(
              navigatorKey: navigatorKey,
              title: 'CookCraft',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              themeMode: themeMode,
              home: _determineInitialPage(),
            ),
          );
        },
      ),
    );
  }

  Widget _determineInitialPage() {
    if (startScreen != null) return startScreen!;
    
    if (!OnboardingCubit.isOnboardingCompleted()) {
      return const OnboardingScreen();
    }
    
    if (authRepository.isLoggedIn()) {
      return const MainScreen();
    }
    
    return const LoginScreen();
  }
}
