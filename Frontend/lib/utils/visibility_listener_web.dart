import 'dart:async';
import 'dart:html' as html;

StreamSubscription<html.Event>? _visibilitySub;

void registerVisibilityCallback(void Function() onHidden) {
  // listen for document visibility changes and call onHidden when hidden
  _visibilitySub ??= html.document.onVisibilityChange.listen((event) {
    // html.document.hidden is a bool?
    try {
      final hidden = html.document.hidden;
      if (hidden == true) {
        onHidden();
      }
    } catch (_) {}
  });
}

void unregisterVisibilityCallback() {
  _visibilitySub?.cancel();
  _visibilitySub = null;
}
