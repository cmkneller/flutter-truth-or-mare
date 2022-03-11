import 'package:flutter/material.dart';

class CustomiseListTile extends StatelessWidget {
  final int iD;
  final String title;
  final String textContent;
  final Function deleteTile;

  const CustomiseListTile(this.iD, this.title, this.textContent, this.deleteTile, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (_) {
        deleteTile(iD);
      },
      key: ValueKey(iD),
      child: Card(
        margin: const EdgeInsets.all(15),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(title),
            subtitle: Text(textContent),
          ),
        ),
      ),
    );
  }
}
