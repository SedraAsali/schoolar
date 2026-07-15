import '../../presentation/widgets/details_widget.dart';

final institute = Institute(
  //النجوم
  rating: 4.0,
  image: "h ttps://tse4.mm.bing.net/th/id/OIP.bTUquEP24f1MhL_EMSq0RgHaHf?rs=1&pid=ImgDetMain&o=7&rm=3",
  name: "معهد النخبة",
  location: "السبيل-قرب جامع الرحمن",
  managerPhone: '0950062418',
  departments: [
    Department(
      name: "بكالوريا/علمي",
      subjects: [
        Subject(
          name: "الرياضيات",
          teachers: [Teacher(
            "أ. أحمد",
            rating: 4.5,
            description: "مدرس رياضيات بخبرة 10 سنوات",
          ),
            Teacher(
              "أ. فايز",
              rating: 4.5,
              description: "مدرس رياضيات بخبرة 10 سنوات",
            ),

          ],
        ),
        Subject(
          name: "الفيزياء",
          teachers: [Teacher(
            "أ. محمد",
            rating: 4.5,
            description: "مدرس رياضيات بخبرة 10 سنوات",
          ),],
        ),
        Subject(
          name: "الكيمياء",
          teachers: [Teacher(
            "أ. مقداد",
            rating: 4.5,
            description: "مدرس رياضيات بخبرة 10 سنوات",
          ),],
        ),
        Subject(
          name: "اللغة",
          teachers: [Teacher(
            "أ. علا",
            rating: 4.5,
            description: "مدرس رياضيات بخبرة 10 سنوات",
          ),],
        ),

      ],
    ),
    Department(
      name: "بكالوريا/أدبي",
      subjects: [
        Subject(
          name: "الجغرافيا",
          teachers: [Teacher(
            "أ. راجو",
            rating: 3.5,
            description: "مدرس رياضيات بخبرة 8 سنوات",
          ),

          ],
        ),
        Subject(
          name: "الفلسفة",
          teachers: [Teacher(
            "أ. فاتن",
            rating: 3.5,
            description: "مدرس رياضيات بخبرة 20 سنوات",
          ),],
        ),
        Subject(
          name: "تاريخ",
          teachers: [Teacher(
            "أ. وعد",
            rating: 5.5,
            description: "مدرس رياضيات بخبرة 25 سنوات",
          ),],
        ),
        Subject(
          name: "اللغة",
          teachers: [Teacher(
            "أ. مي",
            rating: 4.5,
            description: "مدرس رياضيات بخبرة 10 سنوات",
          ),],
        ),

      ],
    ),
    Department(
      name: "توجيهي",
      subjects: [
        Subject(
          name: "الرياضيات",
          teachers: [Teacher(
            "أ. أحمد",
            rating: 4.5,
            description: "مدرس رياضيات بخبرة 10 سنوات",
          ),
            Teacher(
              "أ. سارة",
              rating: 4.5,
              description: "مدرس رياضيات بخبرة 10 سنوات",
            ),],
        ),
        Subject(
          name: "الفيزياء",
          teachers: [Teacher(
            "أ. أحمد",
            rating: 4.5,
            description: "مدرس رياضيات بخبرة 10 سنوات",
          ),],
        ),
        Subject(
          name: "العلوم",
          teachers: [Teacher(
            "أ. أحمد",
            rating: 4.5,
            description: "مدرس رياضيات بخبرة 10 سنوات",
          ),],
        ),
        Subject(
          name: "اللغة",
          teachers: [Teacher(
            "أ. أحمد",
            rating: 4.5,
            description: "مدرس رياضيات بخبرة 10 سنوات",
          ),],
        ),

      ],
    ),
  ],


);
