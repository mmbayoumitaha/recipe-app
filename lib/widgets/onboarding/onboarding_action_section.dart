import 'package:flutter/material.dart';

class OnboardingActionSection extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const OnboardingActionSection({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onNext,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    final isLast = currentPage == totalPages - 1;
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIndicators(primaryColor),
          const SizedBox(height: 32),
          _buildNextButton(isLast, primaryColor),
          const SizedBox(height: 12),
          _buildSkipButton(isLast),
        ],
      ),
    );
  }

  Widget _buildIndicators(Color primaryColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) {
          final active = index == currentPage;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 6,
            width: active ? 20 : 6,
            decoration: BoxDecoration(
              color: active ? primaryColor : Colors.grey.withAlpha(50),
              borderRadius: BorderRadius.circular(3),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNextButton(bool isLast, Color primaryColor) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: onNext,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          shadowColor: primaryColor.withAlpha(100),
        ),
        child: Text(
          isLast ? 'Get Started' : 'Next',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSkipButton(bool isLast) {
    if (isLast) return const SizedBox(height: 48);
    return TextButton(
      onPressed: onSkip,
      child: const Text(
        'Skip',
        style: TextStyle(color: Colors.grey, fontSize: 16),
      ),
    );
  }
}
