import 'package:flutter/material.dart';
import 'package:sunglasses/Admin/ADD_data.dart';
import 'package:sunglasses/screen/View.dart';

class Drawer_Widget extends StatelessWidget {
  const Drawer_Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTileTheme(
              iconColor: Colors.indigoAccent,
              textColor: Colors.indigoAccent,
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.add),
                    title: const Text("Add Category"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ADD_data()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text("View Category "),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const View(),
                          ));
                    },
                  )
                ],
              ))
        ],
      ),
    );
  }
}
