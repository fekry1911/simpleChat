import 'dart:async';
import 'package:flutter/material.dart';

class CustomStoryViewer extends StatefulWidget {
  final List<String> imageUrls;
  final Duration duration;

  const CustomStoryViewer({
    Key? key,
    required this.imageUrls,
    this.duration = const Duration(seconds: 5),
  }) : super(key: key);

  @override
  State<CustomStoryViewer> createState() => _CustomStoryViewerState();
}

class _CustomStoryViewerState extends State<CustomStoryViewer> {
  PageController _pageController = PageController();
  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(widget.duration, (timer) {
      if (currentIndex < widget.imageUrls.length - 1) {
        currentIndex++;
        _pageController.animateToPage(
          currentIndex,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        timer.cancel();
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                currentIndex = index;
                _startTimer();
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Image.network(
                  widget.imageUrls[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              );
            },
          ),
          Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Row(
              children: List.generate(widget.imageUrls.length, (index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    height: 4,
                    decoration: BoxDecoration(
                      color: index <= currentIndex
                          ? Colors.white
                          : Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            top: 40,
            right: 10,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}
