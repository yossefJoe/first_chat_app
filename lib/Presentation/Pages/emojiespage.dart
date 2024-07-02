import 'package:chatapp/Api/Emojies_Method.dart';
import 'package:flutter/material.dart';

class EmojiesPage extends StatelessWidget {
  EmojiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Goto Page')),
        body: Column(
          children: [
            FutureBuilder(
                future: Emojies_Method.getEmojies(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(snapshot.data![index].character!),
                        );
                      },
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.indigo,
                    ));
                  }
                }),
          ],
        ));
  }
}
