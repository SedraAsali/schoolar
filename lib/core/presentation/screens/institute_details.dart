import 'package:flutter/material.dart';

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
                      color: Colors.grey,
                      size: 18,
                    ),
                    const SizedBox(width: 5),

                    Expanded(
                      child: Text(
                        institute.location,
                        style: const TextStyle(
                          color: Colors.grey,
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

              return Container(
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
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryFixedDim,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            teacher.name,
                            style:  TextStyle(
                              color:Theme.of(context).colorScheme.primary,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
      ),
      ),
    );
  }
}

