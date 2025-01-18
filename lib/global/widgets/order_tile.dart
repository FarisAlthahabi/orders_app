import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/features/cart/model/order_model/order_model.dart';
import 'package:orders_app/global/extensions/date_time_extension.dart';
import 'package:orders_app/global/extensions/string_extension.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/app_image_widget.dart';

class OrderTile extends StatefulWidget {
  const OrderTile({
    super.key,
    required this.order,
    required this.index,
    required this.onOrderLongPress,
    required this.onOrderTap,
  });

  final OrderModel order;
  final int index;
  final ValueSetter<OrderModel> onOrderLongPress;
  final ValueSetter<OrderModel> onOrderTap;

  @override
  State<OrderTile> createState() => _OrderTileState();
}

class _OrderTileState extends State<OrderTile> {
  @override
  Widget build(BuildContext context) {
    final customer = widget.order.customer;

    return InkWell(
      onLongPress: () => widget.onOrderLongPress(widget.order),
      onTap: () => widget.onOrderTap(widget.order),
      child: Card(
        child: Container(
          padding: AppConstants.padding16,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.greyShade,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.blue.withOpacity(0.6),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      (widget.index + 1).toString(),
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.order.payment.capitalizeFirstLetter,
                              style: TextStyle(
                                color: AppColors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Spacer(),
                            Text(
                              widget.order.status,
                              style: TextStyle(
                                color: AppColors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Text(
                              "total_price".tr(),
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 10),
                            Text(widget.order.totalPrice.toString()),
                          ],
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "order_date".tr(),
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(width: 10),
                            Text(widget.order.createdAt.formatMMddYYYY),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (customer != null)
                Column(
                  children: [
                    SizedBox(height: 20),
                    Divider(),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        AppImageWidget(
                          height: 100,
                          width: 100,
                          url: customer.photo,
                          border: Border.all(color: AppColors.orange, width: 4),
                          borderRadius: AppConstants.circularBorderRadius,
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${customer.firstName} ${customer.lastName}",
                              style: TextStyle(
                                color: AppColors.blackShade2,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                height: 1.22,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              customer.phoneNumber,
                              style: TextStyle(
                                color: AppColors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                height: 1.22,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              customer.location ?? "unknown".tr(),
                              style: TextStyle(
                                color: AppColors.orange,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                height: 1.22,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
