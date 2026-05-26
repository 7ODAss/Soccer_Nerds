import 'package:flutter/material.dart';
import 'package:football_app/features/favorite/presentation/screen/favorite_screen.dart';
import 'package:football_app/features/list_of_match/presentation/screen/match_screen.dart';

import '../../../../player_profile/presentation/screen/player_profile_screen.dart';

class NavModel {
  final int index;
  final String appBarTitle;
  final String title;
  final IconData icon;
  final Widget screen;

  NavModel({
    required this.index,
    required this.appBarTitle,
    required this.title,
    required this.icon,
    required this.screen,
  });
}

List<NavModel> navItems = [
  NavModel(
    index: 0,
    appBarTitle: 'SoccerNerds',
    title: 'Home',
    icon: Icons.home_outlined,
    screen: MatchScreen(),
  ),
  NavModel(
    index: 1,
    appBarTitle: 'Players Details',
    title: 'Players',
    icon: Icons.people_alt_outlined,
    screen: PlayerProfileScreen(),
  ),
  NavModel(
    index: 2,
    appBarTitle: 'Favorite Matches',
    title: 'Favorite',
    icon: Icons.favorite_border_outlined,
    screen: FavoriteScreen(),
  ),
];
