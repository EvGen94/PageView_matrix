

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../extensions/color_ext.dart';

class NeumorphicContainer extends StatefulWidget {
  final Widget child;
  final double bevel;
  final Offset blurOffset;
  final Color color;

  NeumorphicContainer({
    Key key,
    this.child,
    this.bevel = 10.0,
    this.color,
  })  : blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  _NeumorphicContainerState createState() => _NeumorphicContainerState();
}

class _NeumorphicContainerState extends State<NeumorphicContainer> {
  bool _isPressed = false;
  Size containerSize;
  Offset dOffset;
  bool shadow1 = true;
  bool shadow2 = true;
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


  void _onPointerDown(PointerDownEvent event, Size size) {

    final centerX = size.width / 2;
    final centerY = size.height / 2;


    final touchX = event.localPosition.dx;
    final touchY = event.localPosition.dy;

    final deltaX = touchX - centerX;
    final deltaY = touchY - centerY;

    final deltaOffset = (-Offset(deltaX, deltaY)) / 7;


    setState(() {
      dOffset = deltaOffset;
      if (deltaOffset.dx < 0) {
        if (deltaOffset.dy < 0) {
          shadow1 = true;
          shadow2 = false;
        }
        else {
          shadow1 = true;
          shadow2 = true;
        }        
      } else {
        if (deltaOffset.dy < 0) {
          shadow1 = true;
          shadow2 = true;
        }
        else {
          shadow1 = false;
          shadow2 = true;
        }    
      }
      _isPressed = true;
    });

  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
      shadow1 = true;
      shadow2 = true;
    });

  }

    @override
  Widget build(BuildContext context) {
    final color = widget.color ?? Theme.of(context).backgroundColor;

    return Listener(
      onPointerDown: (event) => _onPointerDown(event, containerSize),
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        key: _key,
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(48.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.bevel * 10),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                if (!(shadow1 && shadow2)) if (shadow2) color.mix(Colors.white, _isPressed ? .2 : .5) else color else color,
                if (_isPressed) color.mix(Colors.black, .05) else color,
                if (_isPressed) color.mix(Colors.black, .05) else color,
                if (shadow1) color.mix(Colors.white, _isPressed ? .2 : .5) else color,
              ],
              stops: [
                0.0,
                .3,
                .6,
                1.0,
              ],
            ),
          boxShadow: _isPressed ? [
            if (shadow1) BoxShadow(
              blurRadius: widget.bevel / 1.2,
              offset: -widget.blurOffset + dOffset,
              color: color.mix(Colors.white, .6),
            ),
            if (shadow2) BoxShadow(
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
        child: widget.child,
      ),
    );
  }

}