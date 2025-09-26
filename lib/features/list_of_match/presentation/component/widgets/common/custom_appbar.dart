import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../core/theme/controller/theme_bloc.dart';
import 'custom_search_delegation.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
   static const double _height = 100;
   final String title;
   final bool needBack;
   const CustomAppbar({super.key, required this.title,required this.needBack,});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child:Padding(
        padding: const EdgeInsets.only(top: 30.0,left: 20.0,right: 20.0),
        child: Row(
          children: [
            if(needBack)
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, size: 30, color: Colors.white),
            ),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            IconButton(onPressed: (){
              showSearch(context: context, delegate: CustomSearchDelegate());
            }, icon: Icon(Icons.search,size: 35,color: Colors.white,)),
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () {
                    context.read<ThemeBloc>().add(const ChangeThemeEvent());
                  },
                  icon: Icon(
                    state.isDark
                        ? Icons.light_mode_outlined
                        : Icons.dark_mode_outlined,
                    size: 35,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_height);
}
