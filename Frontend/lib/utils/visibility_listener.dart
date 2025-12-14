// Conditional import: use web implementation when `dart:html` is available.
import 'visibility_listener_stub.dart'
    if (dart.library.html) 'visibility_listener_web.dart';

// This file re-exports the platform implementation's functions:
// - registerVisibilityCallback(void Function() onHidden)
// - unregisterVisibilityCallback()
