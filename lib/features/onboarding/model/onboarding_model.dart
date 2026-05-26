
import '../../../core/utils/onboarding/app_icon.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String image;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnboardingModel> onboardingList = [
  OnboardingModel(
    title: 'Welcome, SoccerNerd!',
    description: 'Live scores, deep stats, and match analysis. Your game, decoded.',
    image: AppIcon.boarding1, // Placeholder, update with actual SVG path
  ),
  OnboardingModel(
    title: 'Uncover Every Detail.',
    description: 'Explore xG, heatmaps, and head-to-heads. Data for true fans.',
    image: AppIcon.boarding2, // Placeholder, update with actual SVG path
  ),
  OnboardingModel(
    title: 'Your Feed, Your Rules.',
    description: 'Follow favorite teams, get alerts, and personalize your theme. Your soccer hub, your rules.',
    image: AppIcon.boarding3, // Placeholder, update with actual SVG path
  ),
];
