import 'package:flutter/material.dart';
import 'package:sante_pour_tous/src/constants/app_theme.dart';
import 'package:sante_pour_tous/src/models/universites/universite_model.dart';
import 'package:sante_pour_tous/src/pages/home/components/options_data.dart';

import '../../navigation/header/custom_appbar.dart';

class OptionsPage extends StatefulWidget {
  const OptionsPage({Key? key, this.universiteModel}) : super(key: key);
  final UniversiteModel? universiteModel;

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> {
  final ScrollController _controllerTwo = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [  
          CustomAppbar(title: widget.universiteModel!.name),
          const SizedBox(height: p20),

          Expanded(
              child: Scrollbar(
                  controller: _controllerTwo,
                  child: Wrap(
                    children: List.generate(dataMenu.length, (index) {
                      final optionData = dataMenu[index];
                      return dataCard(optionData);
                    }),
                  )))
        ],
      ),
    );
  }

  Widget dataCard(OptionData optionData) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Column(
      children: [
        Card(
          elevation: 10,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => optionData.tap));
            },
            child: Container(
              width: 150,
              height: 150,
              color: optionData.color,
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                optionData.icons,
                size: 80,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(
            width: 150,
            child: Text(
              optionData.title,
              textAlign: TextAlign.center,
              style: headline6!.copyWith(fontSize: 14.0),
              overflow: TextOverflow.visible,
            ))
      ],
    );
  }

}
