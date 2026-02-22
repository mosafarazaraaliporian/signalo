import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StoryList extends StatelessWidget {
  final bool isDarkMode;
  
  const StoryList({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: 8,
        itemBuilder: (context, index) {
          return _buildStoryItem(
            title: _getStoryTitle(index),
            hasStory: index > 0,
          );
        },
      ),
    );
  }

  String _getStoryTitle(int index) {
    final titles = [
      'Crypto',
      'Market',
      'BTC',
      'ETH',
      'Forex',
      'Gold',
      'EUR',
      'News',
    ];
    return titles[index];
  }

  Widget _buildStoryItem({
    required String title,
    required bool hasStory,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.w),
      child: Column(
        children: [
          Container(
            width: 68.w,
            height: 68.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: hasStory
                  ? LinearGradient(
                      colors: [
                        Color(0xFFFFD700),
                        Color(0xFFFFE55C),
                        Color(0xFF9D4EDD),
                        Color(0xFF7B2CBF),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              border: !hasStory
                  ? Border.all(
                      color: isDarkMode ? Color(0xFF9D4EDD).withValues(alpha: 0.3) : Color(0xFF9D4EDD).withValues(alpha: 0.2),
                      width: 2,
                    )
                  : null,
              boxShadow: hasStory
                  ? [
                      BoxShadow(
                        color: Color(0xFF9D4EDD).withValues(alpha: 0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ]
                  : [],
            ),
            padding: EdgeInsets.all(3),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode ? Color(0xFF1A0B2E) : Colors.grey[50],
                border: Border.all(
                  color: isDarkMode ? Color(0xFF0A0015) : Colors.white,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.show_chart_rounded,
                  color: Color(0xFF9D4EDD),
                  size: 24.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 6.h),
          SizedBox(
            width: 68.w,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                color: isDarkMode ? Colors.white.withValues(alpha: 0.8) : Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
