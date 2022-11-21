import 'package:fragvest_mobile/constants/images_urls.dart';
import 'package:fragvest_mobile/model/onboard_model.dart';

final List<OnBoardModel> onBoardData = [
  OnBoardModel(
      title: 'Rent',
      description:
          'Find a property you like and rent, it’s that simple with the fragvest app',
      images: imgAmico),
  OnBoardModel(
      title: 'Sell',
      description:
          'Save your self the hassles. Sell your properties faster on fragvest.',
      images: imgBuilding),
  OnBoardModel(
      title: 'Buy',
      description:
          'Tired of falling for scams! Buy verified and valid properties on fragvest.',
      images: imgPana),
  OnBoardModel(
      title: 'Co-Own',
      description:
          'Don’t have the huge capital to invest in real estate? Co-invest in properties and earn interest yearly.',
      images: imgcuate)
];
