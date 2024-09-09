import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ListItemA extends StatelessWidget {
  String image;

  String nameMoveiz;

  ListItemA({super.key, required this.image, required this.nameMoveiz});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: EdgeInsets.all(10),
        // height:300 ,
        // width:300 ,
        clipBehavior: Clip.hardEdge,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            //  Container(color: Colors.red,width: double.infinity,),
            Image.network(
              image,
              fit: BoxFit.fill,
              // width: MediaQuery.sizeOf(context).width *.7,
              // height: MediaQuery.sizeOf(context).height *.6,
            ),
            Positioned(
              left: 20,
              top: 140,
              child: Text(
                nameMoveiz,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    ).animate().fade();
  }
}
