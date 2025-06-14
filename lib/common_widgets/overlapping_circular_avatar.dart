import 'package:flutter/material.dart';

class OverlappingCircularAvatars extends StatelessWidget {
  final List<String> imageUrls;
  final double size;
  final double overlap;
  final double borderWidth;
  final Color borderColor;

  const OverlappingCircularAvatars({
    Key? key,
    required this.imageUrls,
    this.size = 20.0, // Smaller size for notifications context
    this.overlap = 10.0,
    this.borderWidth = 1.0,
    this.borderColor = Colors.white,
  }) : super(key: key);

  @override
 Widget build(BuildContext context) {
    return SizedBox(
      width: size + ((imageUrls.length - 1) * (size - overlap) / 2)+5,
      height: size + ((imageUrls.length - 1) * (size - overlap) / 2)+5,
      child: Stack(
        children: List.generate(imageUrls.length, (index) {
          return Positioned(
            left: index * (size - overlap) / 2,
            top: index * (size - overlap) / 2,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: borderColor,
                  width: borderWidth,
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  imageUrls[index],
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: size,
                      height: size,
                      color: Colors.grey.shade300,
                      child: Icon(
                        Icons.person,
                        size: size / 2,
                        color: Colors.grey.shade600,
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
