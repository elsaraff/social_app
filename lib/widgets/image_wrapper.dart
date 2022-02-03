import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageWrapper extends StatefulWidget {
  const ImageWrapper({
    Key key,
    this.imageProvider,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialScale,
    this.errorBuilder,
  }) : super(key: key);

  final ImageProvider imageProvider;
  final LoadingBuilder loadingBuilder;
  final BoxDecoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final dynamic initialScale;
  final ImageErrorWidgetBuilder errorBuilder;

  @override
  State<ImageWrapper> createState() => _ImageWrapperState();
}

class _ImageWrapperState extends State<ImageWrapper> {
  final PhotoViewController _controller = PhotoViewController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: ClipRect(
          child: PhotoView(
            controller: _controller,
            imageProvider: widget.imageProvider,
            loadingBuilder: widget.loadingBuilder,
            backgroundDecoration: widget.backgroundDecoration,
            minScale: widget.minScale,
            maxScale: widget.maxScale,
            initialScale: widget.initialScale,
            errorBuilder: widget.errorBuilder,
            enableRotation: false,
          ),
        ),
      ),
    );
  }
}
