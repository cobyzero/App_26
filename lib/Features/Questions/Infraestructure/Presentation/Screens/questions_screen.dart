import 'package:app_26/Core/Dependencies/injector.dart';
import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Core/Widgets/custom_button.dart';
import 'package:app_26/Features/Memory/Infraestructure/Presentation/Widgets/memory_title.dart';
import 'package:app_26/Features/Questions/Application/bloc/questions_bloc.dart';
import 'package:app_26/Features/Questions/Domain/Repositories/questions_repository.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key, required this.userId});
  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionsBloc(
        getIt.get<QuestionRepository>(),
      )..add(QuestionsEventGet(userId)),
      child: BlocConsumer<QuestionsBloc, QuestionsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is QuestionComplete) {
            return Scaffold(
              body: SafeArea(
                  child: SizedBox.expand(
                child: Column(
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
                        const MemoryTitle(
                          child: Texts.bold(
                            text: "Preguntas",
                          ),
                        ),
                        const MemoryTitle(
                          child: Icon(
                            Icons.lock,
                            color: Palette.kPrimary,
                          ),
                        ),
                      ],
                    ).symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    if (state.questions.isNotEmpty)
                      Expanded(
                        child: Column(
                          children: [
                            MemoryTitle(
                              child: Texts.bold(
                                text: state.questions[state.index].question,
                                fontSize: 6.sp,
                                alignment: TextAlign.center,
                                color: Palette.black,
                              ),
                            ).only(bottom: 5.h),
                            Expanded(
                              child: ListView.builder(
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      context.read<QuestionsBloc>().add(
                                            QuestionEventSetSelected(index),
                                          );
                                    },
                                    child: MemoryTitle(
                                      color: state.isSelected == null
                                          ? null
                                          : state.isSelected == index
                                              ? Palette.kPrimary
                                              : null,
                                      padding: 10,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          MemoryTitle(
                                            color: Palette.white,
                                            padding: 10,
                                            child: Texts.bold(
                                              text: (index + 1).toString(),
                                              fontSize: 6.sp,
                                              alignment: TextAlign.center,
                                              color: Palette.black,
                                            ),
                                          ),
                                          Texts.bold(
                                            text: state.questions[state.index].responses[index],
                                            fontSize: 6.sp,
                                            alignment: TextAlign.center,
                                            color: state.isSelected == null
                                                ? Palette.black
                                                : state.isSelected == index
                                                    ? Palette.white
                                                    : Palette.black,
                                          ),
                                          const SizedBox.shrink(),
                                        ],
                                      ),
                                    ).symmetric(vertical: 1.h, horizontal: 10.w),
                                  );
                                },
                              ),
                            ),
                            CustomButton(
                              onTap: () {
                                if (state.questions[state.index].correct != state.isSelected) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                "${assetImage}triste.png",
                                                width: 40.w,
                                              ),
                                              Texts.bold(
                                                text: "Incorrecto",
                                                fontSize: 8.sp,
                                                color: Palette.black,
                                              ).only(bottom: 2.h),
                                              CustomButton(
                                                child: Texts.regular(
                                                  text: "Aceptar",
                                                  fontSize: 8.sp,
                                                ),
                                                onTap: () {
                                                  GoRouter.of(context).pop();
                                                  context.go("/home");
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  return;
                                }

                                context.read<QuestionsBloc>().add(
                                      QuestionEventCheckQuestion(
                                        state.questions[state.index].id,
                                        userId,
                                      ),
                                    );
                              },
                              child: Texts.bold(
                                text: "Confirmar",
                                fontSize: 6.sp,
                                alignment: TextAlign.center,
                                color: Palette.white,
                              ),
                            ).symmetric(vertical: 4.h, horizontal: 10.w),
                          ],
                        ),
                      ),
                    if (state.questions.isEmpty)
                      const Expanded(
                        child: Center(
                          child: Texts.bold(text: "No hay preguntas"),
                        ),
                      ),
                  ],
                ),
              )),
            );
          }

          return Scaffold(
            body: Center(
              child: Util.loadingWidget(),
            ),
          );
        },
      ),
    );
  }
}
