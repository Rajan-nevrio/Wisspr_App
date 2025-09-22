import 'package:flutter/material.dart';

import '../../../commom_widgets/custom_appbar.dart';
import '../../../resources/image_path.dart';
import '../../../utils/responsive_dimensions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ResponsiveDimensions _responsive;

  List<TileItem> items = [
    TileItem(
      image: ImgPath.myAccount,
      label: "My Account",
      icon: Icons.arrow_forward_ios,
    ),
    TileItem(
      image: ImgPath.subscriptionBilling,
      label: "Subscription & Billing",
      icon: Icons.arrow_forward_ios,
    ),
    TileItem(
      image: ImgPath.yourOrder,
      label: "Your Order",
      icon: Icons.arrow_forward_ios,
    ),
    TileItem(
      image: ImgPath.setting,
      label: "Setting",
      icon: Icons.arrow_forward_ios,
    ),
    TileItem(
      image: ImgPath.notificationSetting,
      label: "Notifications Setting",
      icon: Icons.arrow_forward_ios,
    ),
    TileItem(image: ImgPath.logout, label: "Logout"),
    TileItem(image: ImgPath.deleteAccount, label: "Delete Account"),
  ];

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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: CustomAppBar(
        context: context,
        title: "Profile",
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: _responsive.height(30)),
            profileSection(),
            SizedBox(height: _responsive.height(30)),
            itemListTile(),
            SizedBox(height: _responsive.height(60)),
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
          child: Image.asset("",
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.person, size: 80, color: Theme.of(context).scaffoldBackgroundColor);
            },
          ),
        ),
        SizedBox(height: _responsive.height(30)),
        Text(
          "Tom Hillson",
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Theme.of(context).colorScheme.primary,
            fontSize: 30,
          ),
        ),
        Text(
          "Tomhill@gmail.com",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w200,
              color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  }

  /// Widget used to show the list-tile item.
  Widget itemListTile() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(items[index].label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w200,
              color: (index + 1) ==  items.length ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary,
            ),
          ),
          leading: SizedBox(
            width: _responsive.width(20),
            height: _responsive.height(20),
            child: Image.asset(items[index].image,
              color: (index + 1) ==  items.length ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.tertiary,
              fit: BoxFit.contain,
            ),
          ),
          trailing: Icon(items[index].icon,
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

  TileItem({required this.image, required this.label, this.icon});
}
