import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:scholar/core/feature_home/data/home_view_model.dart';
import 'package:scholar/core/feature_home/presentation/teachers_bloc/teachers_bloc.dart';
import '../../../helper/constant.dart';
import '../../../helper/widgets/loading_view.dart';
import '../../../helper/widgets/state_view.dart';
import '../data/data_teachers/teachers_model.dart';
import '../data/details_model.dart';

class InstituteDetailsScreen extends StatefulWidget {
  final Doc academy;
  const InstituteDetailsScreen({super.key, required this.academy});

  @override
  State<InstituteDetailsScreen> createState() => _InstituteDetailsScreenState();
}

class _InstituteDetailsScreenState extends State<InstituteDetailsScreen> {
 // int selectedIndex = 0;
  String selectedCategory = 'بكلوريا علمي';

double academyRating=0;

  final List<String> teacherCategories = [
    'بكلوريا علمي',
    'بكلوريا أدبي',
    'تاسع',
    'بكلورياعلمي و تاسع',
    'بكلورياأدبي و تاسع',
    'بكلوريا و تاسع',
    'بكلورياأدبي و علمي',
  ];
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
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 65,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.star_rounded,
                      size: 40,
                      color: gold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    'قيّم المعهد',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'شاركنا رأيك عن هذا المعهد',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),

                  const SizedBox(height: 25),

                  RatingBar.builder(
                    initialRating: tempRating,
                    minRating: 0.5,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 42,
                    itemPadding:
                    const EdgeInsets.symmetric(horizontal: 4),
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

                  if (tempRating > 0)
                    Text(
                      '${tempRating} / 5',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: tempRating == 0
                          ? null
                          : () {
                        setState(() {
                          academyRating = tempRating;
                        });
                         Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'إرسال التقييم',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
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
                              widget.academy.ratingsAverage.toString() ?? "",
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
                    return const Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text('لا يوجد أساتذة'),
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
                                        // الأساتذة جنب بعض
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
            // Subjects List
            // Expanded(
            //   child: ListView.builder(
            //     padding: const EdgeInsets.all(15),
            //     itemCount: department.subjects.length,
            //     itemBuilder: (context, index) {
            //       final subject = department.subjects[index];
            //
            //       return TweenAnimationBuilder(
            //         duration: Duration(milliseconds: 400 + (index * 150)),
            //
            //         tween: Tween<double>(begin: 0, end: 1),
            //
            //         builder: (context, value, child) {
            //           return Transform.translate(
            //             offset: Offset(0, 50 * (1 - value)),
            //
            //             child: Opacity(opacity: value, child: child),
            //           );
            //         },
            //
            //         child: Container(
            //           margin: const EdgeInsets.only(bottom: 18),
            //           padding: const EdgeInsets.all(15),
            //           decoration: BoxDecoration(
            //             color: Theme.of(context).colorScheme.onInverseSurface,
            //             borderRadius: BorderRadius.circular(25),
            //             boxShadow: [
            //               BoxShadow(
            //                 color: Theme.of(context).colorScheme.primary,
            //                 blurRadius: 3,
            //                 offset: Offset(0, 2),
            //               ),
            //             ],
            //           ),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 subject.name,
            //                 style: TextStyle(
            //                   color: Theme.of(context).colorScheme.primary,
            //                   fontSize: 18,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //               ),
            //
            //               const SizedBox(height: 10),
            //
            //               Text(
            //                 "الأساتذة:",
            //                 style: TextStyle(
            //                   color: Theme.of(
            //                     context,
            //                   ).colorScheme.outlineVariant,
            //                   fontSize: 13,
            //                 ),
            //               ),
            //
            //               const SizedBox(height: 8),
            //
            //               Wrap(
            //                 spacing: 8,
            //                 runSpacing: 8,
            //                 children: subject.teachers.map((teacher) {
            //                   return InkWell(
            //                     borderRadius: BorderRadius.circular(20),
            //
            //                     onTap: () {
            //                       showModalBottomSheet(
            //                         context: context,
            //
            //                         isScrollControlled: true,
            //
            //                         shape: const RoundedRectangleBorder(
            //                           borderRadius: BorderRadius.vertical(
            //                             top: Radius.circular(30),
            //                           ),
            //                         ),
            //
            //                         builder: (context) {
            //                           return StatefulBuilder(
            //                             builder: (context, setModalState) {
            //                               return Padding(
            //                                 padding: const EdgeInsets.all(20),
            //
            //                                 child: Column(
            //                                   mainAxisSize: MainAxisSize.min,
            //
            //                                   children: [
            //                                     Container(
            //                                       width: double.infinity,
            //                                       height: 5,
            //
            //                                       decoration: BoxDecoration(
            //                                         color: Theme.of(context)
            //                                             .colorScheme
            //                                             .outlineVariant,
            //
            //                                         borderRadius:
            //                                             BorderRadius.circular(
            //                                               20,
            //                                             ),
            //                                       ),
            //                                     ),
            //
            //                                     const SizedBox(height: 20),
            //
            //                                     CircleAvatar(
            //                                       radius: 40,
            //
            //                                       backgroundColor: Theme.of(
            //                                         context,
            //                                       ).colorScheme.primary,
            //
            //                                       child: Text(
            //                                         teacher.name[0],
            //
            //                                         style: TextStyle(
            //                                           color: Theme.of(
            //                                             context,
            //                                           ).colorScheme.surface,
            //
            //                                           fontSize: 30,
            //                                         ),
            //                                       ),
            //                                     ),
            //
            //                                     const SizedBox(height: 15),
            //
            //                                     Text(
            //                                       teacher.name,
            //
            //                                       style: TextStyle(
            //                                         fontSize: 22,
            //                                         color: Theme.of(
            //                                           context,
            //                                         ).colorScheme.primary,
            //                                         fontWeight: FontWeight.bold,
            //                                       ),
            //                                     ),
            //
            //                                     const SizedBox(height: 10),
            //
            //                                     Text(
            //                                       teacher.description,
            //
            //                                       textAlign: TextAlign.center,
            //
            //                                       style: TextStyle(
            //                                         color: Theme.of(context)
            //                                             .colorScheme
            //                                             .outlineVariant,
            //                                       ),
            //                                     ),
            //
            //                                     const SizedBox(height: 20),
            //
            //                                     Text(
            //                                       "التقييم",
            //
            //                                       style: TextStyle(
            //                                         color: Theme.of(
            //                                           context,
            //                                         ).colorScheme.primary,
            //                                         fontWeight: FontWeight.bold,
            //
            //                                         fontSize: 16,
            //                                       ),
            //                                     ),
            //
            //                                     const SizedBox(height: 10),
            //
            //                                     RatingBar.builder(
            //                                       initialRating: teacher.rating,
            //
            //                                       minRating: 0.5,
            //
            //                                       allowHalfRating: true,
            //
            //                                       itemCount: 5,
            //
            //                                       itemSize: 35,
            //
            //                                       itemBuilder: (context, _) {
            //                                         return Icon(
            //                                           Icons.star,
            //
            //                                           color: gold,
            //                                         );
            //                                       },
            //
            //                                       onRatingUpdate: (rating) {
            //                                         setModalState(() {
            //                                           teacher.rating = rating;
            //                                         });
            //
            //                                         setState(() {});
            //                                       },
            //                                     ),
            //
            //                                     const SizedBox(height: 10),
            //
            //                                     Text(
            //                                       teacher.rating
            //                                           .toStringAsFixed(1),
            //
            //                                       style: TextStyle(
            //                                         fontSize: 18,
            //                                         color: Theme.of(
            //                                           context,
            //                                         ).colorScheme.primary,
            //                                         fontWeight: FontWeight.bold,
            //                                       ),
            //                                     ),
            //
            //                                     const SizedBox(height: 20),
            //                                   ],
            //                                 ),
            //                               );
            //                             },
            //                           );
            //                         },
            //                       );
            //                     },
            //
            //                     child: AnimatedContainer(
            //                       duration: const Duration(milliseconds: 300),
            //
            //                       padding: const EdgeInsets.symmetric(
            //                         horizontal: 13,
            //                         vertical: 6,
            //                       ),
            //
            //                       decoration: BoxDecoration(
            //                         border: BoxBorder.all(
            //                           color: Theme.of(
            //                             context,
            //                           ).colorScheme.primary,
            //                         ),
            //                         color: Theme.of(
            //                           context,
            //                         ).colorScheme.secondary,
            //
            //                         borderRadius: BorderRadius.circular(20),
            //                       ),
            //
            //                       child: Text(
            //                         teacher.name,
            //
            //                         style: TextStyle(
            //                           color: Theme.of(
            //                             context,
            //                           ).colorScheme.surface,
            //
            //                           fontSize: 12,
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 }).toList(),
            //               ),
            //             ],
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),


//زر للتقييم
      floatingActionButton: FloatingActionButton(
        onPressed: _showRatingBottomSheet,
        child: const Icon(Icons.star),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,

    );
  }
}
