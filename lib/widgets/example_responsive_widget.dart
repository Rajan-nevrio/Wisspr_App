import 'package:flutter/material.dart';
import '../utils/responsive_dimensions.dart';
import 'responsive_layout.dart';


class ExampleResponsiveWidget extends StatelessWidget {
  const ExampleResponsiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveDimensions.init(context);
    
    return ResponsiveLayout(
      mobile: _buildMobileExample(),
      tablet: _buildTabletExample(),
      desktop: _buildDesktopExample(),
    );
  }

  Widget _buildMobileExample() {
    return ResponsiveColumn(
      spacing: 4,
      children: [
        _buildHeader(),
        _buildContentGrid(1),
        _buildInfoSection(),
      ],
    );
  }

  Widget _buildTabletExample() {
    return Row(
      children: [
        Container(
          width: ResponsiveDimensions.getWidth(35),
          child: ResponsiveColumn(
            spacing: 4,
            children: [
              _buildHeader(),
              _buildInfoSection(),
            ],
          ),
        ),
        Expanded(
          child: _buildContentGrid(2),
        ),
      ],
    );
  }

  Widget _buildDesktopExample() {
    return Row(
      children: [
        Container(
          width: ResponsiveDimensions.getWidth(25),
          child: ResponsiveColumn(
            spacing: 4,
            children: [
              _buildHeader(),
              _buildInfoSection(),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: _buildContentGrid(3),
        ),
        Container(
          width: ResponsiveDimensions.getWidth(20),
          child: _buildSidebar(),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
        child: ResponsiveColumn(
          spacing: 2,
          children: [
            Icon(
              Icons.star,
              size: ResponsiveDimensions.iconSize * 2,
              color: Colors.amber,
            ),
            Text(
              'Example Widget',
              style: TextStyle(
                fontSize: ResponsiveDimensions.h2Size,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'This demonstrates responsive design',
              style: TextStyle(
                fontSize: ResponsiveDimensions.bodySize,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentGrid(int columns) {
    final items = [
      {'title': 'Item 1', 'color': Colors.red},
      {'title': 'Item 2', 'color': Colors.green},
      {'title': 'Item 3', 'color': Colors.blue},
      {'title': 'Item 4', 'color': Colors.orange},
      {'title': 'Item 5', 'color': Colors.purple},
      {'title': 'Item 6', 'color': Colors.teal},
    ];

    return ResponsiveGrid(
      mobileColumns: 1,
      tabletColumns: 2,
      desktopColumns: 3,
      spacing: 3,
      runSpacing: 3,
      children: items.map((item) => _buildGridItem(item)).toList(),
    );
  }

  Widget _buildGridItem(Map<String, dynamic> item) {
    return Card(
      child: Container(
        height: ResponsiveDimensions.getHeight(15),
        decoration: BoxDecoration(
          color: item['color'] as Color,
          borderRadius: BorderRadius.circular(ResponsiveDimensions.cardRadius),
        ),
        child: Center(
          child: Text(
            item['title'] as String,
            style: TextStyle(
              fontSize: ResponsiveDimensions.bodySize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(ResponsiveDimensions.getPadding(4)),
        child: ResponsiveColumn(
          spacing: 3,
          children: [
            Text(
              'Device Info',
              style: TextStyle(
                fontSize: ResponsiveDimensions.h3Size,
                fontWeight: FontWeight.w600,
              ),
            ),
            _buildInfoRow('Type', ResponsiveDimensions.isMobile 
                ? 'Mobile' 
                : ResponsiveDimensions.isTablet 
                    ? 'Tablet' 
                    : 'Desktop'),
            _buildInfoRow('Orientation', ResponsiveDimensions.isPortrait 
                ? 'Portrait' 
                : 'Landscape'),
            _buildInfoRow('Width', '${ResponsiveDimensions.screenWidth.toStringAsFixed(0)}px'),
            _buildInfoRow('Height', '${ResponsiveDimensions.screenHeight.toStringAsFixed(0)}px'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return ResponsiveRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: ResponsiveDimensions.bodySize,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: ResponsiveDimensions.bodySize,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildSidebar() {
    final actions = [
      {'icon': Icons.home, 'label': 'Home'},
      {'icon': Icons.search, 'label': 'Search'},
      {'icon': Icons.favorite, 'label': 'Favorites'},
      {'icon': Icons.person, 'label': 'Profile'},
    ];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(ResponsiveDimensions.getPadding(3)),
        child: ResponsiveColumn(
          spacing: 2,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: ResponsiveDimensions.h3Size,
                fontWeight: FontWeight.w600,
              ),
            ),
            ...actions.map((action) => ListTile(
              leading: Icon(
                action['icon'] as IconData,
                size: ResponsiveDimensions.iconSize,
              ),
              title: Text(
                action['label'] as String,
                style: TextStyle(
                  fontSize: ResponsiveDimensions.bodySize,
                ),
              ),
              onTap: () {
                // Handle action tap
              },
            )),
          ],
        ),
      ),
    );
  }
}
