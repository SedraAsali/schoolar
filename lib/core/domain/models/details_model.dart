import '../../presentation/widgets/details_widget.dart';

final institute = Institute(
  //النجوم
  rating: 4.0,
  image: "https://tse4.mm.bing.net/th/id/OIP.bTUquEP24f1MhL_EMSq0RgHaHf?rs=1&pid=ImgDetMain&o=7&rm=3",
  name: "معهد النخبة",
  location: "السبيل-قرب جامع الرحمن",
  departments: [
    Department(
      name: "توجيهي",
      subjects: [
        Subject(
          name: "الرياضيات",
          teachers: [Teacher("أ. أحمد"), Teacher("أ. سامي")],
        ),
        Subject(
          name: "الفيزياء",
          teachers: [Teacher("أ. علي")],
        ),
        Subject(
          name: "العلوم",
          teachers: [Teacher("أ. سوسن"), Teacher("أ. رامي")],
        ),
        Subject(
          name: "اللغة",
          teachers: [Teacher("أ. عليا")],
        ),
        Subject(
          name: "الديانة",
          teachers: [Teacher("أ. فاطمة")],
        ),
        Subject(
          name: "الجغرافية",
          teachers: [Teacher("أ. خالد")],
        ),
      ],
    ),
    Department(
      name: "بكالوريا",
      subjects: [
        Subject(
          name: "الكيمياء",
          teachers: [Teacher("أ. نور"), Teacher("أ. ريم")],
        ),
        Subject(
          name: "الرياضيات",
          teachers: [Teacher("أ. رغد"), Teacher("أ. محمد")],
        ),
        Subject(
          name: "الفيزياء",
          teachers: [Teacher("أ. فواز")],
        ),
        Subject(
          name: "الديانة",
          teachers: [ Teacher("أ. نور")],
        ),
        Subject(
          name: "العربي",
          teachers: [Teacher("أ. محمد"), Teacher("أ. أمينة")],
        ),
      ],
    ),
  ],


);
