import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wisspr_app/commom_widgets/customer_text/marcellus_font_type_text.dart';
import 'package:wisspr_app/resources/app_strings.dart';
import 'dart:io';
import '../../commom_widgets/customer_text/satoshi_font_type_text.dart';
import '../../utils/responsive_dimensions.dart';

class MyAccountProvider with ChangeNotifier {
  TextEditingController? nameController = TextEditingController();
  TextEditingController? emailController = TextEditingController(
    text: "tomhillson@gamil.com",
  );
  TextEditingController? mobController = TextEditingController();
  bool isUpdated = false;
  bool isUpdateLoader = false;
  File? selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  /// Getter to return the current edit status.
  bool get editStatus => isUpdated;
  bool get isLoader => isUpdateLoader;

  /// Method used to update the edit status.
  void toggleEditStatus() {
    isUpdated = !isUpdated;
    notifyListeners();
  }

  /// Method used to update the user details.
  Future<void> updateDetails(BuildContext context) async {
    if (isUpdateLoader) return;

    isUpdateLoader = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1));
      debugPrint('------> User Details updated.');

      if (context.mounted) {
        Navigator.pop(context);
      }
    } catch (error) {
      debugPrint('Failed to Update the user details:-----> $error');
    } finally {
      isUpdateLoader = false;
      notifyListeners();
    }
  }

  /// Method to pick image from gallery or camera.
  Future<void> pickImage(BuildContext context, ResponsiveDimensions r) async {
    try {
      final ImageSource? source = await showModalBottomSheet<ImageSource>(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: r.height(10)),
                    child: MText(
                      msg: AppStrings.imageSource,
                      textWeight: FontWeight.w500,
                      textSize: r.fontSize(20),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: r.width(20)),
                  child: Divider(
                    color: Theme.of(context).colorScheme.tertiary,
                    thickness: r.width(0.7),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.photo_library,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  title: SText(
                    msg: AppStrings.gallery,
                    textColor: Theme.of(context).colorScheme.primary,
                    textSize: r.fontSize(15),
                  ),
                  onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  title: SText(
                    msg: AppStrings.camera,
                    textColor: Theme.of(context).colorScheme.primary,
                    textSize: r.fontSize(15),
                  ),
                  onTap: () => Navigator.of(context).pop(ImageSource.camera),
                ),
              ],
            ),
          );
        },
      );

      if (source != null) {
        final XFile? image = await _imagePicker.pickImage(
          source: source,
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 80,
        );

        if (image != null) {
          selectedImage = File(image.path);
          notifyListeners();
          debugPrint('Image selected:----> ${image.path}');
        }
      }
    } catch (e) {
      debugPrint('Error picking image:-----> $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: SText(
              msg: 'Error picking image: $e',
              textWeight: FontWeight.w500,
              textSize: r.fontSize(18),
              textColor: Theme.of(context).colorScheme.error,
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    nameController?.dispose();
    emailController?.dispose();
    mobController?.dispose();
    notifyListeners();
    super.dispose();
  }
}
