import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String languageCode;
  final bool isDarkMode;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.languageCode,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isDarkMode ? Color(0xFF2D2D2D) : Color(0xFF2D2D2D);
    
    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 60.h),
            painter: WavePainter(
              currentIndex: currentIndex,
              itemCount: 4,
            ),
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(icon: Icons.home_rounded, index: 0),
              _buildNavItem(icon: Icons.insert_chart_outlined_rounded, index: 1),
              _buildNavItem(icon: Icons.bar_chart_rounded, index: 2),
              _buildNavItem(icon: Icons.person_outline_rounded, index: 3),
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
          height: 60.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.5),
                size: 24.sp,
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
    
    path.moveTo(centerX - itemWidth * 0.6, 0);
    
    path.quadraticBezierTo(
      centerX - itemWidth * 0.3,
      -12,
      centerX,
      -16,
    );
    
    path.quadraticBezierTo(
      centerX + itemWidth * 0.3,
      -12,
      centerX + itemWidth * 0.6,
      0,
    );
    
    path.lineTo(centerX + itemWidth * 0.6, 6);
    
    path.quadraticBezierTo(
      centerX + itemWidth * 0.3,
      4,
      centerX,
      2,
    );
    
    path.quadraticBezierTo(
      centerX - itemWidth * 0.3,
      4,
      centerX - itemWidth * 0.6,
      6,
    );
    
    path.close();
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) {
    return oldDelegate.currentIndex != currentIndex;
  }
}
