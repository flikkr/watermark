// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetACubit extends Cubit<void> {
  WidgetACubit({initialState}) : super(initialState);
  int count = 0;
  void doSomething() => emit(count++);
}

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (_) => ButtonBloc(),
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
            context.read<ButtonBloc>().add(ButtonPressedEvent());
            WidgetB.count++;
            print("Something has been done ${WidgetB.count} times");
          },
          child: const Text("Press me to do something"),
        ),
        WidgetB(),
      ],
    );
  }
}

class WidgetB extends StatelessWidget {
  static int count = 9223372036854775800;

  WidgetB({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonBloc, void>(
      builder: (context, state) {
        return Text("I've been rebuilt $count times");
      },
    );
  }
}

class ButtonPressedEvent {}

class ButtonBloc extends Bloc<ButtonPressedEvent, void> {
  ButtonBloc() : super(null) {
    on<ButtonPressedEvent>((event, emit) {
      emit(null);
    });
  }
}
