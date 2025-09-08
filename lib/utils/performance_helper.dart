import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// Performance helper class for monitoring and optimizing app performance
class PerformanceHelper {
  static bool _isMonitoring = false;
  static int _frameCount = 0;
  static DateTime? _lastFrameTime;

  /// Start performance monitoring
  static void startMonitoring() {
    if (_isMonitoring) return;
    _isMonitoring = true;
    _frameCount = 0;
    _lastFrameTime = DateTime.now();

    SchedulerBinding.instance.addPersistentFrameCallback(_onFrame);
  }

  /// Stop performance monitoring
  static void stopMonitoring() {
    if (!_isMonitoring) return;
    _isMonitoring = false;
    // Note: Flutter doesn't provide removePersistentFrameCallback
    // This is a limitation of the current implementation
  }

  /// Frame callback for monitoring
  static void _onFrame(Duration timeStamp) {
    if (!_isMonitoring) return;
    
    _frameCount++;
    final now = DateTime.now();
    
    if (_lastFrameTime != null) {
      final frameTime = now.difference(_lastFrameTime!);
      if (frameTime.inMilliseconds > 16) { // More than 16ms indicates dropped frames
        if (kDebugMode) {
          debugPrint('Performance Warning: Frame took ${frameTime.inMilliseconds}ms');
        }
      }
    }
    
    _lastFrameTime = now;
  }

  /// Get current FPS
  static double getCurrentFPS() {
    if (_lastFrameTime == null) return 0.0;
    final now = DateTime.now();
    final elapsed = now.difference(_lastFrameTime!).inMilliseconds;
    return elapsed > 0 ? 1000.0 / elapsed : 0.0;
  }

  /// Check if app is running smoothly
  static bool get isRunningSmoothly {
    final fps = getCurrentFPS();
    return fps >= 55.0; // 55+ FPS is considered smooth
  }

  /// Optimize widget rebuilds
  static Widget optimizeWidget(Widget child, {String? key}) {
    return RepaintBoundary(
      key: key != null ? Key(key) : null,
      child: child,
    );
  }

  /// Debounce function calls
  static void debounce(String key, VoidCallback callback, {Duration delay = const Duration(milliseconds: 300)}) {
    // Simple debounce implementation
    Future.delayed(delay, () {
      callback();
    });
  }
}
