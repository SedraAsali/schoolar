import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scholar/core/presentation/widgets/theme_dialog.dart';

class HomeScreen extends ConsumerWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context,ref) {
    return  Scaffold(

      appBar: AppBar(
        actions: [

          PopupMenuButton(itemBuilder: (context)
    {

    return[
      PopupMenuItem(child: Text('السمة'),
        onTap: () {showDialog(context: context,
            builder: (context)=>ThemeDialogWidget());
        },

      )
    ];
          })
        ],
      ),
      body:Column(
        children: [

          Text('مرحبا')
        ],
      ) ,
    );
  }
}
