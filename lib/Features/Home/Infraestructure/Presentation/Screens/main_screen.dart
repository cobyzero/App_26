// ignore_for_file: prefer_const_constructors

import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:app_26/Features/Home/Infraestructure/Presentation/Screens/home_screen.dart';
import 'package:app_26/Features/User/Application/bloc/user_bloc.dart';
import 'package:app_26/Features/User/Infraestructure/Presentation/Screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;
  final padding = EdgeInsets.symmetric(horizontal: 18, vertical: 12);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        onTabChange: (value) {
          setState(() {
            index = value;
          });
        },
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        tabMargin: EdgeInsets.symmetric(
          vertical: 1.h,
          horizontal: 4.w,
        ),
        tabs: [
          GButton(
            gap: 10,
            iconActiveColor: Colors.purple,
            iconColor: Palette.kPrimary,
            textColor: Colors.purple,
            backgroundColor: Colors.purple.withOpacity(.2),
            iconSize: 24,
            padding: padding,
            icon: Icons.home,
            text: 'Inicio',
          ),
          GButton(
            gap: 10,
            iconActiveColor: Colors.amber[600],
            iconColor: Palette.kPrimary,
            textColor: Colors.amber[600],
            backgroundColor: Colors.amber[600]!.withOpacity(.2),
            iconSize: 24,
            padding: padding,
            icon: Icons.person,
            text: 'Perfil',
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserComplete) {
            return StreamBuilder<UserEntity>(
                stream: state.user,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return getPage(index, snapshot.data!);
                  }

                  return Util.loadingWidget();
                });
          }
          return Util.loadingWidget();
        },
      ),
    );
  }

  Widget getPage(
    int index,
    UserEntity userEntity,
  ) {
    switch (index) {
      case 0:
        return HomeScreen(
          userEntity: userEntity,
        );
      case 1:
        return ProfileScreen(
          userEntity: userEntity,
        );
      default:
        return HomeScreen(
          userEntity: userEntity,
        );
    }
  }
}
