import 'package:flutter/material.dart';

class StoryList extends StatelessWidget {
  const StoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12),
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
      'Crypto News',
      'Market Alert',
      'BTC Update',
      'ETH Signal',
      'Forex Tips',
      'Gold Price',
      'EUR/USD',
      'Analysis',
    ];
    return titles[index];
  }

  Widget _buildStoryItem({
    required String title,
    required bool hasStory,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
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
                  ? Border.all(color: Colors.grey[300]!, width: 2)
                  : null,
            ),
            padding: EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: Icon(
                  Icons.show_chart,
                  color: Colors.grey[600],
                  size: 24,
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          SizedBox(
            width: 64,
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
