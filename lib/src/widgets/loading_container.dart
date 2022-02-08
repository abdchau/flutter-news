import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        const Divider(
          thickness: 2,
        ),
      ],
    );
  }

  Widget buildContainer() {
    return Container(
      color: Colors.grey[300],
      height: 24,
      width: 150,
      margin: const EdgeInsets.symmetric(vertical: 5),
    );
  }
}
