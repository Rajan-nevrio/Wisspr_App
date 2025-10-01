import 'package:flutter/material.dart';

import '../utils/responsive_dimensions.dart';
import 'customer_text/marcellus_font_type_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ResponsiveDimensions dimension;
  final BuildContext context;
  final String? title;
  final List<Widget>? actions;
  final bool? isBackBtn;

  const CustomAppBar({
    super.key,
    required this.context,
    required this.dimension,
    this.title,
    this.actions,
    this.isBackBtn,
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
            isBackBtn ?? false
                ? backBtn()
                : spaceFiller(),

            /// Title
            Expanded(
              child: MText(
                msg: title ?? "",
                textAlign: TextAlign.center,
                textSize: r.fontSize(20),
                textWeight: FontWeight.w500,
                textColor: Theme.of(context).colorScheme.primary,
              ),
            ),

            /// Actions
            if (actions == null || actions!.isEmpty)
              spaceFiller()
            else
              ...actions!,
          ],
        ),
      ),
    );
  }

  /// Widget to fill empty space.
  Widget spaceFiller() {
    return SizedBox(
      height: dimension.height(42),
      width: dimension.width(42),
    );
  }

  /// Widget used for the back button.
  Widget backBtn() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: dimension.height(42),
        width: dimension.width(42),
        margin: EdgeInsets.only(left: dimension.width(12)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.tertiary,
            size: dimension.fontSize(22),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
