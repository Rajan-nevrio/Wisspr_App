import 'package:flutter/material.dart';

import '../utils/responsive_dimensions.dart';
import 'customer_text/marcellus_font_type_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ResponsiveDimensions dimension;
  final BuildContext context;
  final String? title;
  final List<Widget>? actions;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.context,
    required this.dimension,
    this.title,
    this.actions,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext _) {
    final r = dimension;

    return SafeArea(
      top: true,
      bottom: false,
      child: Container(
        height: preferredSize.height,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).scaffoldBackgroundColor,
              blurRadius: 12,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          children: [
            /// Back button (optional if centerTitle = false).
            if (!centerTitle)
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),

            /// Title
            Expanded(
              child: MText(
                msg: title ?? "",
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                textSize: r.fontSize(20),
                textWeight: FontWeight.w500,
                textColor: Theme.of(context).colorScheme.primary,
              ),
            ),

            /// Actions
            if (actions != null) ...actions!,
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
