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
import 'package:app_26/Features/Memory/Application/Blocs/memory_create_bloc/memory_create_bloc.dart';
import 'package:app_26/Features/Memory/Infraestructure/Presentation/Widgets/memory_title.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class MemoryCreateScreen extends StatelessWidget {
  MemoryCreateScreen({super.key});
  final messageController = TextEditingController();
  final keyUserController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<MemoryCreateBloc, MemoryCreateState>(
      listener: (context, state) {
        if (state is MemoryCreateComplete) {
          Util.showMessage("Creado exitosamente", context);
          context.go("/homeAdmin");
          context.read<MemoryCreateBloc>().add(
                MemoryCreateClean(),
              );
        }
        if (state is MemoryCreateError) {
          Util.showMessage(state.error, context);
          context.go("/homeAdmin");
          context.read<MemoryCreateBloc>().add(
                MemoryCreateClean(),
              );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MemoryTitle(
                      padding: 0,
                      child: BackButton(
                        onPressed: () {
                          context.go("/homeAdmin");
                        },
                      ),
                    ),
                    const MemoryTitle(
                      child: Texts.bold(
                        text: "Crea una memoria",
                      ),
                    ),
                    const MemoryTitle(
                      padding: 0,
                      child: IconButton(
                        onPressed: null,
                        icon: Icon(Icons.lock),
                      ),
                    ),
                  ],
                ).symmetric(vertical: 4.h),
                CustomInputField(
                  controller: messageController,
                  hintText: "Mensaje",
                ).only(bottom: 4.h),
                CustomInput(
                  controller: keyUserController,
                  hintText: "Key del usuario",
                ).only(bottom: 4.h),
                GestureDetector(
                  onTap: () async {
                    final image = await getImageCropper();

                    if (image == null) return;
                    // ignore: use_build_context_synchronously
                    context.read<MemoryCreateBloc>().add(
                          MemoryCreateSetImage(image[0], image[1]),
                        );
                  },
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: BlocBuilder<MemoryCreateBloc, MemoryCreateState>(
                      builder: (context, state) {
                        if (state is MemoryCreateInitial) {
                          return Container(
                            padding: EdgeInsets.all(1.w),
                            decoration: BoxDecoration(
                              color: Palette.filled,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: state.pathImage == null
                                ? Icon(
                                    Icons.photo,
                                    size: 30.sp,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                      File(state.pathImage!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ).only(bottom: 4.h),
                BlocBuilder<MemoryCreateBloc, MemoryCreateState>(
                  builder: (context, state) {
                    if (state is MemoryCreateInitial) {
                      return Row(
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
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ).only(bottom: 4.h),
                BlocBuilder<MemoryCreateBloc, MemoryCreateState>(
                  builder: (context, state) {
                    if (state is MemoryCreateInitial) {
                      return Row(
                        children: [
                          const Texts.bold(
                            text: "Fecha de la memoria",
                          ).only(right: 4.w),
                          Expanded(
                            child: CustomDatePicker(
                              date: state.date ?? DateTime.now(),
                              onPress: (p0) {
                                context.read<MemoryCreateBloc>().add(
                                      MemoryCreateSetDate(p0 ?? DateTime.now()),
                                    );
                              },
                            ),
                          ),
                        ],
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                CustomButton(
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Texts.bold(
                        text: "Confirmar",
                        color: Palette.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    final state = (context.read<MemoryCreateBloc>().state as MemoryCreateInitial);

                    if (state.date == null) {
                      Util.showMessage("Ingrese una fecha", context);
                      return;
                    }
                    if (state.image == null || state.pathImage == null) {
                      Util.showMessage("Ingrese una imagen", context);
                      return;
                    }
                    if (messageController.text.isEmpty) {
                      Util.showMessage("Ingrese un mensaje", context);
                      return;
                    }
                    if (keyUserController.text.isEmpty) {
                      Util.showMessage("Ingrese la key del usuario", context);
                      return;
                    }

                    context.read<MemoryCreateBloc>().add(
                          MemoryCreateCreate(
                            keyUserController.text,
                            messageController.text,
                          ),
                        );
                  },
                ).symmetric(vertical: 4.h),
              ],
            ).symmetric(horizontal: 10.w),
          ),
        ),
      ),
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