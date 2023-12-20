

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:giao_dien06/data/content.dart';
import 'package:giao_dien06/page/pageContent.dart';





class MyHomePage extends StatefulWidget {

  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = PageController(
    viewportFraction: 0.65
  );

  double _currentPage = 0.0;
  int _index = 0;
  void _listener(){
    setState(() {
      _currentPage = _controller.page!;
      _index = _currentPage.toInt();
    });
  }


  // Hàm initState được chạy ngay khi Wiget dc khởi tạo, hàm này lắng nghe sự kiện bắt số trang của PageView
  @override
  void initState(){
    super.initState();
    _controller.addListener(_listener);
  }

  // Hàm dispose được chạy khi Wiget này được xóa (chuyển sang Wiget khác), hàm này sẽ dừng sự kiện lắng nghe bắt số trang
  // khi mà hàm initstate đã bắt xong
  @override
  void dispose() {
    _controller.removeListener(_listener);
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height*1,
          width: size.width*1,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Datas[_index].pathImage),
              fit: BoxFit.cover,
              opacity: 0.6
            )
          ),
          child: PageView.builder(
            controller: _controller,
            scrollDirection: Axis.vertical,
            itemCount: Datas.length,
            itemBuilder: (context, index){
              if(index == _currentPage){
                return Transform.scale(
                  scale: 1,
                  child: PageContent(index: index,),
                );
              }
              else if(index < _currentPage){
                return Transform.scale(
                  scale: max(1 - (_currentPage - index), 0.8),
                  child: PageContent(index: index),
                );
              }
              else{
                return Transform.scale(
                  scale: max(1- (index - _currentPage), 0.8),
                  child: PageContent(index: index),
                );
              }
            }
          ),
        ),
      )
    );
  }
}

// ignore: must_be_immutable
class PageContent extends StatefulWidget {
  final index;

  PageContent({super.key, required this.index,});

  @override
  State<PageContent> createState() => _PageContentState(index,);
}

class _PageContentState extends State<PageContent> {
  final index;
  _PageContentState(this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Hero(
        tag: 'Page-Content-$index',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Container(
            padding: const EdgeInsets.all(25),
            decoration:BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                image: AssetImage(Datas[widget.index].pathImage),
                fit: BoxFit.cover
              ),
              borderRadius:const BorderRadius.all(Radius.circular(30)),
              boxShadow:const [
                BoxShadow(
                  color: Colors.blue,
                  blurRadius: 7.0,
                  offset: Offset(0, 0),
                  spreadRadius: 5
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    Datas[widget.index].title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber
                    ),
                  ),
                ),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  itemCount: 5,
                  itemSize: 40,
                  allowHalfRating: true,
                  direction: Axis.horizontal,
                  unratedColor: Colors.grey[400],
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amberAccent,
                    // size: 30,
                  ), 
                  onRatingUpdate: (rating){}
                ),
                // const SizedBox(height: 30,),
                Text(
                  Datas[widget.index].content,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.redAccent,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 3,
                )
              ],
            ),
          ),
        ),
      ),
      onTap: (){
        showModalBottomSheet(

          context: context, 
          builder: (BuildContext context) => HomePageContent(index: index),
          // useSafeArea: true,
          // isDismissible: true,
          isScrollControlled: true,
        );
      },
    );
  }

  
}



