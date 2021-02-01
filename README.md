# MobX Architecture

***Hello!*** This package allows you to more easily and cleanly bind your MobX stores to your UI. Depending on  whether people actually like and use it, more functionality might be added to it.
For now, however, it focuses  mainly on the binding of ViewModels to the UI,  and provides one additional class containing the height and width of the screen, for sizing widgets more conveniently. ( No one wants MediaQueries scattered all over the place, now do they? )

If you do like this package, please do star it over on GitHub. Any and all contributions, whether they be to the docs, or the code, in the form of bug fixes or new features, are both highly, highly appreciated and encouraged.

## Getting Started

### First, let's get some of the introductions, assumptions, and  requirements out of the way.
This package helps implement a custom version of the [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) architecture pattern,
smooshing together the  ***Widget-Store-Service***
 organization pattern mentioned in the [Flutter MobX docs](https://en.wikipedia.org/wiki/Model–view–viewmodel) with the traditional
 **Model-View-ViewModel** architecture pattern, resulting in a unified pattern where:
- The ***Model*** is relatively unchanged, and houses the services, API calls etc.
- The ***ViewModel*** is unified with the ***MobX Store***, and has the dual purpose of managing state (either local, shared or any other) as well as
the business logic of the corresponding ***View***
* The ***View*** is relatively unchanged, with the one major difference being ***Observer*** widgets sprinkled about as necessary,wrapping the parts of the UI
that render based on the state of the app

---

*This package assumes the following:*
- You are using the [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) architecture pattern to architect your app
- You are using [Provider](https://pub.dev/packages/provider) to inject your MobX stores. ( Although not required *per se*, as the package has widgets for that scenario, it is still ***highly*** recommended )
---

*This package depends on / must be used in conjunction with the following extra packages:*
- [MobX](https://pub.dev/packages/mobx) ( Of course )
- [Flutter Mobx](https://pub.dev/packages/flutter_mobx) ( For **Observer** Widgets, which you most likely are using already )
---
### Note:
- [Provider](https://pub.dev/packages/provider) is **highly** recommended to be used alongside MobX itself, as well as this package, and is internally used by parts of the package as well,to inject your MobX stores wherever they are required. Checkout the MobX [docs](https://mobx.netlify.app/guides/stores/) for more info.
---
*Before we begin, here are some packages that I reccommend using with this package, some because they play  better than others with this package, and some because I feel they promote the safest, cleanest code:*
- [Get_it](https://pub.dev/packages/get_it) for a service locator ( Even though Provider is most likely a dependency already, this package comes in handy for
injecting services and such, and also for accessing them from **ViewModels**, where the ***BuildContext*** isn't as
readily available, if at all
---

This package exposes 4 widgets, and 6 total variations in the implementation across those 4 widgets ( using constructors ), with
the widgets and their variations being split based on these 3 requirements:
- Binding a ViewModel that is ***not*** a MobX Store
- Binding a ViewModel that ***is*** a MobX Store
- Stateless and Stateful vairations of the above mentioned criteria, so as to be able to
access widget lifecycle methods, such as ***inItState( )*** and ***dispose(  )*** , when required.


They widgets are therefore as follows:
- _StatefulVMStoreBuilder\<T>( )_ : This widget is used for when you need to access widget lifecycle methods,  and are binding a ViewModel that is also a MobX Store to the UI. It has two constructors:
    - *StatefulVMStoreBuilder\<T>.standAlone( )* : This constructor is used if you are not using the Provider package

		``` dart
			StatefulVMStoreBuilder<Store>.standAlone(
			  key: ///Optionally provide a key ,
			  viewModelStoreBuilder: () => MyViewModelStore(),
			  builder: (BuildContext context, T store, SizingInfo sizingInfo) {
			    /// Provides the store, the BuildContext and an object containing
			    /// the sizing information of the screen, accessible through.
			    /// [sizingInfo.height] and [sizingInfo.width]

			    return Widget();
			    },
			  initState: (store) {
			  ///Provide a optional ininState method
			  },
			  dispose: (store) {
			  ///Provide a optional dispose method
			  },
			);
		```

    - *StatefulVMStoreBuilder\<T>.usesProvider( )* : This constructor is used if you are using the Provider package. It automatically reads the appropriate store from the type ***T*** , using Provider.
		``` dart
			StatefulVMStoreBuilder<Store>.usesProvider(
			  key: ///Optionally provide a key ,
			  builder: (BuildContext context, T store, SizingInfo sizingInfo) {
			  /// Provides the store, the BuildContext and an object containing
			  /// the sizing information of the screen, accessible through.
			  /// [sizingInfo.height] and [sizingInfo.width]

			  return Widget();
			  },
			  initState: (store) {
			  ///Provide a optional ininState method
			  },
			  dispose: (store) {
			  ///Provide a optional dispose method
			  },
			);
		```

-  *StatelessVMStoreBuilder\<T>( )*: This widget is used for when you ***don't*** need to access widget lifecycle methods,  and are binding a ViewModel that is also a MobX Store to the UI. It has two constructors:
   - *StatelesslVMStoreBuilder\<T>.standAlone( )* : This constructor is used if you are not using the Provider package
		``` dart
			StatelessVMStoreBuilder<Store>.standAlone(
			  key: ///Optionally provide a key ,
			  viewModelStoreBuilder: () => MyViewModelStore(),
			  builder: (BuildContext context, T store, SizingInfo sizingInfo) {
			  /// Provides the store, the BuildContext and an object containing
			  /// the sizing information of the screen, accessible through
			  /// [sizingInfo.height] and [sizingInfo.width]

			  return  Widget();
			  },
			);
		```
   - *StatelessVMStoreBuilder\<T>.usesProvider( )* : This constructor is used if you are using the Provider package. It automatically reads the appropriate store from the type ***T*** , using Provider.
		``` dart
			StatelessVMStoreBuilder<Store>.usesProvider(
			  key: ///Optionally provide a key ,
			  builder: (BuildContext context, T store, SizingInfo sizingInfo) {
			  /// Provides the store, the BuildContext and an object containing
			  /// the sizing information of the screen, accessible through
			  /// [sizingInfo.height] and [sizingInfo.width]

              return  Widget();
			  },
			);
		```

  - *StatefulVMBuilder\<T>( )* : This widget is used for when you need to access widget lifecycle methods, and are binding a ViewModel that is ***not***  a MobX Store to the UI.
	``` dart
		StatefulVMBuilder<Object>(
		  key: ///Optionally provide a key ,
		  viewModelStoreBuilder: () => MyViewModel(),
		  builder: (BuildContext context, T viewModel, SizingInfo sizingInfo) {
		  /// Provides the ViewModel, the BuildContext and an object containing
		  /// the sizing information of the screen, accessible through
		  /// [sizingInfo.height] and [sizingInfo.width]

		  return  Widget();
		  },
		  initState: (store) {
	      ///Provide a optional ininState method
		  },
		  dispose: (store) {
		  ///Provide a optional dispose method
		  },
		);
	```
- *StatelessVMBuilder\<T>( )* : This widget is used for when you ***don't*** need to access widget lifecycle methods, and are binding a ViewModel that is ***not***  a MobX Store to the UI.

	``` dart
		StatelessVMBuilder<Object>(
		  key: ///Optionally provide a key ,
		  viewModelStoreBuilder: () => MyViewModel(),
		  builder: (BuildContext context, T viewModel, SizingInfo sizingInfo) {
		  /// Provides the ViewModel, the BuildContext and an object containing
		  /// the sizing information of the screen, accessible through
		  /// [sizingInfo.height] and [sizingInfo.width]

		  return  Widget();
		  },
		);
	```
---
The package has been designed with ***modularity*** as one of its core principles. Except for MVVM, MobX itself, and Provider, which nearly 100% of people use alongside MobX, the package enforces ***no*** additional packages or principles, from Dialog services , to data persistence, to how you should structure your app , it's all left to the developer to implement in any way they please.

This stems from a core belief that every project is different, and has a different set of requirements and a rigorous structure and certain way to do things may only ever result in benefiting a small percentage of those projects, if that, and will likely result in many scenarios where people might have to "fight the framework", so to speak.
As such, going forward, this is probably the only thing about this framework that will be set in stone.

The framework will always therefore be **lightweight**, **unobstructive**, **unobtrusive**, and, most importantly, **modular**,  and will prioritize the above criteria above all else, allowing developers to switch out (or add on top off) functionality provided by the framework (or add new functionality all together) in the form of either separate, purpose-built packages or custom solutions, as easily as is possible.

---
## License
This package is licensed under the Apache License, Version 2.0
```
Copyright 2021 Tanzil Zubair Bin Zaman

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
