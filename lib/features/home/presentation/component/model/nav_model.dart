import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:football_app/features/favorite/presentation/screen/favorite_screen.dart';
import 'package:football_app/features/list_of_match/presentation/screen/match_screen.dart';

import '../../../../leagues/presentation/screen/standing_screen.dart';

class NavModel{
  final int index;
  final String appBarTitle;
  final String title;
  final IconData icon;
  final Widget screen;

  NavModel({required this.index,required this.appBarTitle,required this.title, required this.icon, required this.screen});

}

List<NavModel> navItems=[
  NavModel(index: 0,appBarTitle: 'SoccerNerds',title: 'Home', icon: Icons.home_outlined, screen: MatchScreen()),
  NavModel(index: 1,appBarTitle: 'Favorite Matches',title: 'Favorite', icon: Icons.favorite_border_outlined, screen: FavoriteScreen()),

];