import 'package:zenan/features/checkout/controllers/checkout_controller.dart';
import 'package:zenan/features/checkout/domain/models/offline_method_model.dart';
import 'package:zenan/helper/responsive_helper.dart';
import 'package:zenan/util/dimensions.dart';
import 'package:zenan/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class OfflinePaymentButton extends StatelessWidget {
  final bool isSelected;
  final List<OfflineMethodModel>? offlineMethodList;
  final bool isOfflinePaymentActive;
  final Function onTap;
  final CheckoutController checkoutController;
  final JustTheController tooltipController;
  const OfflinePaymentButton(
      {super.key,
      required this.isSelected,
      required this.offlineMethodList,
      required this.isOfflinePaymentActive,
      required this.onTap,
      required this.checkoutController,
      required this.tooltipController});

  @override
  Widget build(BuildContext context) {
    return (isOfflinePaymentActive &&
            offlineMethodList != null &&
            offlineMethodList!.isNotEmpty)
        ? InkWell(
            onTap: onTap as void Function()?,
            child: Container(
              width: 550,
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                border: Border.all(
                    color: Theme.of(context).disabledColor, width: 0.3),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeSmall,
                  vertical: Dimensions.paddingSizeLarge),
              margin:
                  const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
              child: Column(children: [
                Row(children: [
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? Colors.green
                            : Theme.of(context).cardColor,
                        border:
                            Border.all(color: Theme.of(context).disabledColor)),
                    child: Icon(Icons.check,
                        color: Theme.of(context).cardColor, size: 16),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault),
                  Expanded(
                    child: Text(
                      'pay_offline'.tr,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeDefault),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  JustTheTooltip(
                    backgroundColor: Colors.black87,
                    controller: tooltipController,
                    preferredDirection: AxisDirection.up,
                    tailLength: 14,
                    tailBaseWidth: 20,
                    content: Padding(
                      padding:
                          const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      child: SizedBox(
                        width: 400,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('note'.tr,
                                style: robotoMedium.copyWith(
                                    color: const Color(0xff90D0FF))),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            OfflinePaymentTooltipNoteWidget(
                              note: 'offline_payment_note_line_one'.tr,
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            OfflinePaymentTooltipNoteWidget(
                              note: 'offline_payment_note_line_two'.tr,
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            OfflinePaymentTooltipNoteWidget(
                              note: 'offline_payment_note_line_three'.tr,
                            ),
                          ],
                        ),
                      ),
                    ),
                    child: InkWell(
                      onTap: () => tooltipController.showTooltip(),
                      child: isSelected
                          ? Icon(Icons.info_rounded,
                              color: Theme.of(context).primaryColor, size: 18)
                          : const SizedBox(),
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                ]),
                SizedBox(height: isSelected ? Dimensions.paddingSizeLarge : 0),
                isSelected
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: Dimensions.paddingSizeDefault,
                          mainAxisSpacing: Dimensions.paddingSizeDefault,
                          mainAxisExtent: 50,
                          crossAxisCount:
                              ResponsiveHelper.isDesktop(context) ? 4 : 3,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: offlineMethodList!.length,
                        itemBuilder: (context, index) {
                          bool isSelected =
                              checkoutController.selectedOfflineBankIndex ==
                                  index;
                          return InkWell(
                            onTap: () =>
                                checkoutController.selectOfflineBank(index),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withOpacity(0.8)
                                    : Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusLarge),
                              ),
                              child: Center(
                                  child: Text(
                                offlineMethodList![index].methodName!,
                                style: robotoMedium.copyWith(
                                    color: isSelected
                                        ? Theme.of(context).cardColor
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .color!),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
              ]),
            ),
          )
        : const SizedBox();
  }
}

class OfflinePaymentTooltipNoteWidget extends StatelessWidget {
  final String note;
  const OfflinePaymentTooltipNoteWidget({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(
          flex: 0,
          child: Container(
            height: 5,
            width: 5,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: Dimensions.paddingSizeSmall),
        Expanded(
            child: Text(note,
                style: robotoRegular.copyWith(
                    color: Theme.of(context).cardColor))),
      ],
    );
  }
}
