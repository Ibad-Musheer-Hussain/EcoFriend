import 'dart:async';
import 'package:ecofriend/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Better extends StatefulWidget {
  const Better({super.key});

  @override
  State<Better> createState() => _BetterState();
}

class _BetterState extends State<Better> with SingleTickerProviderStateMixin {
  double _currentOffset = -75;
  double _currentOffsetText = -55;
  late AnimationController _controller;
  bool _isForward = true;
  Color _areyouready = Color(0xFFF98805);
  Color _tobebetter = Color(0xFFF8DBDB);
  Color _todobetter = Color(0xFF1A2F0E);
  Timer? _timer;
  Color loadercolor = Color(0xFF1A2F0E);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    startTimer();
    _navigateAfterDelay();
  }

  void _navigateAfterDelay() async {
    await Future.delayed(Duration(milliseconds: 4500));
    setState(() {
      loadercolor = Colors.transparent;
    });
    await Future.delayed(Duration(milliseconds: 500));
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => Login(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void startTimer() {
    _timer?.cancel();

    Future.delayed(Duration(milliseconds: 500), () {
      _toggleOffset();
      _toggleAnimation();

      _timer = Timer.periodic(Duration(milliseconds: 2500), (Timer timer) {
        _toggleOffset();
        _toggleAnimation();
      });
    });
  }

  void resetTimer() {
    print('Timer reset!');
    startTimer();
  }

  void _toggleOffset() {
    setState(() {
      _currentOffset = _currentOffset == -75 ? 75 : -75;
      _currentOffsetText = _currentOffsetText == -55 ? 55 : -55;
    });
  }

  void _toggleColor() {
    setState(() {
      _areyouready = _areyouready == Color(0xFFF98805)
          ? Color(0xFF1A2F0E)
          : Color(0xFFF98805);

      _todobetter = _todobetter == Color(0xFFF8DBDB)
          ? Color(0XDDE255)
          : Color(0xFFF8DBDB);

      _tobebetter = _tobebetter == Color(0xFF1A2F0E)
          ? Color(0xFFF98805)
          : Color(0xFF1A2F0E);
    });
  }

  void _toggleAnimation() {
    if (_isForward) {
      _controller.forward(); // Animate from right to left
    } else {
      _controller.reverse(); // Animate from left to right
    }
    _isForward = !_isForward; // Toggle the direction flag
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFDDE255),
      child: Column(
        children: [
          Spacer(),
          Container(
            //ARE YOU READY
            height: 100,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.transparent,
            ),
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  _toggleOffset();
                  _toggleAnimation();
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  _toggleOffset();
                  _toggleAnimation();
                }
              },
              onTap: () {
                _toggleOffset();
                _toggleAnimation();
                _toggleColor();
              },
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF35695),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      height: 90,
                      width: 250,
                    ),
                  ),
                  Center(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                Color(0xFFF8DBDB),
                                Color(0xFFDDE255),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [
                                _controller.value,
                                _controller.value - 0.5
                              ],
                            ).createShader(bounds);
                          },
                          child: Center(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              transform: Matrix4.translationValues(
                                  -_currentOffsetText, 0, 0),
                              child: Text(
                                "Are You\nReady",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'CenturyGothic',
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [Color(0xFFDDE255), Color(0xFFF8DBDB)],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              stops: [
                                _controller.value,
                                _controller.value - 0.5
                              ],
                            ).createShader(bounds);
                          },
                          child: Center(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              transform: Matrix4.translationValues(
                                  _currentOffset, 0, 0),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            //TO BE BETTER
            height: 100,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.transparent,
            ),
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  _toggleOffset();
                  _toggleAnimation();
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  _toggleOffset();
                  _toggleAnimation();
                }
              },
              onTap: () {
                _toggleOffset();
                _toggleAnimation();
                _toggleColor();
              },
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF98805),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      height: 90,
                      width: 250,
                    ),
                  ),
                  Center(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                Color(0xFFF8DBDB),
                                Color(0xFF1A2F0E),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [
                                _controller.value,
                                _controller.value - 0.5
                              ],
                            ).createShader(bounds);
                          },
                          child: Center(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              transform: Matrix4.translationValues(
                                  _currentOffsetText, 0, 0),
                              child: Text(
                                "To Be\nBetter",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'CenturyGothic',
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [Color(0xFF1A2F0E), Color(0xFFF8DBDB)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [
                                _controller.value,
                                _controller.value - 0.5
                              ],
                            ).createShader(bounds);
                          },
                          child: Center(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              transform: Matrix4.translationValues(
                                  -_currentOffset, 0, 0),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            // TO DO BETTER
            height: 100,
            width: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.transparent,
            ),
            child: GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dx > 0) {
                  _toggleOffset();
                  _toggleAnimation();
                } else if (details.velocity.pixelsPerSecond.dx < 0) {
                  _toggleOffset();
                  _toggleAnimation();
                }
              },
              onTap: () {
                _toggleOffset();
                _toggleAnimation();
              },
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1A2F0E),
                        borderRadius: BorderRadius.circular(35),
                      ),
                      height: 90,
                      width: 250,
                    ),
                  ),
                  Center(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [
                                Color(0xFFDDE255),
                                Color(0xFFF8DBDB),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [
                                _controller.value,
                                _controller.value - 0.5
                              ],
                            ).createShader(bounds);
                          },
                          child: Center(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              transform: Matrix4.translationValues(
                                  -_currentOffsetText, 0, 0),
                              child: Text(
                                "To Do\nBetter",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'CenturyGothic',
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Center(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: [Color(0xFFF8DBDB), Color(0xFFDDE255)],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              stops: [
                                _controller.value,
                                _controller.value - 0.5
                              ],
                            ).createShader(bounds);
                          },
                          child: Center(
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              transform: Matrix4.translationValues(
                                  _currentOffset, 0, 0),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          CircularProgressIndicator(
            color: loadercolor,
          ),
          Spacer(flex: 2)
        ],
      ),
    );
  }
}
