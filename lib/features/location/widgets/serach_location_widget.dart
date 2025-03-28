import 'package:zenan/features/location/widgets/location_search_dialog.dart';
import 'package:zenan/util/dimensions.dart';
import 'package:zenan/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchLocationWidget extends StatelessWidget {
  final GoogleMapController? mapController;
  final String? pickedAddress;
  final bool? isEnabled;
  final bool? isPickedUp;
  final bool? fromDialog;
  final String? hint;
  const SearchLocationWidget(
      {super.key,
      required this.mapController,
      required this.pickedAddress,
      required this.isEnabled,
      this.isPickedUp,
      this.hint,
      this.fromDialog = false});

  @override
  Widget build(BuildContext context) {
    return LocationSearchDialog(
        mapController: mapController,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
            border: isEnabled != null
                ? Border.all(
                    color: fromDialog!
                        ? Theme.of(context).disabledColor
                        : isEnabled!
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).disabledColor,
                    width: isEnabled! ? 2 : 1,
                  )
                : null,
          ),
          child: Row(children: [
            (pickedAddress != null && pickedAddress!.isNotEmpty)
                ? Icon(
                    Icons.location_on,
                    size: 25,
                    color: (isEnabled == null || isEnabled!)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).disabledColor,
                  )
                : Text('search_location'.tr,
                    style: robotoRegular.copyWith(
                        color: Theme.of(context).disabledColor)),
            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            Expanded(
              child: (pickedAddress != null && pickedAddress!.isNotEmpty)
                  ? Text(
                      pickedAddress!,
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  : Text(
                      hint ?? '',
                      style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).hintColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Icon(Icons.search,
                size: 25,
                color: fromDialog!
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).textTheme.bodyLarge!.color),
          ]),
        ));
  }
}
