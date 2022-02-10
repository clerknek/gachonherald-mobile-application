import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter_gms/setting.dart';

// 글자 크기
double textsize = 25.0;

class SliderController {
  double sliderValue;
  SliderController(this.sliderValue);
}

// 글자 폰트
var ffList = ['arial', 'calibri', 'enbrush', 'freehand', 'roboto', 'verdana'];

// 글자 색깔
double tSSP = 0.0;
double tCSP = 0.0;


class TextSliderIndicatorPainter extends CustomPainter {
  final double textPosition;

  TextSliderIndicatorPainter(this.textPosition);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(textPosition, size.height / 2), 12, Paint()..color = Colors.black);
  }

  @override
  bool shouldRepaint(TextSliderIndicatorPainter old) {
    return true;
  }
}




// 배경 색깔

double bSSP = 250.0;
double bCSP = 0.0;

class SliderIndicatorPainter extends CustomPainter {
  final double position;
  SliderIndicatorPainter(this.position);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(
        Offset(position, size.height / 2), 12, Paint()..color = Colors.black);
  }
  @override
  bool shouldRepaint(SliderIndicatorPainter old) {
    return true;
  }
}


Color textcolor = const Color.fromARGB(255, 0, 0, 0);
Color bgcolor = const Color.fromARGB(255, 255, 255, 255);


class SettingChanger extends StatefulWidget {
  final double width;

  const SettingChanger(this.width, {Key? key}) : super(key: key);

  @override
  SettingChangerState createState() => SettingChangerState();
}


class SettingChangerState extends State<SettingChanger> {

  // 글자 크기
  final SliderController _secondSliderController = SliderController(textsize);    // 초기 text size
  Widget buildSlider({
    SliderController? controller,
    int? divisions,
    Color color = Colors.green,
    double enabledThumbRadius = 10.0,
    double elevation = 1.0,
  }) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: color,
              thumbColor: color,
              activeTickMarkColor: color,
              valueIndicatorColor: color,
              trackHeight: 10.0,
              thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: enabledThumbRadius,
                elevation: elevation,
              ),
              valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            ),

            child: Slider(
              value: controller!.sliderValue,
              min: 10.0,
              max: 35.0,
              divisions: divisions,
              label: '${controller.sliderValue.round()}',
              onChanged: (double newValue) {
                setState(() {
                  controller.sliderValue = newValue;
                  textsize = newValue;
                },);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 글자 색깔
  final List<Color> _colors = [
    const Color.fromARGB(255, 255, 0, 0),
    const Color.fromARGB(255, 255, 128, 0),
    const Color.fromARGB(255, 255, 255, 0),
    const Color.fromARGB(255, 128, 255, 0),
    const Color.fromARGB(255, 0, 255, 0),
    const Color.fromARGB(255, 0, 255, 128),
    const Color.fromARGB(255, 0, 255, 255),
    const Color.fromARGB(255, 0, 128, 255),
    const Color.fromARGB(255, 0, 0, 255),
    const Color.fromARGB(255, 127, 0, 255),
    const Color.fromARGB(255, 255, 0, 255),
    const Color.fromARGB(255, 255, 0, 127),
    const Color.fromARGB(255, 128, 128, 128),
  ];
  double _textColorSliderPosition = tCSP;
  late double _textShadeSliderPosition;
  late Color _currentTextColor;
  late Color _shadedTextColor;
  double _bgColorSliderPosition = bCSP;
  late double _bgShadeSliderPosition;
  late Color _currentBGColor;
  late Color _shadedBGColor;


  @override
  initState() {
    super.initState();
    _currentTextColor = textcolor;
    _textShadeSliderPosition = tSSP; //center the shader selector
    _shadedTextColor = textcolor;
    _currentBGColor = bgcolor;
    _bgShadeSliderPosition = bSSP; //center the shader selector
    _shadedBGColor = bgcolor;
  }

  _textColorChangeHandler(double position) {
    if (position > widget.width) {
      position = widget.width;
    }
    if (position < 0) {
      position = 0;
    }
    setState(() {
      _textColorSliderPosition = position;
      _currentTextColor = _calculateTextSelectedColor(_textColorSliderPosition);
      _shadedTextColor = _calculateTextShadedColor(_textShadeSliderPosition);
    });
  }

  _textShadeChangeHandler(double position) {
    if (position > widget.width) position = widget.width;
    if (position < 0) position = 0;
    setState(() {
      _textShadeSliderPosition = position;
      _shadedTextColor = _calculateTextShadedColor(_textShadeSliderPosition);
    });
  }

  Color _calculateTextShadedColor(double position) {
    double ratio = position / widget.width;
    if (ratio > 0.5) {
      int redVal = _currentTextColor.red != 255
          ? (_currentTextColor.red +
                  (255 - _currentTextColor.red) * (ratio - 0.5) / 0.5)
              .round()
          : 255;
      int greenVal = _currentTextColor.green != 255
          ? (_currentTextColor.green +
                  (255 - _currentTextColor.green) * (ratio - 0.5) / 0.5)
              .round()
          : 255;
      int blueVal = _currentTextColor.blue != 255
          ? (_currentTextColor.blue +
                  (255 - _currentTextColor.blue) * (ratio - 0.5) / 0.5)
              .round()
          : 255;
      return Color.fromARGB(255, redVal, greenVal, blueVal);
    } else if (ratio < 0.5) {
      int redVal = _currentTextColor.red != 0
          ? (_currentTextColor.red * ratio / 0.5).round()
          : 0;
      int greenVal = _currentTextColor.green != 0
          ? (_currentTextColor.green * ratio / 0.5).round()
          : 0;
      int blueVal = _currentTextColor.blue != 0
          ? (_currentTextColor.blue * ratio / 0.5).round()
          : 0;
      return Color.fromARGB(255, redVal, greenVal, blueVal);
    } else {
      return _currentTextColor;
    }
  }

  Color _calculateTextSelectedColor(double position) {
    double positionInColorArray =
        (position / widget.width * (_colors.length - 1));
    int index = positionInColorArray.truncate();
    double remainder = positionInColorArray - index;
    if (remainder == 0.0) {
      _currentTextColor = _colors[index];
    } else {
      int redValue = _colors[index].red == _colors[index + 1].red
          ? _colors[index].red
          : (_colors[index].red +
                  (_colors[index + 1].red - _colors[index].red) * remainder)
              .round();
      int greenValue = _colors[index].green == _colors[index + 1].green
          ? _colors[index].green
          : (_colors[index].green +
                  (_colors[index + 1].green - _colors[index].green) * remainder)
              .round();
      int blueValue = _colors[index].blue == _colors[index + 1].blue
          ? _colors[index].blue
          : (_colors[index].blue +
                  (_colors[index + 1].blue - _colors[index].blue) * remainder)
              .round();
      _currentTextColor = Color.fromARGB(255, redValue, greenValue, blueValue);
    }
    return _currentTextColor;
  }

  // 배경 색깔

  _bgColorChangeHandler(double position) {
    if (position > widget.width) {
      position = widget.width;
    }
    if (position < 0) {
      position = 0;
    }
    setState(() {
      _bgColorSliderPosition = position;
      _currentBGColor = _calculateBGSelectedColor(_bgColorSliderPosition);
      _shadedBGColor = _calculateBGShadedColor(_bgShadeSliderPosition);
    });
  }
  _bgShadeChangeHandler(double position) {
    if (position > widget.width) position = widget.width;
    if (position < 0) position = 0;
    setState(() {
      _bgShadeSliderPosition = position;
      _shadedBGColor = _calculateBGShadedColor(_bgShadeSliderPosition);
    });
  }
  Color _calculateBGShadedColor(double position) {
    double ratio = position / widget.width;
    if (ratio > 0.5) {
      int redVal = _currentBGColor.red != 255
          ? (_currentBGColor.red +
          (255 - _currentBGColor.red) * (ratio - 0.5) / 0.5)
          .round()
          : 255;
      int greenVal = _currentBGColor.green != 255
          ? (_currentBGColor.green +
          (255 - _currentBGColor.green) * (ratio - 0.5) / 0.5)
          .round()
          : 255;
      int blueVal = _currentBGColor.blue != 255
          ? (_currentBGColor.blue +
          (255 - _currentBGColor.blue) * (ratio - 0.5) / 0.5)
          .round()
          : 255;
      return Color.fromARGB(255, redVal, greenVal, blueVal);
    } else if (ratio < 0.5) {
      int redVal = _currentBGColor.red != 0
          ? (_currentBGColor.red * ratio / 0.5).round()
          : 0;
      int greenVal = _currentBGColor.green != 0
          ? (_currentBGColor.green * ratio / 0.5).round()
          : 0;
      int blueVal = _currentBGColor.blue != 0
          ? (_currentBGColor.blue * ratio / 0.5).round()
          : 0;
      return Color.fromARGB(255, redVal, greenVal, blueVal);
    } else {
      return _currentBGColor;
    }
  }
  Color _calculateBGSelectedColor(double position) {
    double positionInColorArray =
    (position / widget.width * (_colors.length - 1));
    int index = positionInColorArray.truncate();
    double remainder = positionInColorArray - index;
    if (remainder == 0.0) {
      _currentBGColor = _colors[index];
    } else {
      int redValue = _colors[index].red == _colors[index + 1].red
          ? _colors[index].red
          : (_colors[index].red +
          (_colors[index + 1].red - _colors[index].red) * remainder)
          .round();
      int greenValue = _colors[index].green == _colors[index + 1].green
          ? _colors[index].green
          : (_colors[index].green +
          (_colors[index + 1].green - _colors[index].green) * remainder)
          .round();
      int blueValue = _colors[index].blue == _colors[index + 1].blue
          ? _colors[index].blue
          : (_colors[index].blue +
          (_colors[index + 1].blue - _colors[index].blue) * remainder)
          .round();
      _currentBGColor = Color.fromARGB(255, redValue, greenValue, blueValue);
    }
    return _currentBGColor;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: bC = _shadedBGColor,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Text(
              "This is sample text \nThis is sample text",
              style: TextStyle(
                  color: tC = _shadedTextColor,
                  fontSize: tS = textsize,
                  fontFamily: fF = recentFont,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),

        const Divider(thickness: 2.0,),
        // 글꼴
        ListTile(
          leading: const Icon(Icons.font_download_outlined),

          title: Row(
            children: [
              const Text("글꼴"),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              DropdownButton(
                value: recentFont,
                items: ffList.map((value) {
                  return DropdownMenuItem(value: value, child: Text(value));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    recentFont = (value as String?)!;
                  });
                },
              ),
            ],
          ),
        ),
        // 글자 크기
        ListTile(
          leading: const Icon(Icons.format_size),
          title: Row(
            children: [
              const Text("크기"),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSlider(
                      controller: _secondSliderController,
                      divisions: 5,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // 기사 보는 방식
        ListTile(
          leading: const Icon(Icons.menu_book_outlined),
          title: Row(
            children: [
              const Text("페이지"),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              ToggleSwitch(
                minWidth: MediaQuery.of(context).size.width * 0.25,
                initialLabelIndex: 0,
                cornerRadius: 20.0,
                activeFgColor: Colors.white,
                inactiveBgColor: Colors.grey,
                inactiveFgColor: Colors.white,
                totalSwitches: 2,
                labels: const ['스크롤', '좌우'],
                icons: const [
                  Icons.height,
                  Icons.arrow_right_alt_sharp,
                ],
                activeBgColors: const [
                  [Colors.blue],
                  [Colors.pink]
                ],
                onToggle: (index) {
                },
              ),
            ],
          ),
        ),

        // 글자 색깔
        ListTile(
          leading: const Icon(Icons.color_lens),
          title: Row(
            children: const [Text("글자색")],
          ),
        ),
        Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: (DragStartDetails details) {
              _textColorChangeHandler(details.localPosition.dx);
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              _textColorChangeHandler(details.localPosition.dx);
            },
            onTapDown: (TapDownDetails details) {
              _textColorChangeHandler(details.localPosition.dx);
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: widget.width,
                height: 15,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: _colors),
                ),
                child: CustomPaint(
                  painter: TextSliderIndicatorPainter(tCSP = _textColorSliderPosition),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: (DragStartDetails details) {
              _textShadeChangeHandler(details.localPosition.dx);
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              _textShadeChangeHandler(details.localPosition.dx);
            },
            onTapDown: (TapDownDetails details) {
              _textShadeChangeHandler(details.localPosition.dx);
            },
            //This outside padding makes it much easier to grab the slider because the gesture detector has
            // the extra padding to recognize gestures inside of
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: widget.width,
                height: 15,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      colors: [Colors.black, _currentTextColor, Colors.white]),
                ),
                child: CustomPaint(
                  painter: TextSliderIndicatorPainter(tSSP = _textShadeSliderPosition),
                ),
              ),
            ),
          ),
        ),
        // 배경 색깔
        ListTile(
          leading: const Icon(Icons.image),
          title: Row(
            children: const [Text("배경")],
          ),
        ),
        Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: (DragStartDetails details) {
              _bgColorChangeHandler(details.localPosition.dx);
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              _bgColorChangeHandler(details.localPosition.dx);
            },
            onTapDown: (TapDownDetails details) {
              _bgColorChangeHandler(details.localPosition.dx);
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: widget.width,
                height: 15,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: _colors),
                ),
                child: CustomPaint(
                  painter: SliderIndicatorPainter(bCSP = _bgColorSliderPosition),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onHorizontalDragStart: (DragStartDetails details) {
              _bgShadeChangeHandler(details.localPosition.dx);
            },
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              _bgShadeChangeHandler(details.localPosition.dx);
            },
            onTapDown: (TapDownDetails details) {
              _bgShadeChangeHandler(details.localPosition.dx);
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                width: widget.width,
                height: 15,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.grey),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                      colors: [Colors.black, _currentBGColor, Colors.white]),
                ),
                child: CustomPaint(
                  painter: SliderIndicatorPainter(bSSP = _bgShadeSliderPosition),
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
