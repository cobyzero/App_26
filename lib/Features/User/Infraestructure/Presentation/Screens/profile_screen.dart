import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Widgets/custom_button.dart';
import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userEntity});
  final UserEntity userEntity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                      image: AssetImage(
                        "${assetImage}profile.jpg",
                      ),
                    )),
              ).only(bottom: 4.h),
              Texts.bold(
                text: userEntity.name,
                fontSize: 22.sp,
              ).only(bottom: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Texts.bold(
                    text: "Codigo: ",
                    fontSize: 15.sp,
                  ),
                  Texts.regular(
                    text: userEntity.key,
                    fontSize: 15.sp,
                    color: Palette.kPrimary,
                  ),
                ],
              ).only(bottom: 4.h),
              SizedBox(
                width: 50.w,
                child: CustomButton(
                  child: const Texts.regular(
                    text: "Crear recuerdo",
                    color: Palette.white,
                  ),
                  onTap: () {
                    context.go(
                      "/memoryCreate",
                      extra: userEntity,
                    );
                  },
                ),
              ).only(bottom: 4.h),
              SizedBox(
                width: 50.w,
                child: CustomButton(
                  onTap: () {
                    context.go("/login");
                  },
                  child: const Texts.regular(
                    text: "Cerrar Sesión",
                    color: Palette.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
