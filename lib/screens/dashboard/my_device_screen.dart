import 'package:flutter/material.dart';

import '../../commom_widgets/custom_appbar.dart';
import '../../theme/font_constants.dart';
import '../../utils/responsive_dimensions.dart';

class MyDeviceScreen extends StatefulWidget {
  const MyDeviceScreen({super.key});

  @override
  State<MyDeviceScreen> createState() => _MyDeviceScreenState();
}

class _MyDeviceScreenState extends State<MyDeviceScreen> {
  late ResponsiveDimensions _responsive;

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
        title: "My Devices",
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: 26,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: _responsive.height(20)),
            ListView.builder(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 7,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(
                          context,
                        ).scaffoldBackgroundColor.withAlpha(84),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).colorScheme.surface,
                              Theme.of(context).scaffoldBackgroundColor,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 12,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// Mirror logic: even index = text left, image right; odd index = image left, text right
                              if (index % 2 == 0) ...[
                                /// Even index: Text on left, Image on right
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset(
                                            "assets/image/Low Battery.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(width: _responsive.width(8)),
                                        Text(
                                          'Low Battery',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.error,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                           // fontFamily: FontConstants.satoshi,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: _responsive.height(50)),
                                    Text(
                                      'Evergreen Terrace',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      //  fontFamily: FontConstants.marcellus,
                                      ),
                                    ),
                                    SizedBox(height: _responsive.height(5)),
                                    Text(
                                      'Springfield US',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        //fontFamily: FontConstants.satoshi,
                                      ),
                                    ),
                                    SizedBox(height: _responsive.height(20)),
                                  ],
                                ),
                                Spacer(),
                                SizedBox(
                                  height: _responsive.height(150),
                                  width: _responsive.width(95),
                                  child: Image.asset(
                                    'assets/image/air fragrance.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ] else ...[
                                /// Odd index: Image on left, Text on right
                                SizedBox(
                                  height: _responsive.height(150),
                                  width: _responsive.width(95),
                                  child: Image.asset(
                                    'assets/image/air fragrance2.png',
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Image.asset(
                                            "assets/image/Low Battery.png",
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        SizedBox(width: _responsive.width(8)),
                                        Text(
                                          'Low Battery',
                                          style: TextStyle(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.error,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300,
                                           // fontFamily: FontConstants.satoshi,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: _responsive.height(50)),
                                    Text(
                                      'Evergreen Terrace',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                       // fontFamily: FontConstants.marcellus,
                                      ),
                                    ),
                                    SizedBox(height: _responsive.height(5)),
                                    Text(
                                      'Springfield US',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      //  fontFamily: FontConstants.satoshi,
                                      ),
                                    ),
                                    SizedBox(height: _responsive.height(20)),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      // Bottom status bar
                      Container(
                        height: _responsive.height(60),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    "assets/image/current.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  '77%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Container(height: 20, width: 1, color: Colors.white30),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Image.asset(
                                    "assets/image/drop.png",
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  '15%',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
