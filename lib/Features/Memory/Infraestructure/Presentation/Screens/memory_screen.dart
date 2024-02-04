import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Features/Home/Domain/Entities/memory_entity.dart';
import 'package:app_26/Features/Memory/Application/Blocs/memory_bloc/memory_bloc.dart';
import 'package:app_26/Features/Memory/Infraestructure/Presentation/Widgets/memory_title.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class MemoryScreen extends StatelessWidget {
  const MemoryScreen({
    super.key,
    required this.entity,
  });
  final MemoryEntity entity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MemoryBloc(),
      child: Scaffold(
        body: SafeArea(
            child: SizedBox.expand(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MemoryTitle(
                      padding: 10,
                      child: BackButton(
                        onPressed: () {
                          context.go("/home");
                        },
                        color: Palette.pink,
                      ),
                    ),
                    MemoryTitle(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Texts.bold(
                            text: "Recuerdo: ",
                          ),
                          Texts.bold(
                            text: "${entity.date.day}/${entity.date.month}/${entity.date.year}",
                            color: Palette.pink,
                          ),
                        ],
                      ),
                    ),
                    const MemoryTitle(
                      padding: 10,
                      child: IconButton(
                        onPressed: null,
                        color: Palette.pink,
                        icon: Icon(Icons.lock),
                      ),
                    ),
                  ],
                ).symmetric(
                  horizontal: 5.w,
                  vertical: 2.h,
                ),
                BlocBuilder<MemoryBloc, MemoryState>(
                  builder: (context, state) {
                    if (state is MemoryInitial) {
                      return GestureDetector(
                        onTap: () {
                          context.read<MemoryBloc>().add(
                                MemoryEventOpen(),
                              );
                        },
                        child: MemoryTitle(
                          child: Container(
                            width: double.infinity,
                            alignment: state.isOpen ? Alignment.topLeft : Alignment.center,
                            child: AnimatedSizeAndFade(
                              fadeDuration: const Duration(milliseconds: 300),
                              sizeDuration: const Duration(milliseconds: 600),
                              child: state.isOpen
                                  ? Texts.regular(
                                      alignment: TextAlign.start,
                                      text: entity.message,
                                      color: Palette.black,
                                      height: 2,
                                    )
                                  : Image.asset(
                                      "${assetImage}love-and-romance.png",
                                      height: 20.h,
                                    ),
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ).symmetric(
                  horizontal: 5.w,
                  vertical: 2.h,
                ),
                MemoryTitle(
                  padding: 0,
                  child: AspectRatio(
                      aspectRatio: 1,
                      child: FutureBuilder(
                        future: getImage(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }

                          return Util.loadingWidget();
                        },
                      )),
                ).symmetric(
                  horizontal: 5.w,
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  Future<String> getImage() async {
    final storageRef = FirebaseStorage.instance.ref();

    final imageUrl = await storageRef.child("${entity.userId}/${entity.image}").getDownloadURL();
    return imageUrl;
  }
}

  // final ImagePicker picker = ImagePicker();
  //                   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //                   if (image == null) return;
  //                   final metadata = SettableMetadata(contentType: "image/jpeg");

  //                   final storageRef = FirebaseStorage.instance.ref();
  //                   final uploadTask = storageRef.child("mountains.jpg").putFile(File(image.path), metadata);

  //                   print(await storageRef.getDownloadURL());