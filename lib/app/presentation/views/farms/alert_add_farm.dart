

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/farm_model.dart';
import '../../controllers/farms_controller.dart';
import '../../widgets/custom_buttom.dart';


class AlertAddFarmView extends StatefulWidget {
  const AlertAddFarmView({Key? key}) : super(key: key);

  @override
  State<AlertAddFarmView> createState() => _AlertAddFarmViewState();
}

class _AlertAddFarmViewState extends State<AlertAddFarmView> {
  final TextEditingController name = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return  Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text('Digite o nome da Fazenda', style: TextStyle(color: Colors.black,
                  fontSize: 18, fontWeight: FontWeight.w600),),
            ),
            SizedBox(height: 5,),
            SizedBox(
              width: 250,
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                    fillColor: Colors.white, filled: true,
                    hintText: 'Fazenda',
                    contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                    border: const OutlineInputBorder(borderSide: BorderSide(),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    errorStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.red.shade100)
                ),
                validator: (v) {
                  if(v == null || v == ''){
                    return 'Digite o nome da Fazenda';
                  }
                },
              ),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButtom.custom(
                  title: 'Cancelar',
                  size: 90,
                  color: Colors.red,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 5,),
                CustomButtom.custom(
                  title: 'Confirmar',
                  size: 90,
                  onPressed: () async {
                    if(formKey.currentState!.validate()){
                      await context.read<FarmsController>().addFarm(FarmModel(
                        name: name.text
                      ));
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
