import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import '../extensions/color_ext.dart';

class NeumorphicButton extends StatefulWidget {
  final double bevel;
  final Offset blurOffset;
  final Color color;
  final Function() onPressed;
  final String title;
  final bool isLarge;

  NeumorphicButton({
    Key key,
    this.bevel = 10.0,
    this.color, this.onPressed, this.title, this.isLarge,
  })  : blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  _NeumorphicButtonState createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;
  Size containerSize;
  Offset dOffset;
  Alignment alignment1;
  Alignment alignment2;
  bool isCenter = false;
  final GlobalKey _key = GlobalKey();

  void _getSize() {
    final RenderBox box = _key.currentContext.findRenderObject() as RenderBox;

    setState(() {
      containerSize = box.size;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getSize());
  }

  void _handleTap(PointerEvent event, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final touchX = event.localPosition.dx;
    final touchY = event.localPosition.dy;

    final deltaX = touchX - centerX;
    final deltaY = touchY - centerY;

    final double alX11 = deltaX / (size.width / 2);
    final double alX12 = deltaY / (size.height / 2);
    final double alX21 = -alX11;
    final double alX22 = -alX12;

    final deltaOffset = (-Offset(deltaX, deltaY)) / (size.height / 25);

    setState(() {
      dOffset = deltaOffset;
      _isPressed = true;
      alignment1 = Alignment(alX11, alX12);
      alignment2 = Alignment(alX21, alX22);

      double numb = size.width / 5;

      if ((centerX + numb) > touchX && (centerY + numb) > touchY 
          && (centerX - numb) < touchX && (centerY - numb) < touchY) {
            isCenter = true;
        } else {
          isCenter = false;
        }
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
      isCenter = false;
    });

    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).backgroundColor;

    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (event) => _handleTap(event, containerSize),
      onPointerMove: (event) => _handleTap(event, containerSize),
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        key: _key,
        width: widget.isLarge ? MediaQuery.of(context).size.width * .9 : null,
        height: widget.isLarge ? (MediaQuery.of(context).size.width * .9) * 1.5 : null,
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.bevel * 10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                if (_isPressed) color else color.mix(Colors.black, .1),
                if (_isPressed) color.mix(Colors.black, .05) else color,
                if (_isPressed) color.mix(Colors.black, .05) else color,
                color.mix(Colors.white, _isPressed ? .2 : .5),
              ],
              stops: [
                0.0,
                .3,
                .6,
                1.0,
              ],
            ),
          boxShadow: _isPressed ? isCenter ? null : [
            BoxShadow(
              blurRadius: widget.bevel / 1.2,
              offset: -widget.blurOffset + dOffset,
              color: color.mix(Colors.white, .6),
            ),
            BoxShadow(
              blurRadius: widget.bevel / 1.2,
              offset: widget.blurOffset + dOffset,
              color: color.mix(Colors.black, .3),
            ),
          ] : [
            BoxShadow(
              blurRadius: widget.bevel,
              offset: -widget.blurOffset,
              color: color.mix(Colors.white, .6),
            ),
            BoxShadow(
              blurRadius: widget.bevel,
              offset: widget.blurOffset,
              color: color.mix(Colors.black, .3),
            )
          ],
        ),
        padding: const EdgeInsets.all(48),
        child: Center(
          child: _isPressed && !isCenter ? 
          GradientText(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 40),
            gradient: LinearGradient(
              begin: alignment1,
              end: alignment2,
              colors: [
                  Colors.black,
                  Colors.black,
                  Colors.black54,
                ],
                stops: [
                  0.0,
                  0.02,
                  1,
                ],
              ),
            ) :
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(
              fontSize: 40,
              color: Colors.black54,
              ),
            ),
        ),
      ),
    );
  }

}