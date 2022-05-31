import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackerton_project/view/export_view.dart';

class RowButton extends StatelessWidget
{
  static const VISIT_BUTTON = 0;
  static const ARTICLE_BUTTON = 1;
  static const STAT_BUTTON = 2;
  static const MY_INFO_BUTTON = 3;
  final int pressedButton;

  RowButton({required this.pressedButton});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: pressedButton == VISIT_BUTTON? SvgPicture.asset('assets/logos/filled_visit_re.svg'): SvgPicture.asset('assets/logos/unfilled_visit_re.svg'),
          onPressed: () => onPressedVisit(context),
        ),
        IconButton(
          icon: pressedButton == ARTICLE_BUTTON? SvgPicture.asset('assets/logos/filled_search_re.svg'): SvgPicture.asset('assets/logos/unfilled_search_re.svg'),
          onPressed: () => onPressedArticle(context),
        ),
        IconButton(
          icon: pressedButton == STAT_BUTTON? SvgPicture.asset('assets/logos/filled_stat_re.svg'): SvgPicture.asset('assets/logos/unfilled_stat_re.svg'),
          onPressed: () => onPressedStat(context),
        ),
        IconButton(
          icon: pressedButton == MY_INFO_BUTTON? SvgPicture.asset('assets/logos/filled_user_re.svg'): SvgPicture.asset('assets/logos/unfilled_user_re.svg'),
          onPressed: () => onPressedMyInfo(context),
        )

      ],
    );
  }

  void onPressedVisit(BuildContext context)
  {
    if(pressedButton != VISIT_BUTTON )
      {
        Navigator.of(context).pushNamedAndRemoveUntil(VisitScreen.route, (Route<dynamic> route) => false,);
      }
  }

  void onPressedArticle(BuildContext context)
  {
    if(pressedButton != ARTICLE_BUTTON)
      {
        Navigator.of(context).pushNamedAndRemoveUntil(RecommendArticleScreen.route, (Route<dynamic> route) => false,);
      }
  }

  void onPressedStat(BuildContext context)
  {
    if(pressedButton != STAT_BUTTON)
      {

      }
  }

  void onPressedMyInfo(BuildContext context)
  {
    if(pressedButton != MY_INFO_BUTTON)
      {

      }
  }
}
