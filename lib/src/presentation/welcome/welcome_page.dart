import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kalonga/src/presentation/app/cubit/app_cubit.dart';
import 'package:kalonga/src/presentation/shared/custome_alert.dart';
import 'package:kalonga/src/presentation/shared/language_menu.dart';
import 'package:kalonga/src/presentation/shared/theme_menu.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  static const String id = '/welcome-screen';

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final TextEditingController _controller = TextEditingController();

  void _onPlay() {
    if (_controller.text.isEmpty) {
      customAlert(
        context: context,
        content: AppLocalizations.of(context)!.enterUserName,
      );
    } else {
      context.read<AppCubit>().login(username: _controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [LanguageMenu(), ThemeMenu()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: -0.1,
              child: Text(
                'Kalonga',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontFamily: 'Permanent Marker',
                    ),
              ),
            ),
            CustomTextField(controller: _controller),
            PlayButton(
              onPlay: _onPlay,
            )
          ],
        ),
      ),
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.onPlay,
  });
  final VoidCallback onPlay;
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.1,
      child: Container(
          margin: const EdgeInsets.only(top: 50),
          width: 200,
          height: 70,
          child: ElevatedButton(
              onPressed: onPlay,
              child: Text(
                AppLocalizations.of(context)!.play,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      fontFamily: 'Permanent Marker',
                    ),
              ))),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required TextEditingController controller,
  }) : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.1,
      child: Container(
          margin: const EdgeInsets.only(top: 20),
          height: 50,
          width: 300,
          child: TextField(
            controller: _controller,
          )),
    );
  }
}
