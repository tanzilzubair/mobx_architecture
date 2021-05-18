import 'package:flutter/material.dart';

// This package helps bind your View Model MobX stores with your UI more clearly.
// THIS WIDGET DOES NOT OBSERVER STATE, IDEALLY YOU WOULD BE USING OBSERVER WIDGETS FOR THAT FUNCTIONALITY

/// This widget is used to bind a View Model ( one that DOES NOT REQUIRE an initState or dispose function or both )
/// to the UI in a much more cleaner, manageable and dare I say elegant way
///
/// For use-cases that DO require a View Model that uses the initState or dispose function or both, use the [StatefulVMBuilder] widget
///
/// For use-cases that DO require a MobX store, use the [StatelessVMBuilder] widget or the [StatefulVMStoreBuilder] widget

class StatelessVMBuilder<T extends Object> extends StatelessWidget {
  /// This is the constructor to use for binding the View Model to the View
  const StatelessVMBuilder({
    Key? key,
    required this.builder,
    required this.viewModelBuilder,
  }) : super(key: key);

  /// This is the builder function that exposes the View Model, the BuildContext and the SizingInfo object
  final Widget Function(
      BuildContext context, T viewModel, MediaQueryData mediaQuery) builder;

  /// This is the function that builds the View Model
  final T Function() viewModelBuilder;

  @override
  Widget build(BuildContext context) {
    // Using the given View Model
    T viewModel = viewModelBuilder();
    return builder(context, viewModel, MediaQuery.of(context));
  }
}
