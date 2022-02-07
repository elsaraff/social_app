import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageWrapper extends StatefulWidget {
  final ImageProvider imageProvider;
  final LoadingBuilder loadingBuilder;
  final BoxDecoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final dynamic initialScale;
  final ImageErrorWidgetBuilder? errorBuilder;

  const ImageWrapper({
    Key? key,
    required this.imageProvider,
    required this.loadingBuilder,
    required this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialScale,
    this.errorBuilder,
  }) : super(key: key);

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
