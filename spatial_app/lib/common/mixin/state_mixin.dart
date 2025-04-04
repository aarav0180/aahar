import 'package:flutter/material.dart';

/// Have you ever encountered a situation where you are using setState when the widget
/// does not exist in the widget tree? This can happen when your widget is building or
/// it is disposed of. In such cases, you might get errors like
/// "[setState] called after [dispose]" or "[setState] called during [build]".
/// To avoid these errors, you can check whether the [State] object is currently
/// in the tree by using the mounted property.
/// Each time you use setState, this mixin will simplify the process by checking
/// if the [widget] is mounted before calling setState.
/// Here's an example of how to use this mixin:
///```
///
/// class ExampleWidget extends StatefulWidget {
///   @override
///   _ExampleWidgetState createState() => _ExampleWidgetState();
/// }
///
/// class _ExampleWidgetState extends State<ExampleWidget> with StateMixin {
///
///   String text = "Initial text";
///   bool isLoading = false;
///
///   @override
///   void initState() {
///     super.initState();
///     /// When building:
///     /// Setting state during build normally it will throw error since, we are using [StateMixin]
///     /// it will not then simulating an asynchronous operation that completes during widget build
///     setState(() => isLoading = true);
///     ///
///     Future.delayed(const Duration(seconds: 2), () {
///       setState(() {
///         text = "Updated text in initState";
///         isLoading = false;
///       });
///     });
///   }
///
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(
///         title: Text("Example Widget"),
///       ),
///       body: Center(
///         child: Column(
///           mainAxisAlignment: MainAxisAlignment.center,
///           children: <Widget>[
///             if (isLoading)
///               CircularProgressIndicator()
///             else
///               Text(text),
///             ElevatedButton(
///               onPressed: () async {
///                 /// When disposed:
///                 /// Simulating user clicked back button
///                 /// and then using setState
///                 /// normally it will throw an error since,
///                 /// we are using [StateMixin] it will be not,
///                 /// then simulating an asynchronous operation
///                 /// that completes after widget is disposed
///                 Navigator.pop(context);
///                 setState(() => isLoading = true);
///                 await Future.delayed(const Duration(seconds: 2));
///                 setState(() {
///                   text = "Updated text on button press";
///                 });
///               },
///               child: Text("Update Text"),
///             ),
///           ],
///         ),
///       ),
///     );
///   }
/// }
/// ```
mixin StateMixin<T extends StatefulWidget> on State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    } else {
      fn();
    }
  }
}
