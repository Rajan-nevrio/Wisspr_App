import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisspr_app/providers/auth/my_account_provider.dart';
import '../../commom_widgets/custom_appbar.dart';
import '../../commom_widgets/custom_test_form_field.dart';
import '../../commom_widgets/customer_text/satoshi_font_type_text.dart';
import '../../resources/app_strings.dart';
import '../../resources/dimension_spacing/vertical_spacing.dart';
import '../../utils/responsive_dimensions.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
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
        dimension: _responsive,
        context: context,
        title: AppStrings.myAccount,
        isBackBtn: true,
        actions: [
          Selector<MyAccountProvider, bool>(
            selector: (context, provider) => provider.editStatus,
            builder: (context, isEditMode, child) {
              return IconButton(
                onPressed: () {
                  Provider.of<MyAccountProvider>(
                    context,
                    listen: false,
                  ).toggleEditStatus();
                },
                icon: Icon(
                  Icons.edit,
                  size: _responsive.fontSize(30),
                  color: Theme.of(context).colorScheme.primary,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _responsive.width(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              VerticalSpacing(height: 30),
              Center(child: profileSection()),
              VerticalSpacing(height: 30),
              Selector<MyAccountProvider, bool>(
                selector: (context, provider) => provider.editStatus,
                builder: (context, value, child) {
                  return CustomerTextFormField(
                    dimension: _responsive,
                    header: AppStrings.name,
                    hintText: AppStrings.enterUserNameHere,
                    enabled: value,
                    controller: Provider.of<MyAccountProvider>(
                      context,
                      listen: false,
                    ).nameController,
                    keyboardType: TextInputType.name,
                  );
                },
              ),
              VerticalSpacing(height: 15),
              CustomerTextFormField(
                dimension: _responsive,
                header: AppStrings.email,
                hintText: AppStrings.enterEmailHere,
                enabled: false,
                controller: Provider.of<MyAccountProvider>(
                  context,
                  listen: false,
                ).emailController,
              ),
              VerticalSpacing(height: 15),
              Selector<MyAccountProvider, bool>(
                selector: (context, provider) => provider.editStatus,
                builder: (context, value, child) {
                  return CustomerTextFormField(
                    dimension: _responsive,
                    header: AppStrings.mobNumber,
                    hintText: AppStrings.enterMobNoHere,
                    enabled: value,
                    controller: Provider.of<MyAccountProvider>(
                      context,
                      listen: false,
                    ).mobController,
                    keyboardType: TextInputType.number,
                  );
                },
              ),
              VerticalSpacing(height: 130),
              Selector<MyAccountProvider, Map<String, bool>>(
                selector: (context, provider) => {
                  'isEditMode': provider.editStatus,
                  'isLoading': provider.isLoader,
                },
                builder: (context, state, child) {
                  if (state['isEditMode'] ?? false) {
                    return updateBtn(state['isLoading'] ?? false, _responsive);
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Widget used to show the profile section.
  Widget profileSection() {
    return Consumer<MyAccountProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () {
                if(provider.editStatus) {
                  provider.pickImage(context, _responsive);
                } else {
                  debugPrint("Edit Status:-----> ${provider.editStatus}");
                }
              },
              child: Container(
                width: _responsive.width(140),
                height: _responsive.height(140),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                  color: Colors.grey,
                ),
                child: provider.selectedImage != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                        child: Image.file(
                          provider.selectedImage!,
                          width: _responsive.width(140),
                          height: _responsive.height(140),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person,
                              size: _responsive.fontSize(80),
                              color: Theme.of(context).scaffoldBackgroundColor,
                            );
                          },
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.person,
                          size: _responsive.fontSize(80),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                      ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  if(provider.editStatus) {
                    provider.pickImage(context, _responsive);
                  } else {
                    debugPrint("Edit Status:-----> ${provider.editStatus}");
                  }
                },
                child: Container(
                  height: _responsive.width(45),
                  width: _responsive.width(45),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      size: _responsive.fontSize(28),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Update button UI.
  Widget updateBtn(bool isLoading, ResponsiveDimensions r) {
    return SizedBox(
      width: r.screenWidth,
      height: r.height(56),
      child: ElevatedButton(
        onPressed: isLoading
            ? () => debugPrint("Update Details:-----> Already running")
            : () {
                final provider = Provider.of<MyAccountProvider>(
                  context,
                  listen: false,
                );
                provider.updateDetails(context);
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? Center(
                child: SizedBox(
                  height: r.height(25),
                  width: r.height(25),
                  child: CircularProgressIndicator(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    strokeWidth: 2,
                  ),
                ),
              )
            : Center(
                child: SText(
                  msg: AppStrings.update,
                  textAlign: TextAlign.center,
                  textSize: r.fontSize(18),
                  textWeight: FontWeight.w500,
                  textColor: Theme.of(context).scaffoldBackgroundColor,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }
}
