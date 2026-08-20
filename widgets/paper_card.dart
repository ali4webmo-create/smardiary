import 'package:flutter/material.dart';
import '../themes/leather_theme.dart';

class PaperCard extends StatelessWidget {
  final Widget child;
  final String? title;
  final bool hasTexture;

  const PaperCard({
    Key? key,
    required this.child,
    this.title,
    this.hasTexture = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LeatherTheme.paperDark,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: LeatherTheme.stitch, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          if (hasTexture)
            Positioned.fill(
              child: Opacity(
                opacity: 0.25,
                child: Image.asset(
                  'assets/images/paper_texture.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(title!, style: LeatherTheme.titleMedium),
                  const SizedBox(height: 8),
                ],
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}