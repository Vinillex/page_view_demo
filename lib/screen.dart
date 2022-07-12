import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _topController = PageController(
    viewportFraction: 0.8,
  );
  final PageController _bottomController = PageController(
    viewportFraction: 0.8,
  );
  bool _isTopScroll = false;
  bool _isDownScroll = false;

  @override
  void initState() {
    _topController.addListener(() {
      if (_isTopScroll) {
        _bottomController.position.correctPixels(_topController.offset);
        _bottomController.position.notifyListeners();
        //_bottomController.jumpTo(_topController.offset);
      }
    });
    _bottomController.addListener(() {
      if (_isDownScroll) {
        _topController.position.correctPixels(_bottomController.offset);
        _topController.position.notifyListeners();


        //_topController.jumpTo(_bottomController.offset);
      }
    });
    //_bottomController.attach(_topController.position);
    super.initState();
  }

  @override
  void dispose() {
    _topController.dispose();
    _bottomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //print(_controller.position);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page Sample'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is UserScrollNotification) {
                  if (notification.direction != ScrollDirection.idle) {
                    print('scrolling');
                    (_bottomController.position
                            as ScrollPositionWithSingleContext)
                        .goIdle();
                    _isTopScroll = true;
                    _isDownScroll = false;
                  } else {
                    _isTopScroll = false;
                  }
                }
                return false;
              },
              child: PageView(
                controller: _topController,
                padEnds: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.green,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.yellow,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: NotificationListener(
              onNotification: (notification) {
                if (notification is UserScrollNotification) {
                  if (notification.direction != ScrollDirection.idle) {
                    print('scrolling');
                    (_topController.position
                            as ScrollPositionWithSingleContext)
                        .goIdle();
                    _isTopScroll = false;
                    _isDownScroll = true;
                  } else {
                    _isDownScroll = false;
                  }
                }
                return false;
              },
              child: PageView(
                controller: _bottomController,
                padEnds: true,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.blue,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.green,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.yellow,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
