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
                        Color(0xFFE91E63),
                        Color(0xFFFF6B9D),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              border: !hasStory
                  ? Border.all(
                      color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                      width: 2,
                    )
                  : null,
            ),
            padding: EdgeInsets.all(3),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                border: Border.all(
                  color: isDarkMode ? Color(0xFF1A1A1A) : Colors.white,
                  width: 2,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.show_chart_rounded,
                  color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
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
                color: isDarkMode ? Colors.grey[400] : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
