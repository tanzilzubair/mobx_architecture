import 'package:mobx_architecture/src/Components/SizingInfo.dart';
import 'package:flutter/material.dart';

/// This package helps bind your View Model MobX stores with your UI more clearly.
/// THIS WIDGET DOES NOT OBSERVER STATE, IDEALLY YOU WOULD BE USING OBSERVER WIDGETS FOR THAT FUNCTIONALITY
///
/// This particular widget is used to bind a View Model ( one that REQUIRES an initState or dispose function or both )
/// to the UI in a much more cleaner, manageable and dare I say elegant way
///
/// For use-cases that do NOT require a View Model that uses the initState or dispose function or both, use the [StatelessVMBuilder] widget
///
/// For use-cases that DO require a MobX store, use the [StatelessVMStoreBuilder] widget or the [StatefulVMStoreBuilder] widget

class StatefulVMBuilder<T extends Object> extends StatefulWidget {
  /// This is the constructor to use for binding the View Model to the View
  const StatefulVMBuilder({
    Key key,
    @required this.builder,
    this.initState,
    this.dispose,
    this.viewModelBuilder,
  }) : super(key: key);

  /// This is the function that exposes the View Model in the builder function
  final Widget Function(BuildContext context, T viewModel, SizingInfo dimens)
      builder;

  /// This is the function that runs inside (you guessed it!) initState
  final void Function(T viewModel) initState;

  /// This is the function that runs inside dispose
  final void Function(T viewModel) dispose;

  /// This is the function that builds the View Model
  final T Function() viewModelBuilder;

  @override
  _StatefulVMBuilderState<T> createState() => _StatefulVMBuilderState<T>();
}

class _StatefulVMBuilderState<T extends Object>
    extends State<StatefulVMBuilder<T>> {
  T _viewModel;
  @override
  void initState() {
    super.initState();

    ///Using the given View Model
    _viewModel = widget.viewModelBuilder();

    /// Checking to see if a initState function was provided, and running it if it was
    if (widget.initState != null) {
      widget.initState(_viewModel);
    }
  }

  @override
  void dispose() {
    /// Checking to see if a dispose function was provided, and running it if it was
    if (widget.dispose != null) {
      widget.dispose(_viewModel);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Getting the size of the screen and providing that too, cause it's convenient and nice and polite and yes I
    /// will be repeating this next time
    SizingInfo dimens = SizingInfo(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    T viewModel = _viewModel;
    return widget.builder(context, viewModel, dimens);
  }
}
