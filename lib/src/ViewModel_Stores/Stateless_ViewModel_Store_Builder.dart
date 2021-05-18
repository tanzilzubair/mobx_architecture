import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

// This package helps bind your View Model MobX stores with your UI more clearly.
// THIS WIDGET DOES NOT OBSERVER STATE, IDEALLY YOU WOULD BE USING OBSERVER WIDGETS FOR THAT FUNCTIONALITY

/// This widget is used to bind a View Model MobX store ( one that DOES NOT REQUIRE an initState or dispose function or both )
/// to the UI in a much more cleaner, manageable and dare I say elegant way
///
/// For use-cases that require a MobX store that IS being injected using Provider, use the [usesProvider] constructor
///
/// For use-cases that require a standalone MobX store that is NOT being injected using Provider, use the [standAlone] constructor
///
/// For uses-cases that DO require a MobX store that uses the initState or dispose function or both, use the [StatefulVMStoreBuilder] widget
///
/// For use-cases that do not require a MobX store at all, but rather a "plain" View Model class,
/// use the [StatelessVMBuilder] widget or the [StatefulVMBuilder] widget
///
enum _ViewModelType { UsesProvider, StandAlone }

class StatelessVMStoreBuilder<T extends Store> extends StatelessWidget {
  /// This is the constructor to use for when the MobX store is injected using Provider
  const StatelessVMStoreBuilder.usesProvider({
    Key? key,
    required this.builder,
  })   : viewModelStoreBuilder = null,
        _viewModelType = _ViewModelType.UsesProvider,
        super(key: key);

  /// This is the constructor to use for a standalone MobX store that is NOT injected using Provider
  const StatelessVMStoreBuilder.standAlone({
    Key? key,
    required this.builder,
    required this.viewModelStoreBuilder,
  })   : _viewModelType = _ViewModelType.StandAlone,
        super(key: key);

  /// This is the builder function that exposes the View Model MobX store, the BuildContext and the SizingInfo object
  final Widget Function(
      BuildContext context, T store, MediaQueryData mediaQuery) builder;

  /// This is the function that builds the MobX ViewModel Store, and is to be used ONLY when
  /// the store is not being injected using Provider
  final T Function()? viewModelStoreBuilder;

  /// This is to aid in the conditional logic inside the widget to either get the MobX store
  /// from Provider or just build the store given
  final _ViewModelType _viewModelType;

  @override
  Widget build(BuildContext context) {
    // This is the conditional logic determining whether to get the MobX store from Provider
    // or just build the standalone store given
    if (_viewModelType == _ViewModelType.UsesProvider) {
      // Using from Provider
      return builder(
          context, context.select((T store) => store), MediaQuery.of(context));
    } else if (_viewModelType == _ViewModelType.StandAlone) {
      // Using the given standalone store
      T store = viewModelStoreBuilder!();
      return builder(context, store, MediaQuery.of(context));
    } else {
      print(
          "Unexpected error occurred in the MobX Architecture Package, in the StatelessVMStoreBuilder Widget, "
          "I'm serious, you need to check this out, or report it, or both, like there's "
          "absolutely no way this should ever fire");
      return Container();
    }
  }
}
