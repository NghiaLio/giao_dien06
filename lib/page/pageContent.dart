import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../data/content.dart';

class HomePageContent extends StatelessWidget {
  final index;
  const HomePageContent({super.key,required this.index});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Hero(
        tag: 'Page-Content-$index',
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height*2/5,
                  width: size.width*1,
                  child: Image(
                    image: AssetImage(Datas[index].pathImage),
                    // height: size.height*2/5,
                    fit: BoxFit.cover
                  ),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    Datas[index].title,
                    style:const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: RatingBar.builder(
                    initialRating: 3,
                    unratedColor: Colors.grey[400],
                    allowHalfRating: true,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 40,
                    minRating: 1,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ), 
                    onRatingUpdate: (rating){}
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    Datas[index].content,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}
       