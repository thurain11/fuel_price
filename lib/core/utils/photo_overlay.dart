import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewOverlay extends ModalRoute<void> {
  PhotoViewOverlay(this.image);
  final String? image;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true; // Allow tapping outside to close

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8); // Darker overlay

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        // PhotoView with custom background and scaling
        Hero(
          tag: image!, // Unique tag for the Hero animation
          child: Center(
            child: PhotoView(
              imageProvider: NetworkImage(image!),
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.covered * 2,
              backgroundDecoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
              tightMode: true,
              filterQuality: FilterQuality.high,
            ),
          ),
        ),

        // Close button
        Positioned(
          right: 20,
          top: 20,
          child: CircleAvatar(
            backgroundColor: Colors.black54,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    // Smooth fade and scale animation
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.easeInOut,
    );

    return FadeTransition(
      opacity: curvedAnimation,
      child: ScaleTransition(
        scale: curvedAnimation,
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}