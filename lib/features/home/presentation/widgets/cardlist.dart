import 'package:flutter/material.dart';
import 'package:foodninga/features/home/presentation/widgets/cardinfo.dart';

class Cardlist extends StatelessWidget {
  const Cardlist({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount: 8,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
        childAspectRatio: 0.75, 
      ),

      itemBuilder: (context, index) {
        return CardInfo();
      },
    );
  }
}
