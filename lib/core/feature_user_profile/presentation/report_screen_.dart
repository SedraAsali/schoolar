import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:scholar/core/feature_user_profile/presentation/bugReport_form.dart';
import 'package:scholar/core/feature_user_profile/presentation/report_bloc/report_bloc.dart';
import 'package:scholar/helper/show_message.dart';
import 'package:scholar/helper/widgets/loading_view.dart';

class ReportBugPageView extends StatefulWidget {
  const ReportBugPageView({super.key});

  @override
  State<ReportBugPageView> createState() => _ReportBugPageViewState();
}

class _ReportBugPageViewState extends State<ReportBugPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("الإبلاغ عن مشكلة"), centerTitle: true),
      body: BlocListener<ReportViewBloc, ReportViewState>(
        listener: (context, state) {
          if (state is ReportSuccessState) {
            print("Report -> SUCCESS");

            //showMessage(context, "تم إرسال المشكلة بنجاح", false);

            BugReportForm.form.reset();

            Navigator.of(context).pop();
          }

          if (state is ReportNoInternetState) {
            print("Report -> NO INTERNET");

            //showMessage(context, "تحقق من اتصال الإنترنت", true);
          }

          if (state is ReportUnauthorizedState) {
            print("Report -> UNAUTHORIZED");

            //showMessage(context, "يجب تسجيل الدخول لإرسال البلاغ", true);
          }

          if (state is ReportErrorState) {
            print("Report -> ERROR");

            // showMessage(
            //   context,
            //   state.message ?? "حدث خطأ، حاول مرة أخرى",
            //   true,
            // );
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ReactiveForm(
            formGroup: BugReportForm.form,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 5),
                  ReactiveTextField<String>(
                    formControlName: 'title',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.7),
                      labelText: "عنوان المشكلة",

                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          "الرجاء إدخال عنوان المشكلة",
                    },
                  ),

                  const SizedBox(height: 12),

                  ReactiveTextField<String>(
                    formControlName: 'description',
                    maxLines: 4,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.7),
                      labelText: "وصف المشكلة",
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          "الرجاء إدخال وصف المشكلة",
                    },
                  ),

                  const SizedBox(height: 12),

                  ReactiveDropdownField<String>(
                    formControlName: 'type',
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.7),
                      labelText: "نوع المشكلة",
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          "الرجاء إدخال نوع المشكلة",
                    },
                    items: BugReportForm.types
                        .map(
                          (type) => DropdownMenuItem(
                            value: type,
                            child: Text(
                              type,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ReactiveFormConsumer(
                      builder: (context, form, child) {
                        return BlocBuilder<ReportViewBloc, ReportViewState>(
                          builder: (context, state) {
                            final isLoading = state is ReportLoadingState;
                            return ElevatedButton(
                              onPressed: form.valid && !isLoading
                                  ? () {
                                      final title =
                                          form.control('title').value as String;

                                      final description =
                                          form.control('description').value
                                              as String;

                                      final type =
                                          form.control('type').value as String;
                                      print("title $title");
                                      print("description $description");
                                      print("type $type");

                                      context.read<ReportViewBloc>().add(
                                        AddReportEvent(
                                          context: context,
                                          title: title,
                                          description: description,
                                          type: type,
                                          academyId: "",
                                        ),
                                      );
                                    }
                                  : null,
                              child: isLoading
                                  ? LoadingView()
                                  : const Text("إرسال"),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ReactiveFormConsumer(
                  //     builder: (context, form, child) {
                  //       return ElevatedButton(
                  //         onPressed: form.valid ? () { final title = form.control('title').value as String;
                  //         final description =
                  //         form.control('description').value as String;
                  //
                  //         final type =
                  //         form.control('type').value as String;
                  //
                  //         print("TITLE => $title");
                  //         print("DESCRIPTION => $description");
                  //         print("TYPE => $type");
                  //
                  //         context.read<ReportViewBloc>().add(
                  //           AddReportEvent(
                  //             context: context,
                  //             title: title,
                  //             description: description,
                  //             type: type,
                  //             academyId: "",
                  //           ),
                  //         );
                  //         }
                  //             : null,
                  //         // onPressed: form.valid
                  //         //     ? () {
                  //         //   final data = form.value;
                  //         //
                  //         //   ScaffoldMessenger.of(context).showSnackBar(
                  //         //     const SnackBar(
                  //         //       content: Text("تم إرسال المشكلة بنجاح"),
                  //         //     ),
                  //         //   );
                  //         //
                  //         //   form.reset();
                  //         // }
                  //         //     : null,
                  //         child: const Text("إرسال"),
                  //       );
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
