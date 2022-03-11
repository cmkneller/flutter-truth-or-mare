import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truthormare/db/db_helper.dart';
import 'package:truthormare/utility/failure.dart';
import 'package:truthormare/utility/success.dart';
import 'package:truthormare/widgets/app_wide/popup_message.dart';
import '../../providers/cards.dart';
import 'customise_list_tile.dart';
import 'package:either_dart/either.dart';

class CustomiseListView extends StatelessWidget {
  final CardElement currentCardElement;

// holds our list of items, set up so it can hold either Truths or Dares.

  const CustomiseListView(this.currentCardElement, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardsProvider cardsProvider = Provider.of<CardsProvider>(context);
    // Checks to display either a list of truths or a list of dares
    List dataList = currentCardElement == CardElement.truth
        ? cardsProvider.playerGenTruthList
        : cardsProvider.playerGenDareList;

    // Selects the correct delete method
    void deleteFunction(id) async {
      Either<Failure, Success> deleteStatus =
          await DBHelper.deleteFromDatabase(id, currentCardElement);
      deleteStatus.fold(
        (failure) => {
          showDialog(
            context: context,
            builder: (ctx) => PopupMessage(
                messageContent: failure.errorContent, isError: true),
          ),
        },
        (success) => {
          showDialog(
            context: context,
            builder: (ctx) => PopupMessage(
                messageContent: success.successContent, isError: false),
          ),
          if (currentCardElement == CardElement.truth)
            {
              cardsProvider.removeTruth(id),
            }
          else
            {
              cardsProvider.removeDare(id),
            }
        },
      );
    }

    String title = currentCardElement == CardElement.truth ? "Truth" : "Dare";

    return Expanded(
      child: dataList.isNotEmpty
          ? ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (ctx, i) => CustomiseListTile(
                  dataList[i].id, title, dataList[i].text, deleteFunction),
            )
          : Center(
              child: Text("No " + title.toLowerCase() + 's found!'),
            ),
    );
  }
}
