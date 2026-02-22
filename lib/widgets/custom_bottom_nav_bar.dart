import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String languageCode;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.languageCode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      child: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Container(
              color: Color(0xFF2D2D2D),
            ),
          ),
          
          // Pink wave indicator
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 65),
            painter: WavePainter(
              currentIndex: currentIndex,
              itemCount: 4,
            ),
          ),
          
          // Navigation items
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                index: 0,
              ),
              _buildNavItem(
                icon: Icons.insert_chart_outlined_rounded,
                index: 1,
              ),
              _buildNavItem(
                icon: Icons.bar_chart_rounded,
                index: 2,
              ),
              _buildNavItem(
                icon: Icons.refresh_rounded,
                index: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required int index,
  }) {
    final isSelected = currentIndex == index;
    
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        child: Container(
          height: 65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final int currentIndex;
  final int itemCount;

  WavePainter({
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFE91E63)
      ..style = PaintingStyle.fill;

    final itemWidth = size.width / itemCount;
    final centerX = (currentIndex + 0.5) * itemWidth;
    
    final path = Path();
    
    // Start from left
    path.moveTo(centerX - itemWidth * 0.6, 0);
    
    // Create wave curve
    path.quadraticBezierTo(
      centerX - itemWidth * 0.3,
      -15,
      centerX,
      -20,
    );
    
    path.quadraticBezierTo(
      centerX + itemWidth * 0.3,
      -15,
      centerX + itemWidth * 0.6,
      0,
    );
    
    // Complete the shape
    path.lineTo(centerX + itemWidth * 0.6, 8);
    
    path.quadraticBezierTo(
      centerX + itemWidth * 0.3,
      5,
      centerX,
      3,
    );
    
    path.quadraticBezierTo(
      centerX - itemWidth * 0.3,
      5,
      centerX - itemWidth * 0.6,
      8,
    );
    
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.currentIndex != currentIndex;
  }
}
