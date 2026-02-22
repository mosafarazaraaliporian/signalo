import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui';

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
    return Container(
      height: 70.h,
      child: Stack(
        children: [
          // Base layer with gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1A0B2E),
                    Color(0xFF0A0015),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF9D4EDD).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
            ),
          ),
          
          // Glass layer
          Positioned.fill(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.1),
                        Colors.white.withValues(alpha: 0.05),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Purple-Gold wave indicator
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 70.h),
            painter: LuxuryWavePainter(
              currentIndex: currentIndex,
              itemCount: 3,
            ),
          ),
          
          // Navigation items
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(icon: Icons.home_rounded, index: 0),
                _buildNavItem(icon: Icons.show_chart_rounded, index: 1),
                _buildNavItem(icon: Icons.settings_rounded, index: 2),
              ],
            ),
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
          height: 70.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.all(isSelected ? 10.w : 8.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            Color(0xFFFFD700),
                            Color(0xFF9D4EDD),
                            Color(0xFF7B2CBF),
                          ],
                        )
                      : null,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Color(0xFF9D4EDD).withValues(alpha: 0.6),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                          BoxShadow(
                            color: Color(0xFFFFD700).withValues(alpha: 0.4),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: isSelected ? 26.sp : 22.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LuxuryWavePainter extends CustomPainter {
  final int currentIndex;
  final int itemCount;

  LuxuryWavePainter({
    required this.currentIndex,
    required this.itemCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final itemWidth = size.width / itemCount;
    final centerX = (currentIndex + 0.5) * itemWidth;
    
    // Layer 1 - Gold glow
    final goldGlowPaint = Paint()
      ..color = Color(0xFFFFD700).withValues(alpha: 0.3)
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20);
    
    final goldGlowPath = _createWavePath(centerX, itemWidth, -24, 10);
    canvas.drawPath(goldGlowPath, goldGlowPaint);
    
    // Layer 2 - Purple glow
    final purpleGlowPaint = Paint()
      ..color = Color(0xFF9D4EDD).withValues(alpha: 0.4)
      ..style = PaintingStyle.fill
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15);
    
    final purpleGlowPath = _createWavePath(centerX, itemWidth, -20, 8);
    canvas.drawPath(purpleGlowPath, purpleGlowPaint);
    
    // Layer 3 - Main gradient wave
    final mainPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Color(0xFFFFD700),
          Color(0xFFFFE55C),
          Color(0xFF9D4EDD),
          Color(0xFF7B2CBF),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    
    final mainPath = _createWavePath(centerX, itemWidth, -18, 6);
    canvas.drawPath(mainPath, mainPaint);
    
    // Layer 4 - Inner highlight
    final highlightPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: 0.6),
          Colors.white.withValues(alpha: 0.2),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    
    final highlightPath = _createWavePath(centerX, itemWidth, -16, 4);
    canvas.drawPath(highlightPath, highlightPaint);
  }

  Path _createWavePath(double centerX, double itemWidth, double peakHeight, double bottomHeight) {
    final path = Path();
    
    path.moveTo(centerX - itemWidth * 0.5, 0);
    
    path.quadraticBezierTo(
      centerX - itemWidth * 0.25,
      peakHeight * 0.7,
      centerX,
      peakHeight,
    );
    
    path.quadraticBezierTo(
      centerX + itemWidth * 0.25,
      peakHeight * 0.7,
      centerX + itemWidth * 0.5,
      0,
    );
    
    path.lineTo(centerX + itemWidth * 0.5, bottomHeight);
    
    path.quadraticBezierTo(
      centerX + itemWidth * 0.25,
      bottomHeight * 0.6,
      centerX,
      bottomHeight * 0.4,
    );
    
    path.quadraticBezierTo(
      centerX - itemWidth * 0.25,
      bottomHeight * 0.6,
      centerX - itemWidth * 0.5,
      bottomHeight,
    );
    
    path.close();
    
    return path;
  }

  @override
  bool shouldRepaint(LuxuryWavePainter oldDelegate) {
    return oldDelegate.currentIndex != currentIndex;
  }
}
