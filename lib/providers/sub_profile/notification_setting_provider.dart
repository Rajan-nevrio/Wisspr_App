import 'package:flutter/material.dart';

class NotificationSettingProvider with ChangeNotifier {
  bool _newOffers = true;
  bool _accountUpdate = true;
  bool _orderConfirmation = true;
  bool _orderTracking = true;

  /// getter to return the switch btn value.
  bool get newOffers => _newOffers;
  bool get accountUpdate => _accountUpdate;
  bool get orderConfirmation => _orderConfirmation;
  bool get orderTracking => _orderTracking;

  /// Method used to set the new offers value.
  void setNewOffers(bool value) {
    if (_newOffers == value) return;
    _newOffers = value;
    notifyListeners();
  }

  /// Method used to set the account update value.
  void setAccountUpdate(bool value) {
    if (_accountUpdate == value) return;
    _accountUpdate = value;
    notifyListeners();
  }

  /// Method used to set the order confirmation value.
  void setOrderConfirmation(bool value) {
    if (_orderConfirmation == value) return;
    _orderConfirmation = value;
    notifyListeners();
  }

  /// Method used to set the order tracking value.
  void setOrderTracking(bool value) {
    if (_orderTracking == value) return;
    _orderTracking = value;
    notifyListeners();
  }
}
