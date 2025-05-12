import 'package:flutter/material.dart';
import 'package:studentlist_firebase/screens/widgets/form_widget.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget{
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Mahasiswa',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          ),
        ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(onPressed: (){
            Navigator.push(context, 
            MaterialPageRoute(
              builder: (context) => const FormScreen(isEdit: false)
              )
            );
          }, icon: Icon(Icons.add))
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
