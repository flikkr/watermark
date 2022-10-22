import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetACubit extends Cubit<void> {
  WidgetACubit({initialState}) : super(initialState);

  void doSomething() => emit(null);
}

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (_) => WidgetACubit(),
          child: WidgetA(),
        ),
      ),
    );
  }
}

class WidgetA extends StatelessWidget {
  WidgetA({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            BlocProvider.of<WidgetACubit>(context).doSomething();
            print("Something has been done");
            WidgetB.count++;
          },
          child: const Text("Press me to do something"),
        ),
        WidgetB(),
      ],
    );
  }
}

class WidgetB extends StatelessWidget {
  static int count = 0;

  WidgetB({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WidgetACubit, void>(
      builder: (context, state) {
        return Text("I've been rebuilt $count times");
      },
    );
  }
}
