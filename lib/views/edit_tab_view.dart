// Edit Tab View 
// Author: Chris Kneller
// Date March 2022
// Version 1.

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:truthormare/utility/failure.dart';
import 'package:truthormare/widgets/app_wide/popup_message.dart';
import '../widgets/customise_game/customise_list_view.dart';
import '../providers/cards.dart';
import '../db/db_helper.dart';
import 'package:either_dart/either.dart';

class EditTabView extends StatefulWidget {
  final textContentController = TextEditingController();

  final CardElement currentCardElement;

  EditTabView(this.currentCardElement, {Key? key}) : super(key: key);

  @override
  _EditTabViewState createState() => _EditTabViewState();
}

class _EditTabViewState extends State<EditTabView> {
  bool _isValidated() {
    if (widget.textContentController.text.length > 4) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    CardsProvider cardsData =
        Provider.of<CardsProvider>(context, listen: false);

    void submitAndAddToList() async {
      String textContent = widget.textContentController.text;

      if (_isValidated()) {
       
        Either<Failure, Map<String, dynamic>> itemSaved =
            await DBHelper.saveToDatabase(
          textContent,
          widget.currentCardElement,
        );

        itemSaved.fold(
            (failure) => {
                  showDialog(
                    context: context,
                    builder: (ctx) => PopupMessage(
                      isError: true,
                      messageContent: failure.errorContent,
                    ),
                  ),
                },
            (result) => {
                  if (widget.currentCardElement == CardElement.truth)
                    {cardsData.addPlayerGenTruth(result['id'], textContent)}
                  else
                    {cardsData.addPlayerGenDare(result['id'], textContent)},
                  showDialog(
                    context: context,
                    builder: (ctx) => PopupMessage(
                        isError: false,
                        messageContent: result['success'].successContent),
                  ),
                });
      }
    }

    String title = "";

    if (widget.currentCardElement == CardElement.truth) {
      title = "Truth";
    } else {
      title = "Dare";
    }

    void _submitEntry() {
      if (_isValidated()) {
        submitAndAddToList();
        widget.textContentController.clear();
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 12.5),
      child: Column(
        children: [
          Text(title),
          const SizedBox(
            height: 25,
          ),
          Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              padding: const EdgeInsets.all(50),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: widget.textContentController,
                      onChanged: (value) => {setState(() => {})},
                      onSubmitted: (value) => _submitEntry(),
                      maxLines: 2,
                      inputFormatters: [LengthLimitingTextInputFormatter(100)],
                    ),
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: _isValidated()
                        ? Colors.green
                        : const Color.fromRGBO(0, 250, 0, 0.2),
                    child: IconButton(
                      onPressed: _isValidated() ? _submitEntry : null,
                      icon: const Icon(
                        Icons.check,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomiseListView(widget.currentCardElement)
        ],
      ),
    );
  }
}
