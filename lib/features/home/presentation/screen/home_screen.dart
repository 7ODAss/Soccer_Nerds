import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_app/features/list_of_match/presentation/component/widgets/common/custom_appbar.dart';
import '../../../../core/services/service_locator.dart';
import '../component/model/nav_model.dart';
import '../component/widget/build_nav_item.dart';
import '../controller/home_bloc.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppbar(title: navItems[state.index].appBarTitle,needBack: false,),
          body: navItems[state.index].screen,
          bottomNavigationBar: Container(
            height: 75,
            decoration: BoxDecoration(
              color:Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(navItems.length, (index) {
                return BuildNavItem(
                  icon: navItems[index].icon,
                  label: navItems[index].title,
                  isSelected: state.index == index,
                  onTap: () => context.read<HomeBloc>().add(ChangeScreenEvent(index)),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
