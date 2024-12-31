import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:orders_app/features/home/model/store_model/store_model.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';

class StoreTile extends StatelessWidget {
  const StoreTile({
    super.key,
    required this.onPressed,
    required this.store,
  });

  final Function(String, int) onPressed;
  final StoreModel store;

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: AppConstants.duration200ms,
      onPressed: () => onPressed(store.name , store.id),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          padding: AppConstants.padding16,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: AppConstants.borderRadius16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: AppColors.grey.withOpacity(0.4),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(store.photo ?? ""),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                store.name,
                style: TextStyle(
                  color: AppColors.blackShade2,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  height: 1.22,
                ),
              ),
              SizedBox(height: 2),
              Text(
                store.category,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  height: 1.22,
                ),
              ),
              SizedBox(height: 15),
              Text(
                store.location,
                style: TextStyle(
                  color: AppColors.orange,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
