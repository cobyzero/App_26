import 'dart:io';

import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/const.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Core/Widgets/custom_button.dart';
import 'package:app_26/Core/Widgets/custom_date_picker.dart';
import 'package:app_26/Core/Widgets/custom_dropdown.dart';
import 'package:app_26/Core/Widgets/custom_input.dart';
import 'package:app_26/Core/Widgets/custom_input_field.dart';
import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:app_26/Features/Memory/Application/Blocs/memory_create_bloc/memory_create_bloc.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class MemoryCreateScreen extends StatelessWidget {
  MemoryCreateScreen({super.key, required this.userEntity});

  final UserEntity userEntity;

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemoryCreateBloc, MemoryCreateState>(
      listener: (context, state) {
        if (state is MemoryCreateInitial) {
          if (state.isKeyValided != null) {
            if (state.isKeyValided == false) {
              Util.showError(
                text: 'Key del usuario no existe',
                context: context,
                onConfirm: () {},
              );
            }
          }
        }
        if (state is MemoryCreateComplete) {
          Util.showSucces(
            text: 'Creado exitosamente',
            context: context,
            onConfirm: () {},
          );

          context.go("/main");
          context.read<MemoryCreateBloc>().add(
                MemoryCreateClean(),
              );
        }
        if (state is MemoryCreateError) {
          Util.showError(
            text: state.error,
            context: context,
            onConfirm: () {
              context.go("/main");
              context.read<MemoryCreateBloc>().add(
                    MemoryCreateClean(),
                  );
            },
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<MemoryCreateBloc, MemoryCreateState>(
            builder: (context, state) {
              if (state is MemoryCreateInitial) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BackButton(
                            onPressed: () {
                              context.go("/main");
                            },
                          ),
                          const Texts.bold(
                            text: "Crea una memoria",
                          ).only(right: 2.w),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.vpn_key,
                                color: Palette.grey3,
                                size: 20.sp,
                              ).only(right: 2.w),
                              Texts.bold(
                                text: userEntity.keys.toString(),
                                alignment: TextAlign.center,
                                color: Palette.kPrimary,
                                fontSize: 17.sp,
                              ),
                            ],
                          ),
                        ],
                      ).symmetric(vertical: 4.h),
                      CustomInputField(
                        controller: state.messageController,
                        hintText: "Hola como estas",
                        title: 'Mensaje',
                      ).only(bottom: 4.h),
                      CustomInput(
                        title: "Usuario a enviar",
                        readOnly: (state.isKeyValided ?? false),
                        controller: state.keyUserController,
                        prefixIcon: (state.isKeyValided ?? false)
                            ? IconButton(
                                onPressed: () {
                                  context.read<MemoryCreateBloc>().add(
                                        MemoryCreateCleanKeyValidate(),
                                      );
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 17.sp,
                                ),
                                color: Palette.red,
                              )
                            : null,
                        hintText: "Codigo del usuario",
                        suffixIcon: state.loadingKey
                            ? Padding(
                                padding: EdgeInsets.all(2.w),
                                child: const CircularProgressIndicator(
                                  color: Palette.white,
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  if ((state.isKeyValided ?? false) == true) return;
                                  if (state.keyUserController.text.isEmpty) {
                                    Util.showError(
                                      context: context,
                                      text: "Ingrese una key",
                                      onConfirm: () {},
                                    );
                                    return;
                                  }

                                  context.read<MemoryCreateBloc>().add(
                                        MemoryCreateValidateKey(
                                          state.keyUserController.text,
                                        ),
                                      );
                                },
                                icon: Icon(
                                  (state.isKeyValided ?? false) ? Icons.verified : Icons.search,
                                  size: 17.sp,
                                ),
                                color: Palette.white,
                              ).only(right: 2.w),
                      ).only(bottom: 4.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: Util.gradient(),
                        ),
                        height: 10.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: state.pathImage.length < 5
                              ? state.pathImage.length + 1
                              : state.pathImage.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                if (index != state.pathImage.length) {
                                  await showImage(
                                    context,
                                    state.pathImage[index],
                                  );
                                  return;
                                }

                                final image = await getImageCropper();

                                if (image == null) return;
                                // ignore: use_build_context_synchronously
                                context.read<MemoryCreateBloc>().add(
                                      MemoryCreateSetImage(image[0], image[1]),
                                    );
                              },
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: state.pathImage.length <= index
                                      ? Icon(
                                          Icons.add_photo_alternate,
                                          size: 30.sp,
                                        )
                                      : ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.file(
                                            File(state.pathImage[index]),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                ),
                              ).symmetric(horizontal: 3.w),
                            );
                          },
                        ),
                      ).only(bottom: 4.h),
                      Row(
                        children: [
                          const Texts.bold(
                            text: "Bloqueado",
                          ).only(right: 4.w),
                          Expanded(
                            child: CustomDropdown(
                              items: labelsBlocked,
                              value: state.isBlocked ? labelsBlocked[1] : labelsBlocked[0],
                              onChanged: (value) {
                                context.read<MemoryCreateBloc>().add(
                                      MemoryCreateSetIsBlocked(value! == labelsBlocked[1]),
                                    );
                              },
                            ),
                          ),
                        ],
                      ).only(bottom: 4.h),
                      Row(
                        children: [
                          const Texts.bold(
                            text: "Fecha de la memoria",
                          ).only(right: 4.w),
                          Expanded(
                            child: CustomDatePicker(
                              date: state.date,
                              onPress: (p0) {
                                context.read<MemoryCreateBloc>().add(
                                      MemoryCreateSetDate(p0 ?? DateTime.now()),
                                    );
                              },
                            ),
                          ),
                        ],
                      ),
                      CustomButton(
                        child: const SizedBox(
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.center,
                            child: Texts.bold(
                              text: "Confirmar",
                              color: Palette.white,
                            ),
                          ),
                        ),
                        onTap: () {
                          final state = (context.read<MemoryCreateBloc>().state as MemoryCreateInitial);

                          if (state.image.isEmpty || state.pathImage.isEmpty) {
                            Util.showInfo(
                              text: 'Ingrese una imagen',
                              context: context,
                              onConfirm: () {},
                            );
                            return;
                          }
                          if (state.messageController.text.isEmpty) {
                            Util.showInfo(
                              text: 'Ingrese un mensaje',
                              context: context,
                              onConfirm: () {},
                            );

                            return;
                          }
                          if (state.keyUserController.text.isEmpty) {
                            Util.showInfo(
                              text: 'Ingrese la key del usuario',
                              context: context,
                              onConfirm: () {},
                            );

                            return;
                          }
                          if (!(state.isKeyValided ?? false)) {
                            Util.showInfo(
                              text: 'Valide la key del usuario',
                              context: context,
                              onConfirm: () {},
                            );

                            return;
                          }
                          Util.showInfo(
                            text: 'Se te cobrara 1 key',
                            context: context,
                            onConfirm: () {
                              if (userEntity.keys == 0) {
                                Util.showError(
                                  text: "No cuentas con keys suficientes",
                                  context: context,
                                  onConfirm: () {},
                                );
                                return;
                              }

                              context.read<MemoryCreateBloc>().add(
                                    MemoryCreateCreate(
                                      state.keyUserController.text,
                                      state.messageController.text,
                                      userEntity.name,
                                    ),
                                  );
                            },
                          );
                        },
                      ).symmetric(vertical: 4.h),
                    ],
                  ).symmetric(horizontal: 10.w),
                );
              }

              return Util.loadingWidget();
            },
          ),
        ),
      ),
    );
  }

  Future<void> showImage(BuildContext context, String path) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.file(
              File(path),
              width: 80.w,
              height: 80.w,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }

  Future<List<String>?> getImageCropper() async {
    final List<String> list = [];
    final file = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (file == null) return null;
    list.add(file.name);
    final fileCropper = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    if (fileCropper == null) return null;

    list.add(fileCropper.path);
    return list;
  }
}
