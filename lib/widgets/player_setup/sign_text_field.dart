import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/providers/players.dart';
import 'package:truthormare/widgets/app_wide/glossy_button.dart';

class SignTextField extends StatefulWidget {
  const SignTextField({
    Key? key,
    required double deviceWidth,
  })  : _deviceWidth = deviceWidth,
        super(key: key);

  final double _deviceWidth;

  @override
  State<SignTextField> createState() => _SignTextFieldState();
}

class _SignTextFieldState extends State<SignTextField>
    with SingleTickerProviderStateMixin {
  final _playerNameTextController = TextEditingController();
  late AnimationController _signController;

  late Animation _signAnimation;
  bool _validated = false;

  void _textListener() {
    int nameLength = _playerNameTextController.value.text.length;
    if (nameLength > 0) {
      _validated = true;
    } else {
      _validated = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _playerNameTextController.addListener(_textListener);
    _signController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _signAnimation = Tween(begin: 1.0, end: 1.05).animate(_signController);

    _signController.addListener(() {
      if (_signController.isCompleted) {
        _signController.repeat(reverse: true);
      }
    });

    _signController.forward();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _signController.dispose();
    _playerNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PlayersProvider provider =
        Provider.of<PlayersProvider>(context, listen: false);

    void submitText() {
      if (_validated) {
        provider.generatePlayerAddToList(_playerNameTextController.text);
        _playerNameTextController.clear();
      }
    }

    return AnimatedBuilder(
      animation: _signAnimation,
      builder: (context, child) => Positioned(
        bottom: widget._deviceWidth * 0.16,
        width: widget._deviceWidth * 0.66,
        child: Transform.scale(
          scale: _validated ? 1 : _signAnimation.value,
          child: Stack(alignment: Alignment.center, children: [
            SizedBox(
              width: 800,
              height: 100,
            ),
            Positioned(
              child: Image.asset(
                "assets/images/player/sign.png",
                width: 120,
              ),
            ),
            Positioned(
              bottom: 39,
              width: 110,
              child: TextField(
                onSubmitted: ((value) => {
                  submitText()
                }),
                controller: _playerNameTextController,
                textCapitalization: TextCapitalization.characters,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
                autofocus: true,
                decoration: InputDecoration.collapsed(hintText: ""),
                textAlign: TextAlign.center,
                maxLines: 1,
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
              ),
            ),
            if (_validated)
              Positioned(
                right: 0,
                top: 50,
                child: Transform.scale(
                    scale: _signAnimation.value * 1.08,
                    child: GlossyButton(Icon(Icons.add), submitText, 23,
                        Color.fromARGB(179, 8, 176, 14))),
              ),
          ]),
        ),
      ),
    );
  }
}
