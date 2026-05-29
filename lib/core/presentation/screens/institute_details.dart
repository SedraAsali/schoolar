import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constant.dart';
import '../../domain/models/details_model.dart';

class InstituteDetailsScreen extends StatefulWidget {
  const InstituteDetailsScreen({super.key});

  @override
  State<InstituteDetailsScreen> createState() =>
      _InstituteDetailsScreenState();
}

class _InstituteDetailsScreenState extends State<InstituteDetailsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final department = institute.departments[selectedIndex];

    return Scaffold(
      body: SafeArea(
      child: Column(
      children: [
      Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary ,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child:


      Row(
        children: [

          // معلومات المعهد
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  institute.name,
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
                      color: Theme.of(context).colorScheme.outlineVariant,
                      size: 18,
                    ),
                    const SizedBox(width: 5),

                    Expanded(
                      child: Text(
                        institute.location,
                        style:  TextStyle(
                          color: Theme.of(context).colorScheme.outlineVariant,
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
                      Icons.star,
                      color: gold,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      institute.rating.toString(),
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
              institute.image,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),


    ),

    const SizedBox(height: 20),

    SizedBox(
    height: 45,
    child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: institute.departments.length,
    padding: const EdgeInsets.symmetric(horizontal: 10),
    itemBuilder: (context, index) {
    final dept = institute.departments[index];

    final isSelected = selectedIndex == index;

    return GestureDetector(
    onTap: () {
    setState(() {
    selectedIndex = index;
    });
    },
    child: AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    margin: const EdgeInsets.only(right: 10),
    padding: const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 10,
    ),
      decoration: BoxDecoration(
        color:
        isSelected ?  Theme.of(context).colorScheme.primary :
        Theme.of(context).colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(20),

      ),


      child: Text(
        dept.name,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    );
    },
    ),
    ),

        const SizedBox(height: 10),

        //  Subjects List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: department.subjects.length,
            itemBuilder: (context, index) {
              final subject = department.subjects[index];

              return TweenAnimationBuilder(

                  duration: Duration(
                  milliseconds: 400 + (index * 150),
              ),

              tween: Tween<double>(begin: 0, end: 1),

              builder: (context, value, child) {

              return Transform.translate(

              offset: Offset(0, 50 * (1 - value)),

              child: Opacity(

              opacity: value,

              child: child,
              ),
              );
              },

              child: Container(
                margin: const EdgeInsets.only(bottom: 18),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow:  [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.primary,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                     Text(
                      "الأساتذة:",
                      style: TextStyle(
                      color:   Theme.of(context).colorScheme.outlineVariant,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: subject.teachers.map((teacher) {
                        return  InkWell(

                          borderRadius: BorderRadius.circular(20),

                          onTap: () {

                            showModalBottomSheet(

                              context: context,

                              isScrollControlled: true,

                              shape: const RoundedRectangleBorder(

                                borderRadius: BorderRadius.vertical(

                                  top: Radius.circular(30),
                                ),
                              ),

                              builder: (context) {

                                return StatefulBuilder(

                                  builder: (context, setModalState) {

                                    return Padding(

                                      padding: const EdgeInsets.all(20),

                                      child: Column(

                                        mainAxisSize: MainAxisSize.min,

                                        children: [

                                          Container(

                                            width: double.infinity,
                                            height: 5,

                                            decoration: BoxDecoration(

                                              color: Theme.of(context).colorScheme.outlineVariant,

                                              borderRadius:
                                              BorderRadius.circular(20),
                                            ),
                                          ),

                                          const SizedBox(height: 20),

                                          CircleAvatar(

                                            radius: 40,

                                            backgroundColor:
                                            Theme.of(context).colorScheme.primary,

                                            child: Text(

                                              teacher.name[0],

                                              style:  TextStyle(

                                                color:  Theme.of(context).colorScheme.surface,

                                                fontSize: 30,
                                              ),
                                            ),
                                          ),

                                          const SizedBox(height: 15),

                                          Text(

                                            teacher.name,

                                            style:  TextStyle(

                                              fontSize: 22,
                                              color:  Theme.of(context).colorScheme.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          Text(

                                            teacher.description,

                                            textAlign: TextAlign.center,

                                            style: TextStyle(

                                              color: Theme.of(context).colorScheme.outlineVariant,
                                            ),
                                          ),

                                          const SizedBox(height: 20),

                                           Text(

                                            "التقييم",

                                            style: TextStyle(
                                              color:  Theme.of(context).colorScheme.primary,
                                              fontWeight: FontWeight.bold,

                                              fontSize: 16,
                                            ),
                                          ),

                                          const SizedBox(height: 10),

                                          RatingBar.builder(

                                            initialRating: teacher.rating,

                                            minRating: 0.5,

                                            allowHalfRating: true,

                                            itemCount: 5,

                                            itemSize: 35,

                                            itemBuilder: (context, _) {

                                              return Icon(

                                                Icons.star,

                                                color: gold,
                                              );
                                            },

                                            onRatingUpdate: (rating) {

                                              setModalState(() {

                                                teacher.rating = rating;
                                              });

                                              setState(() {});
                                            },
                                          ),

                                          const SizedBox(height: 10),

                                          Text(

                                            teacher.rating.toStringAsFixed(1),

                                            style:  TextStyle(

                                              fontSize: 18,
                                              color: Theme.of(context).colorScheme.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(height: 20),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },

                          child: AnimatedContainer(

                            duration: const Duration(milliseconds: 300),

                            padding: const EdgeInsets.symmetric(

                              horizontal: 13,
                              vertical: 6,
                            ),

                            decoration: BoxDecoration(
                            border: BoxBorder.all(color: Theme.of(context).colorScheme.primary),
                              color: Theme.of(context).colorScheme.secondaryFixedDim,

                              borderRadius: BorderRadius.circular(20),
                            ),

                            child: Text(

                              teacher.name,

                              style: TextStyle(
                                 color: Theme.of(context).colorScheme.primary,

                              fontSize: 12,
                            ),
                          ),
                        ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ));
            },
          ),
        ),
      ],
      ),
      ),
    );
  }
}

