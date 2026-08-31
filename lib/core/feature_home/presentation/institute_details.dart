import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:scholar/core/feature_home/data/home_view_model.dart';
import 'package:scholar/core/feature_home/presentation/academies_bloc/home_view_bloc.dart';
import 'package:scholar/core/feature_home/presentation/teachers_bloc/teachers_bloc.dart';
import 'package:scholar/helper/show_message.dart';
import '../../../helper/constant.dart';
import '../../../helper/widgets/loading_view.dart';
import '../../../helper/widgets/state_view.dart';
import '../data/data_teachers/teachers_model.dart';
import '../data/details_model.dart';
import 'rating_bloc/rating_bloc.dart';

class InstituteDetailsScreen extends StatefulWidget {
  final Doc academy;
  final String? role;
  const InstituteDetailsScreen( {super.key, required this.academy,required this.role});

  @override
  State<InstituteDetailsScreen> createState() => _InstituteDetailsScreenState();
}

class _InstituteDetailsScreenState extends State<InstituteDetailsScreen> {
 // int selectedIndex = 0;
  String selectedCategory = 'بكلوريا علمي';

double academyRating=0;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TeachersViewBloc>().add(
        LoadingTeachersViewEvent(
          context: context,
          academyId: widget.academy.id ?? '',
        ),
      );
    });
  }


//تابع البتم شييت للتقييم
  void _showRatingBottomSheet() {
    double tempRating = academyRating;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,

      builder: (bottomSheetContext) {
        return BlocListener<RatingViewBloc, RatingViewState>(
          listener: (context, state) {

            // =====================================
            // Loading
            // =====================================

            if (state is RatingLoadingState) {
              print("Rating -> Loading");
            }

            // =====================================
            // Success
            // =====================================

            if (state is RatingSuccessState) {
              print("Rating -> Success");

              // تحديث التقييم مباشرة بصفحة تفاصيل المعهد
              setState(() {
                academyRating = tempRating;
                widget.academy.ratingsAverage=tempRating.toInt();
              });

              // تحديث قائمة المعاهد
              context.read<HomeViewBloc>().add(
                LoadingHomeViewEvent(
                  context: context,
                ),
              );

              // إغلاق نافذة التقييم
              Navigator.of(bottomSheetContext).pop();
            }

            // =====================================
            // No Internet
            // =====================================

            if (state is RatingNoInternetState) {
              print("Rating -> No Internet");

              showMessage(
                context,
                "تحقق من اتصال الإنترنت",
                true,
              );
            }

            // =====================================
            // Error
            // =====================================

            if (state is RatingErrorState) {
              print("Rating -> Error");

              showMessage(
                context,
                state.message ?? "حدث خطأ، حاول مرة أخرى",
                true,
              );
            }
          },

          child: StatefulBuilder(
            builder: (context, setModalState) {

              return Container(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  12,
                  20,
                  30,
                ),

                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .surface,

                  borderRadius:
                  const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [

                  // =====================================
                  // الخط العلوي
                  // =====================================

                  Container(
                  width: 65,
                  height: 5,

                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .outlineVariant,

                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 25),

                // =====================================
                // أيقونة التقييم
                // =====================================

                Container(
                  width: 60,
                  height: 60,

                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primary,

                    shape: BoxShape.circle,
                  ),

                  child: Icon(
                    Icons.star_rounded,
                    size: 40,
                    color: gold,
                  ),
                ),

                const SizedBox(height: 15),

                // =====================================
                // العنوان
                // =====================================

                Text(
                  'قيّم المعهد',

                  style: TextStyle(
                      fontSize: 21,
                      fontWeight:
                      FontWeight.bold,
                       color: Theme.of(context)
                      .colorScheme
                      .primary,
                ),
              ),

              const SizedBox(height: 8),

              // =====================================
              // الوصف
              // =====================================

              Text(
              'شاركنا رأيك عن هذا المعهد',

              style: TextStyle(
              fontSize: 14,

              color: Theme.of(context)
                  .colorScheme
                  .outlineVariant,
              ),
              ),

              const SizedBox(height: 25),

              // =====================================
              // النجوم
              // =====================================

              RatingBar.builder(
              initialRating: tempRating,

              minRating: 0.5,

              allowHalfRating: false,

              itemCount: 5,

              itemSize: 42,

              itemPadding:
              const EdgeInsets.symmetric(
              horizontal: 4,
              ),

              itemBuilder: (context, _) {
              return Icon(
              Icons.star_rounded,
              color: gold,
              );
              },

              onRatingUpdate: (rating) {

              setModalState(() {
              tempRating = rating;
              });

              },
              ),

              const SizedBox(height: 12),

              // =====================================
              // قيمة التقييم
              // =====================================

              if (tempRating > 0)
              Text(
              '${tempRating.toStringAsFixed(1)} / 5',

              style: TextStyle(
              fontSize: 18,

              fontWeight:
              FontWeight.bold,

              color: Theme.of(context)
                  .colorScheme
                  .primary,
              ),
              ),

              const SizedBox(height: 25),

              // =====================================
              // زر الإرسال
              // =====================================

              BlocBuilder<RatingViewBloc, RatingViewState>(
              builder: (context, state) {

              final bool isLoading =
              state is RatingLoadingState;

              return SizedBox(
              width: double.infinity,
              height: 50,

              child: ElevatedButton(

              // =================================
              // منع الضغط أثناء Loading
              // =================================

              onPressed:
              tempRating == 0 ||
              isLoading
              ? null
                  : () {

              print(
              "Sending rating => $tempRating",
              );

              context
                  .read<
              RatingViewBloc>()
                  .add(
              AddRatingEvent(
              context:
              context,

              academyId:
              widget
                  .academy
                  .id ??
               "",

              rating:
              tempRating,
              ),
              );
              },

              style:
              ElevatedButton.styleFrom(
              shape:
              RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(
              15,
              ),
              ),
              ),

              // =================================
              // Loading
              // =================================

              child: isLoading
              ? LoadingView()

              // =================================
              // النص
              // =================================

                  : const Text(
              'إرسال التقييم',

              style: TextStyle(
              fontSize: 16,
              fontWeight:
              FontWeight.bold,
              ),
              ),
              ),
              );
              },
              ),

              const SizedBox(height: 5),
              ],
              ),
              );
            },
          ),
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    //  final department = institute.departments[selectedIndex];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Row(
                children: [
                  // معلومات المعهد
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.academy.name ?? "",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Theme.of(
                                context,
                              ).colorScheme.surface.withAlpha(120),
                              size: 18,
                            ),
                            const SizedBox(width: 5),

                            Expanded(
                              child: Text(
                                "${widget.academy.region ?? ""} - ${widget.academy.location ?? ""}",
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surface.withAlpha(120),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 18,
                              color: Theme.of(
                                context,
                              ).colorScheme.surface.withAlpha(120),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "مدير المعهد: ${widget.academy.managerId?.phone ?? ""}",
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surface.withAlpha(120),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Icons.star, color: gold),
                            const SizedBox(width: 5),
                            Text(
                              widget.academy.ratingsAverage.toString() ,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 15),

                  // صورة المعهد
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      width: 120,
                      height: 120,
                      widget.academy.photo ?? "",
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) {
                        return Container(
                          color: Theme.of(context).colorScheme.outlineVariant,
                          child: Center(
                            child: SvgPicture.asset(
                              'lib/svgFiles/school.svg',
                              height: 120,
                              semanticsLabel: 'school',
                            ),
                            // Icon(Icons.broken_image, size: 120,
                            //  color: Theme
                            //      .of(context)
                            //      .colorScheme
                            //      .onInverseSurface,
                            // ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // SizedBox(
            //   height: 45,
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: teacherCategories.length,
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     itemBuilder: (context, index) {
            //
            //       final category = teacherCategories[index];
            //
            //       final isSelected = selectedCategory == category;
            //
            //       return GestureDetector(
            //         onTap: () {
            //           setState(() {
            //             selectedCategory = category;
            //           });
            //         },
            //
            //         child: AnimatedContainer(
            //           duration: const Duration(milliseconds: 250),
            //
            //           margin: const EdgeInsets.only(right: 10),
            //
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 18,
            //             vertical: 10,
            //           ),
            //
            //           decoration: BoxDecoration(
            //             color: isSelected
            //                 ? Theme.of(context).colorScheme.primary
            //                 : Theme.of(context).colorScheme.outlineVariant,
            //
            //             borderRadius: BorderRadius.circular(20),
            //           ),
            //
            //           child: Text(
            //             category,
            //             style: TextStyle(
            //               color: isSelected
            //                   ? Colors.white
            //                   : Colors.black87,
            //
            //               fontWeight: FontWeight.w600,
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),

            const SizedBox(height: 10),


            BlocBuilder<TeachersViewBloc, TeachersViewState>(
              builder: (context, state) {
                // =========================
                // Loading
                // =========================
                if (state is TeachersLoadingState) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Center(child: LoadingView()),
                  );
                }

                // =========================
                // No Internet
                // =========================
                if (state is TeachersNoInternetState) {
                  return StateView(
                    imagePath: 'lib/svgFiles/no_internet_connection.svg',
                    function: () {
                      context.read<TeachersViewBloc>().add(
                        LoadingTeachersViewEvent(
                          context: context,
                          academyId: widget.academy.id ?? '',
                        ),
                      );
                    },
                  );
                }

                // =========================
                // 401 Unauthorized
                // =========================
                if (state is TeachersUnauthorizedState) {
                  return StateView(
                    imagePath: 'lib/svgFiles/something_wrong.svg',
                    imageHeader: state.message ?? 'يجب تسجيل الدخول',
                  );
                }

                // =========================
                // 403 Forbidden
                // =========================
                if (state is TeachersForbiddenState) {
                  return StateView(
                    imagePath: 'lib/svgFiles/something_wrong.svg',
                    imageHeader: state.message ?? 'يجب الدخول بحساب مدير',
                  );
                }

                // =========================
                // 500 Server Error
                // =========================
                if (state is TeachersServerErrorState) {
                  return StateView(
                    imagePath: 'lib/svgFiles/something_wrong.svg',
                    imageHeader: state.message ?? 'حدث خطأ في الخادم',
                    iconRefresh: true,
                    function: () {
                      context.read<TeachersViewBloc>().add(
                        LoadingTeachersViewEvent(
                          context: context,
                          academyId: widget.academy.id ?? '',
                        ),
                      );
                    },
                  );
                }

                // =========================
                // General Error
                // =========================
                if (state is TeachersErrorState) {
                  return StateView(
                    imagePath: 'lib/svgFiles/something_wrong.svg',
                    imageHeader:
                        state.message ?? 'حدث خطأ ما رجاءاً إعادة المحاولة',
                    iconRefresh: true,
                    function: () {
                      context.read<TeachersViewBloc>().add(
                        LoadingTeachersViewEvent(
                          context: context,
                          academyId: widget.academy.id ?? '',
                        ),
                      );
                    },
                  );
                }

                // =========================
                // Success
                // =========================
                 if (state is TeachersSuccessState) {
                  final teachers = state.teachersModel.doc ?? [];

                  if (teachers.isEmpty) {
                    return   Center(
                      child: StateView(
                        imagePath: 'lib/svgFiles/no_teachers.svg',
                       // imageHeader: 'لا يوجد معاهد',
                        // imageDescription: 'no_meal_description',
                      ),
                    );

                  }

                  // =========================
                  // تجميع الأساتذة حسب Category
                  // description من API
                  // =========================

                  final Map<String, List<Teacher>> groupedTeachers = {};

                  for (final teacher in teachers) {
                    final category = teacher.description?.trim() ?? '';

                    if (category.isEmpty) {
                      continue;
                    }

                    groupedTeachers
                        .putIfAbsent(category, () => [])
                        .add(teacher);
                  }

                  // Categories القادمة من API
                  final teacherCategories = groupedTeachers.keys.toList();

                  if (teacherCategories.isEmpty) {
                    return const Center(
                      child: Text('لا يوجد تصنيفات للأساتذة'),
                    );
                  }

                  // إذا الاختيار القديم غير موجود بالمعهد الحالي
                  // نستخدم أول Category
                  final currentCategory =
                  teacherCategories.contains(selectedCategory)
                      ? selectedCategory!
                      : teacherCategories.first;

                  // أساتذة الـ Category الحالية
                  final selectedTeachers =
                      groupedTeachers[currentCategory] ?? [];

                  // =========================
                  // UI
                  // =========================

                  return Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // =========================
                        // Categories
                        // =========================

                        SizedBox(
                          height: 45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: teacherCategories.length,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            itemBuilder: (context, index) {

                              final category =
                              teacherCategories[index];

                              final isSelected =
                                  currentCategory == category;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedCategory = category;
                                  });
                                },

                                child: AnimatedContainer(
                                  duration:
                                  const Duration(milliseconds: 250),

                                  margin:
                                  const EdgeInsets.only(right: 10),

                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 10,
                                  ),

                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Theme.of(context)
                                        .colorScheme
                                        .primary
                                        : Theme.of(context)
                                        .colorScheme
                                        .outlineVariant,

                                    borderRadius:
                                    BorderRadius.circular(20),
                                  ),

                                  child: Text(
                                    category,

                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black87,

                                      fontWeight:
                                      FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 15),

                        // =========================
                        // Teachers
                        // =========================

                        Expanded(
                          child: ListView(
                            padding:
                            const EdgeInsets.all(15),

                            children: [

                              ...(() {

                                final Map<String, List<Teacher>>
                                groupedBySubject = {};

                                // تجميع حسب المادة
                                for (final teacher
                                in selectedTeachers) {

                                  final subject =
                                      teacher.specialization
                                          ?.trim() ??
                                          '';

                                  if (subject.isEmpty) {
                                    continue;
                                  }

                                  groupedBySubject
                                      .putIfAbsent(
                                    subject,
                                        () => [],
                                  )
                                      .add(teacher);
                                }

                                return groupedBySubject.entries
                                    .map((entry) {

                                  final subject =
                                      entry.key;

                                  final subjectTeachers =
                                      entry.value;

                                  return Container(
                                    margin:
                                    const EdgeInsets.only(
                                      bottom: 18,
                                    ),

                                    padding:
                                    const EdgeInsets.all(15),

                                    decoration:
                                    BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onInverseSurface,

                                      borderRadius:
                                      BorderRadius.circular(25),

                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,

                                          blurRadius: 3,

                                          offset:
                                          const Offset(0, 2),
                                        ),
                                      ],
                                    ),

                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                      children: [

                                        // =================
                                        // اسم المادة
                                        // =================

                                        Text(
                                          subject,

                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,

                                            fontSize: 18,

                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),

                                        const SizedBox(height: 10),

                                        Text(
                                          "الأساتذة:",

                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outlineVariant,

                                            fontSize: 13,
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        // =================
                                        // الألاساتذة جنب بعض
                                        // =================

                                        Wrap(
                                          spacing: 8,
                                          runSpacing: 8,

                                          children:
                                          subjectTeachers
                                              .map((teacher) {

                                            return InkWell(

                                              borderRadius:
                                              BorderRadius
                                                  .circular(20),

                                              onTap: () {
                                                // تفاصيل الأستاذ لاحقاً
                                              },

                                              child:
                                              AnimatedContainer(
                                                duration:
                                                const Duration(
                                                  milliseconds: 300,
                                                ),

                                                padding:
                                                const EdgeInsets
                                                    .symmetric(
                                                  horizontal: 15,
                                                  vertical: 9,
                                                ),

                                                decoration:
                                                BoxDecoration(
                                                  color: Theme.of(
                                                      context,
                                                       )
                                                      .colorScheme
                                                      .secondary,

                                                  border:
                                                  Border.all(
                                                    color: Theme.of(
                                                      context,
                                                    )
                                                        .colorScheme
                                                        .primary,
                                                  ),

                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                    20,
                                                  ),
                                                ),

                                                child: Text(
                                                  teacher.name ?? '',

                                                  style: TextStyle(
                                                    color: Theme.of(
                                                      context,
                                                    )
                                                        .colorScheme
                                                        .surface,

                                                    fontSize: 13,

                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList();

                              }()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // =========================
                // Initial / Default
                // =========================

                return Center(child: LoadingView());
              },
            ),
            const SizedBox(height: 10),

          ],
        ),
      ),


//زر للتقييم
      floatingActionButton:widget.role=="MANAGER" ?null :FloatingActionButton(
        onPressed: _showRatingBottomSheet,
        child: const Icon(Icons.star),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

    );
  }
}
