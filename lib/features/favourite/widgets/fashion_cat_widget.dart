import 'package:flutter/material.dart';
import 'package:zenan/features/favourite/widgets/const_colors.dart';

class FashionCategoriesWidget extends StatelessWidget {
  const FashionCategoriesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              decoration: BoxDecoration(
                  color: PinterestColors.softPeach,
                  borderRadius: BorderRadius.circular(40)),
              padding: EdgeInsets.only(left: 6, right: 10, top: 6, bottom: 6),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(
                        "https://tmcars.info/tmcars/images/thumbnail/2024/07/09/19/02/518da9a7-1d0b-46d7-abc9-6f226b1b0cb6.webp"),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Taze fason',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    return Row(
      children: [
        //1
        Container(
          decoration: BoxDecoration(
              color: PinterestColors.softPeach,
              borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.only(left: 6, right: 10, top: 6, bottom: 6),
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    "https://tmcars.info/tmcars/images/thumbnail/2024/07/09/19/02/518da9a7-1d0b-46d7-abc9-6f226b1b0cb6.webp"),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Taze fason',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 4,
        ),
//2

        Container(
          decoration: BoxDecoration(
              color: PinterestColors.lightTeal,
              borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.only(left: 6, right: 10, top: 6, bottom: 6),
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    "https://tmcars.info/tmcars/images/thumbnail/2024/07/09/19/02/518da9a7-1d0b-46d7-abc9-6f226b1b0cb6.webp"),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Stapel',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Container(
          decoration: BoxDecoration(
              color: PinterestColors.pastelMint,
              borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.only(left: 6, right: 10, top: 6, bottom: 6),
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    "https://tmcars.info/tmcars/images/thumbnail/2024/07/09/19/02/518da9a7-1d0b-46d7-abc9-6f226b1b0cb6.webp"),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Uste geyilyan',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 4,
        ),
        Container(
          decoration: BoxDecoration(
              color: PinterestColors.lightAqua,
              borderRadius: BorderRadius.circular(40)),
          padding: EdgeInsets.only(left: 6, right: 10, top: 6, bottom: 6),
          child: Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                    "https://tmcars.info/tmcars/images/thumbnail/2024/07/09/19/02/518da9a7-1d0b-46d7-abc9-6f226b1b0cb6.webp"),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                'Uste geyilyan',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
