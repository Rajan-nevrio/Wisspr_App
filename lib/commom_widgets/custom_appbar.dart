import 'package:flutter/material.dart';
import 'package:wisspr_app/theme/font_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String? title;
  final List<Widget>? actions;
  final bool centerTitle;

  const CustomAppBar({
    super.key,
    required this.context,
    this.title,
    this.actions,
    this.centerTitle = true,
  });

  @override
  Widget build(BuildContext _) {
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
              child: Text(
                title ?? "",
                textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: FontConstants.marcellus,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
