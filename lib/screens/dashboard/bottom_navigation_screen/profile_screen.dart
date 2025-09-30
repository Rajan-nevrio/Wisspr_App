import 'package:flutter/material.dart';
import 'package:wisspr_app/commom_widgets/dialog.dart';
import 'package:wisspr_app/resources/dimension_spacing/vertical_spacing.dart';
import '../../../commom_widgets/custom_appbar.dart';
import '../../../commom_widgets/customer_text/marcellus_font_type_text.dart';
import '../../../commom_widgets/customer_text/satoshi_font_type_text.dart';
import '../../../resources/app_strings.dart';
import '../../../resources/image_path.dart';
import 'package:provider/provider.dart';
import '../../../providers/dashboard/botton_navigation_providers/profile_provider.dart';
import '../../../routes/navigation_helper.dart';
import '../../../utils/responsive_dimensions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ResponsiveDimensions _responsive;
  List<TileItem>? items;

  @override
  void initState() {
    super.initState();
    _responsive = ResponsiveDimensions();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _responsive.init(context);
  }

  @override
  Widget build(BuildContext context) {
    items = [
      TileItem(
        image: ImgPath.myAccount,
        label: AppStrings.myAccount,
        icon: Icons.arrow_forward_ios,
        onPressed: () => NavigationHelper.goToMyAccount(context),
      ),
      TileItem(
        image: ImgPath.subscriptionBilling,
        label: AppStrings.subscriptionBilling,
        icon: Icons.arrow_forward_ios,
        onPressed: () {},
      ),
      TileItem(
        image: ImgPath.yourOrder,
        label: AppStrings.yourOrder,
        icon: Icons.arrow_forward_ios,
        onPressed: () {},
      ),
      TileItem(
        image: ImgPath.setting,
        label: AppStrings.setting,
        icon: Icons.arrow_forward_ios,
        onPressed: () => NavigationHelper.goToSetting(context),
      ),
      TileItem(
        image: ImgPath.notificationSetting,
        label: AppStrings.notificationSetting,
        icon: Icons.arrow_forward_ios,
        onPressed: () => NavigationHelper.goToNotificationSetting(context),
      ),
      TileItem(
        image: ImgPath.logout,
        label: AppStrings.logout,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final isLoading = context.select<ProfileProvider, bool>((p) => p.isLogoutLoading);
              return CustomDialog(
                title: AppStrings.thisWillLogoutYourAccount,
                description: AppStrings.areYouSureYouWantToLogoutYourAccount,
                sOnPressed: isLoading
                    ? () {}
                    : () async {
                        await context.read<ProfileProvider>().logout(context);
                      },
                sButtonColor: Theme.of(context).colorScheme.error,
                sButtonName: AppStrings.logout,
                sButtonTextColor: Theme.of(context).colorScheme.primary,
              );
            },
          );
        },
      ),
      TileItem(
        image: ImgPath.deleteAccount,
        label: AppStrings.deleteAccount,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final isLoading = context.select<ProfileProvider, bool>((p) => p.isDeleteLoading);
              return CustomDialog(
                title: AppStrings.thisWillDeleteYourAccount,
                description: AppStrings.areYouSureYouWantToDoThisThisWillPermanentlyDeleteYourAccount,
                sOnPressed: isLoading
                    ? () {}
                    : () async {
                        await context.read<ProfileProvider>().deleteAccount(context);
                      },
                sButtonColor: Theme.of(context).colorScheme.error,
                sButtonName: AppStrings.deleteAccount,
                sButtonTextColor: Theme.of(context).colorScheme.primary,
              );
            },
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        dimension: _responsive,
        context: context,
        title: AppStrings.profile,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VerticalSpacing(height: 30),
            profileSection(),
            VerticalSpacing(height: 30),
            itemListTile(),
            VerticalSpacing(height: 60),
          ],
        ),
      ),
    );
  }

  /// Widget used to show the profile section.
  Widget profileSection() {
    return Column(
      children: [
        Container(
          width: _responsive.width(140),
          height: _responsive.height(140),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            color: Colors.grey,
          ),
          child: Center(
            child: Icon(
              Icons.person,
              size: _responsive.fontSize(80),
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        VerticalSpacing(height: 30),
        MText(
          msg: "Tom Hillson",
          textWeight: FontWeight.w300,
          textColor: Theme.of(context).colorScheme.primary,
          textSize: _responsive.fontSize(30),
        ),
        SText(
          msg: "tomhillson@gamil.com",
          textSize: _responsive.fontSize(16),
          textWeight: FontWeight.w200,
          textColor: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  /// Widget used to show the list-tile item.
  Widget itemListTile() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items?.length ?? 0,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: items?[index].onPressed,
          title: SText(
            msg: items?[index].label ?? "",
            textSize: _responsive.fontSize(20),
            textWeight: FontWeight.w200,
            textColor: (index + 1) == items?.length
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).colorScheme.primary,
          ),
          leading: SizedBox(
            width: _responsive.width(20),
            height: _responsive.height(20),
            child: Image.asset(
              items?[index].image ?? "",
              color: (index + 1) == items?.length
                  ? Theme.of(context).colorScheme.error
                  : Theme.of(context).colorScheme.tertiary,
              fit: BoxFit.contain,
            ),
          ),
          trailing: Icon(
            items?[index].icon,
            size: 16,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        );
      },
    );
  }
}

/// Model class for list-tile item.
class TileItem {
  String image;
  String label;
  IconData? icon;
  void Function() onPressed;

  TileItem({
    required this.onPressed,
    required this.image,
    required this.label,
    this.icon,
  });
}
