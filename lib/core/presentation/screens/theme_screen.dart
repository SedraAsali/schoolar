
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/theme_dialog.dart';

class ThemeScreen extends ConsumerWidget {
  const ThemeScreen({super.key});

  @override
  Widget build(BuildContext context,ref) {
    return Scaffold(
      appBar: AppBar(title: Text('شاشة السمة'),),
      body: SafeArea(child: 
      SizedBox(
        width: double.infinity,
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){
              showDialog(context: context, 
                  builder: (BuildContext context){
                     return  ThemeDialogWidget();
    }
                  );
            }, 
                child: Text('غير السمة'))
          ],
        ),
      )),
    );
  }
}
