import 'package:flutter/material.dart';
import 'package:mobx_architecture/mobx_architecture.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

//Importing the ViewModels/Store
import 'vmodels/counter_vmodel.dart';
import 'stores/counter_store.dart';

// Counter Example using Provider and with a Stateless Widget
class CounterExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MobX Counter'),
        ),
        body: StatelessVMStoreBuilder<CounterStore>.usesProvider(
          builder: (context, counterStoreVM, sizingInfo) {
            return Container(
              // Using the sizing information provided in the builder function
              height: sizingInfo.size.height,
              width: sizingInfo.size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Observer(
                    builder: (_) => Text(
                      // Using the Store ViewModel provided by the builder function using Provider
                      '${counterStoreVM.value}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        counterStoreVM.increment();
                      })
                ],
              ),
            );
          },
        ),
      );
}

// Counter Example without Provider and with a Stateless Widget
class CounterExample2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MobX Counter'),
        ),
        body: StatelessVMStoreBuilder<CounterStore>.standAlone(
          viewModelStoreBuilder: () => CounterStore(),
          builder: (context, counterStoreVM, sizingInfo) {
            return Container(
              // Using the sizing information provided in the builder function
              height: sizingInfo.size.height,
              width: sizingInfo.size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Observer(
                    builder: (_) => Text(
                      // Using the Store ViewModel provided by the builder function using Provider
                      '${counterStoreVM.value}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        counterStoreVM.increment();
                      })
                ],
              ),
            );
          },
        ),
      );
}

// Counter Example with Provider and with a Stateful Widget
class CounterExample3 extends StatefulWidget {
  @override
  _CounterExample3State createState() => _CounterExample3State();
}

class _CounterExample3State extends State<CounterExample3> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MobX Counter'),
        ),
        body: StatefulVMStoreBuilder<CounterStore>.usesProvider(
          builder: (context, counterStoreVM, sizingInfo) {
            return Container(
              // Using the sizing information provided in the builder function
              height: sizingInfo.size.height,
              width: sizingInfo.sizewidth,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Observer(
                    builder: (_) => Text(
                      // Using the Store ViewModel provided by the builder function using Provider
                      '${counterStoreVM.value}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        counterStoreVM.increment();
                      })
                ],
              ),
            );
          },
          initState: (counterModel) {
            counterModel.init();
          },
          dispose: (counterModel) {
            counterModel.dispose();
          },
        ),
      );
}

// Counter Example without Provider and with a Stateful Widget
class CounterExample4 extends StatefulWidget {
  @override
  _CounterExample4State createState() => _CounterExample4State();
}

class _CounterExample4State extends State<CounterExample4> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MobX Counter'),
        ),
        body: StatefulVMStoreBuilder<CounterStore>.standAlone(
          viewModelStoreBuilder: () => CounterStore(),
          builder: (context, counterStoreVM, sizingInfo) {
            return Container(
              // Using the sizing information provided in the builder function
              height: sizingInfo.size.height,
              width: sizingInfo.size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Observer(
                    builder: (_) => Text(
                      // Using the Store ViewModel provided by the builder function using Provider
                      '${counterStoreVM.value}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        counterStoreVM.increment();
                      })
                ],
              ),
            );
          },
          initState: (counterModel) {
            counterModel.init();
          },
          dispose: (counterModel) {
            counterModel.dispose();
          },
        ),
      );
}

// Counter Example without MobX and with a Stateful Widget
class CounterExample5 extends StatefulWidget {
  @override
  _CounterExample5State createState() => _CounterExample5State();
}

class _CounterExample5State extends State<CounterExample5> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MobX Counter'),
        ),
        body: StatefulVMBuilder<CounterVModel>(
          viewModelBuilder: () => CounterVModel(value: 0),
          builder: (context, counterModel, sizingInfo) {
            return Container(
              // Using the sizing information provided in the builder function
              height: sizingInfo.size.height,
              width: sizingInfo.size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Observer(
                    builder: (_) => Text(
                      // Using the Store ViewModel provided by the builder function using Provider
                      '${counterModel.value}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        counterModel.increment();
                      })
                ],
              ),
            );
          },
          initState: (counterModel) {
            counterModel.init();
          },
          dispose: (counterModel) {
            counterModel.dispose();
          },
        ),
      );
}

// Counter Example without MobX and with a Stateless Widget
class CounterExample6 extends StatefulWidget {
  @override
  _CounterExample6State createState() => _CounterExample6State();
}

class _CounterExample6State extends State<CounterExample6> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('MobX Counter'),
        ),
        body: StatelessVMBuilder<CounterVModel>(
          viewModelBuilder: () => CounterVModel(value: 0),
          builder: (context, counterModel, sizingInfo) {
            return Container(
              // Using the sizing information provided in the builder function
              height: sizingInfo.size.height,
              width: sizingInfo.size.width,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'You have pushed the button this many times:',
                  ),
                  Observer(
                    builder: (_) => Text(
                      // Using the Store ViewModel provided by the builder function using Provider
                      '${counterModel.value}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        counterModel.increment();
                      })
                ],
              ),
            );
          },
        ),
      );
}
