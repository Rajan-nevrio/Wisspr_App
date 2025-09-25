import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// Performance helper class for monitoring and optimizing app performance
class PerformanceHelper {
  static bool _isMonitoring = false;
  static int frameCount = 0;
  static DateTime? _lastFrameTime;

  // Log only truly slow frames and throttle logs
  static const int _slowFrameMs = 120; // ~16ms budget; log only clearly janky frames
  static const int _ignorePauseGapMs = 1000; // skip gaps due to pause/background
  static const int _logThrottleMs = 2000; // at most one log per 2s
  static DateTime? _lastSlowLogTime;
  static int _slowStreak = 0;

  /// Start performance monitoring
  static void startMonitoring() {
    if (_isMonitoring) return;
    _isMonitoring = true;
    frameCount = 0;
    _lastFrameTime = DateTime.now();

    SchedulerBinding.instance.addPersistentFrameCallback(_onFrame);
  }

  /// Stop performance monitoring
  static void stopMonitoring() {
    if (!_isMonitoring) return;
    _isMonitoring = false;
  }

  /// Frame callback for monitoring
  static void _onFrame(Duration timeStamp) {
    if (!_isMonitoring) return;
    
    frameCount++;
    final now = DateTime.now();
    
    if (_lastFrameTime != null) {
      final frameTime = now.difference(_lastFrameTime!);
      final ms = frameTime.inMilliseconds;

      // Skip very large gaps (likely app paused or backgrounded)
      if (ms < _ignorePauseGapMs) {
        if (ms > _slowFrameMs) {
          _slowStreak++;

          // Throttle noisy logs
          final canLog = _lastSlowLogTime == null ||
              now.difference(_lastSlowLogTime!).inMilliseconds > _logThrottleMs;

          if (canLog) {
            debugPrint('\nPerformance Warning:----> Slow frame ${ms}ms (streak: $_slowStreak)\n');
            _lastSlowLogTime = now;
            _slowStreak = 0; // reset after a throttled log
          }
        } else {
          // smooth frame resets streak
          _slowStreak = 0;
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
    return fps >= 55.0;
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
    Future.delayed(delay, () {
      callback();
    });
  }
}
