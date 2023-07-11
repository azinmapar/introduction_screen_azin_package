import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pelaicons/pelaicons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'circle_progress_bar.dart';
import 'introduction.dart';

/// A IntroScreen Class.

class IntroScreenOnBoarding extends StatefulWidget {
  final List<Introduction>? introductionList;
  final Color? backgroudColor;
  final Color? foregroundColor;
  final TextStyle? skipTextStyle;
  final IconButton? topIconButton;

  /// Callback on Skip Button Pressed
  final Function()? onTapSkipButton;
  const IntroScreenOnBoarding({
    Key? key,
    this.introductionList,
    this.onTapSkipButton,
    this.backgroudColor,
    this.foregroundColor,
    this.skipTextStyle = const TextStyle(fontSize: 20),
    this.topIconButton,
  }) : super(key: key);

  @override
  _IntroScreenOnBoardingState createState() => _IntroScreenOnBoardingState();
}

class _IntroScreenOnBoardingState extends State<IntroScreenOnBoarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  double progressPercent = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          color: widget.backgroudColor ?? Theme.of(context).backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AnimatedOpacity(
                        opacity: _currentPage == 0 ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0.0,
                              right: 0.0,
                              child: Container(
                                alignment: Alignment.topRight,
                                height: 48.0,
                                width: 50.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF6768FF),
                                  borderRadius: BorderRadius.circular(23.0),
                                ),
                              ),
                            ),
                            widget.topIconButton!,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 550.0,
                    child: PageView(
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: widget.introductionList!,
                    ),
                  ),
                ),
                //                Row(
                //                  mainAxisAlignment: MainAxisAlignment.center,
                //                  children: _buildPageIndicator(),
                //                ),
                _customProgress(),
                //_buildNextButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

//  Widget _buildNextButton() {
//    return (_currentPage != widget.introductionList.length - 1
//        ? Expanded(
//      child: Align(
//        alignment: FractionalOffset.bottomRight,
//        child: FlatButton(
//          onPressed: () {
//            _pageController.nextPage(
//              duration: Duration(milliseconds: 500),
//              curve: Curves.ease,
//            );
//          },
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
////                    Text(
////                      'Next',
////                      style: TextStyle(
////                        color: Colors.black,
////                        fontSize: 22.0,
////                      ),
////                    ),
//            ],
//          ),
//        ),
//      ),
//    )
//        : Expanded(
//      child: Align(
//        alignment: FractionalOffset.bottomRight,
//        child: FlatButton(
//          onPressed: () {
//            print('Start');
//          },
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            mainAxisSize: MainAxisSize.min,
//            children: <Widget>[
////                    Text(
////                      'Start',
////                      style: TextStyle(
////                        color: Colors.black,
////                        fontSize: 22.0,
////                      ),
////                    ),
//            ],
//          ),
//        ),
//      ),
//    ));
//  }

//  Widget _indicator(bool isActive) {
//    return AnimatedContainer(
//      duration: Duration(milliseconds: 150),
//      margin: EdgeInsets.symmetric(horizontal: 8.0),
//      height: 8.0,
//      width: isActive ? 24 : 16,
//      decoration: BoxDecoration(
//        color: isActive ? Color(0xFF7B51D3) : Colors.grey,
//        borderRadius: BorderRadius.all(Radius.circular(10)),
//      ),
//    );
//  }

//  List<Widget> _buildPageIndicator() {
//    List<Widget> list = [];
//    for (int i = 0; i < widget.introductionList.length; i++) {
//      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
//    }
//    return list;
//  }

  Widget _customProgress() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 118,
              child: CircleProgressBar(
                backgroundColor: Colors.white,
                foregroundColor:
                    widget.foregroundColor ?? const Color(0xFF6768FF),
                value: 0.15,
              ),
            ),
            Container(
              height: 104,
              width: 102,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (widget.foregroundColor ?? const Color(0xFF6768FF)),
              ),
              child: IconButton(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.only(top: 3),
                onPressed: () {
                  _currentPage != widget.introductionList!.length - 1
                      ? _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.ease,
                        )
                      : widget.onTapSkipButton!();
                },
                icon: const Icon(
                  Pelaicons.right_arrow_2_light_outline,
                  color: Colors.white,
                ),
                iconSize: 60,
              ),
            )
          ],
        ),
        Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 35),
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentPage,
                  count: widget.introductionList!.length,
                  effect: const ColorTransitionEffect(
                    activeDotColor: Color(0xFF6768FF),
                    dotWidth: 14.0,
                    dotHeight: 8.0,
                    radius: 5.0,
                    dotColor: Color(0xFAD7D7D7),
                  ),
                ),
                // child: DotsIndicator(
                //   dotsCount: widget.introductionList!.length,
                //   position: _currentPage,
                //   decorator: DotsDecorator(
                //     size: const Size(18.0, 9.0),
                //     activeSize: const Size(18.0, 9.0),
                //     activeColor: const Color(0xFF6768FF),
                //     activeShape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(5.0),
                //     ),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(5.0),
                //     ),
                //   ),
                // ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, right: 25),
                child: TextButton(
                  onPressed: widget.onTapSkipButton,
                  child: Text('Skip', style: widget.skipTextStyle),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
