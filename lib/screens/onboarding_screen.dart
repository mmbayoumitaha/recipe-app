import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/onboarding/onboarding_cubit.dart';
import '../widgets/onboarding/onboarding_page.dart';
import '../widgets/onboarding/onboarding_action_section.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Discover Recipes',
      description: 'Explore thousands of gourmet recipes from across the globe.',
      imagePath: 'assets/onboarding/discover.png',
      color: const Color(0xFFFF8A65),
    ),
    OnboardingData(
      title: 'Master Your Cooking',
      description: 'Follow step-by-step guides to create professional-level meals.',
      imagePath: 'assets/onboarding/cook.png',
      color: const Color(0xFFFDD835),
    ),
    OnboardingData(
      title: 'Share the Joy',
      description: 'Create your own cookbook and share your culinary joy with others.',
      imagePath: 'assets/onboarding/share.png',
      color: const Color(0xFFFFCC33),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    final currentPage = context.read<OnboardingCubit>().state.currentPage;
    if (currentPage < _pages.length - 1) {
      _pageController.animateToPage(
        currentPage + 1,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutQuart,
      );
    } else {
      _onComplete();
    }
  }

  void _onComplete() {
    context.read<OnboardingCubit>().completeOnboarding();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (index) => context.read<OnboardingCubit>().updatePage(index),
                    itemBuilder: (context, index) {
                      final data = _pages[index];
                      return OnboardingPage(
                        title: data.title,
                        description: data.description,
                        imagePath: data.imagePath,
                        themeColor: data.color,
                      );
                    },
                  ),
                ),
                OnboardingActionSection(
                  currentPage: state.currentPage,
                  totalPages: _pages.length,
                  onNext: _onNext,
                  onSkip: _onComplete,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final String imagePath;
  final Color color;

  OnboardingData({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.color,
  });
}
