import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum OnboardingStatus { initial, loading, completed }

class OnboardingState {
  final OnboardingStatus status;
  final int currentPage;

  OnboardingState({required this.status, this.currentPage = 0});

  OnboardingState copyWith({OnboardingStatus? status, int? currentPage}) {
    return OnboardingState(
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingState(status: OnboardingStatus.initial));

  void updatePage(int page) {
    emit(state.copyWith(currentPage: page));
  }

  Future<void> completeOnboarding() async {
    emit(state.copyWith(status: OnboardingStatus.loading));
    final box = await Hive.openBox('settings');
    await box.put('onboarding_completed', true);
    emit(state.copyWith(status: OnboardingStatus.completed));
  }

  static Future<bool> isOnboardingCompleted() async {
    final box = await Hive.openBox('settings');
    return box.get('onboarding_completed', defaultValue: false);
  }
}
