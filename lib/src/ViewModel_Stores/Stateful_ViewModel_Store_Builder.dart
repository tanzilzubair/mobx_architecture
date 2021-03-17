import 'package:mobx_architecture/src/Components/SizingInfo.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

// This package helps bind your View Model MobX stores with your UI more clearly.
// THIS WIDGET DOES NOT OBSERVER STATE, IDEALLY YOU WOULD BE USING OBSERVER WIDGETS FOR THAT FUNCTIONALITY

/// This widget is used to bind a View Model MobX store ( one that REQUIRES an initState or dispose function or both )
/// to the UI in a much more cleaner, manageable and dare I say elegant way.
///
/// For use-cases that require a MobX store that IS being injected using Provider, use the [usesProvider] constructor
///
/// For use-cases that require a standalone MobX store that is NOT being injected using Provider, use the [standAlone] constructor
///
/// For uses-cases that do NOT require a MobX store that uses the initState or dispose function or both, use the [StatelessVMStoreBuilder] widget
///
/// For use-cases that do not require a MobX store at all, but rather a "plain" View Model class,
/// use the [StatelessVMBuilder] widget or the [StatefulVMBuilder] widget

enum _ViewModelType { UsesProvider, StandAlone }

class StatefulVMStoreBuilder<T extends Store> extends StatefulWidget {
  /// This is the constructor to use for when the MobX store is injected using Provider
  const StatefulVMStoreBuilder.usesProvider(
      {Key? key, required this.builder, this.initState, this.dispose})
      : viewModelStoreBuilder = null,
        _viewModelType = _ViewModelType.UsesProvider,
        super(key: key);

  /// This is the constructor to use for a standalone MobX store that is NOT injected using Provider
  const StatefulVMStoreBuilder.standAlone({
    Key? key,
    required this.builder,
    required this.viewModelStoreBuilder,
    this.initState,
    this.dispose,
  })  : _viewModelType = _ViewModelType.StandAlone,
        super(key: key);

  /// This is the builder function that exposes the View Model MobX store, the BuildContext and the SizingInfo object
  final Widget Function(BuildContext context, T store, SizingInfo dimens)
      builder;

  /// This is the optional function that runs inside initState
  final void Function(T store)? initState;

  /// This is the optional function that runs inside dispose
  final void Function(T store)? dispose;

  /// This is the conditional function that builds the MobX ViewModel Store, and is to be used ONLY when
  /// the store is not being injected using Provider
  final T Function()? viewModelStoreBuilder;

  /// This is to aid in the conditional logic inside the widget to either get the MobX store
  /// from Provider or just build the store given
  final _ViewModelType _viewModelType;

  @override
  _StatefulVMStoreBuilderState<T> createState() =>
      _StatefulVMStoreBuilderState<T>();
}

class _StatefulVMStoreBuilderState<T extends Store>
    extends State<StatefulVMStoreBuilder<T>> {
  late T _store;
  @override
  void initState() {
    super.initState();

    // This is the conditional logic determining whether to get the MobX store from Provider
    // or just build the standalone store given
    if (widget._viewModelType == _ViewModelType.UsesProvider) {
      // Using from Provider
      _store = context.read<T>();
    } else if (widget._viewModelType == _ViewModelType.StandAlone) {
      // Using the given standalone store
      _store = widget.viewModelStoreBuilder!();
    } else {
      print(
          "Unexpected error occurred in the MobX Architecture Package, in the StatefulVMStoreBuilder Widget, "
          "I'm serious, something has gone terribly wrong, like there's "
          "absolutely no way this should ever fire");
    }

    // Checking to see if a initState function was provided, and running it if it was
    if (widget.initState != null) {
      widget.initState!(_store);
    }
  }

  @override
  void dispose() {
    // Checking to see if a dispose function was provided, and running it if it was
    if (widget.dispose != null) {
      widget.dispose!(_store);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Getting the size of the screen and providing that too, cause it's convenient and nice and polite ;)
    SizingInfo dimens = SizingInfo(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height);
    return widget.builder(context, context.select((T store) => store), dimens);
  }
}
