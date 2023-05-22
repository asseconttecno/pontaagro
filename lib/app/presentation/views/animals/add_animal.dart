

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../../../config/routes.dart';
import '../../../config/theme_colors.dart';
import '../../../data/models/animal_model.dart';
import '../../controllers/animals_controller.dart';
import '../../controllers/farms_controller.dart';
import '../../widgets/custom_buttom.dart';
import '../../widgets/custom_snackbar.dart';


class AddAnimalsView extends StatefulWidget {
  const AddAnimalsView({Key? key}) : super(key: key);

  @override
  State<AddAnimalsView> createState() => _AddAnimalsViewState();
}

class _AddAnimalsViewState extends State<AddAnimalsView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController tag = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Routes.animals.navigator(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Digite o nome do Animal'),
      ),
      body: Column(
        children: [
          Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                        fillColor: Colors.white, filled: true,
                        hintText: 'Nome',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                        border: const OutlineInputBorder(borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        errorStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.red.shade100)
                    ),
                    validator: (v) {
                      if(v == null || v == ''){
                        return 'Digite o nome do Animal';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 15,),

                  TextFormField(
                    controller: tag,
                    keyboardType: TextInputType.number,
                    maxLength: 15,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                        fillColor: Colors.white, filled: true,
                        hintText: 'Tag',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 25),
                        border: const OutlineInputBorder(borderSide: BorderSide(),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        errorStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.red.shade100)
                    ),
                    validator: (v) {
                      if(v == null || v == '' ){
                        return 'Digite os numeros da tag';
                      }else if(v.length != 15){
                        return 'Digite os 15 digitos da tag';
                      }
                      return null;
                    },
                  ),

                  CustomButtom.custom(
                    title: 'Adicionar',
                    size: 90,
                    onPressed: () async {
                      if(formKey.currentState!.validate()) {
                        context.read<AnimalsController>().addListAnimals(AnimalModel(
                            farmId: context.read<FarmsController>().farmSelected?.id ?? 0,
                            name: name.text, tag: tag.text
                        ));
                        name.clear();
                        tag.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15),
              children: context.watch<AnimalsController>().listAnimals.map((e) {
                return ListTile(
                    title: Text(e.name),
                    subtitle: Text(e.tag),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red,),
                      onPressed: () => context.read<AnimalsController>().removeListAnimals(e),
                    ),
                    shape: Border(bottom: BorderSide(color: Colors.grey[300]!))
                );
              }).toList()
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButtom.custom(
                title: 'Limpar',
                size: 90,
                color: Colors.red,
                onPressed: () {
                  context.read<AnimalsController>().listAnimals.clear();
                  setState(() {});
                },
              ),
              SizedBox(width: 5,),
              CustomButtom.custom(
                title: 'Salvar',
                color: ThemeColors.mainColor,
                size: 90,
                onPressed: () async {
                  final result = await context.read<AnimalsController>().addAnimals();
                  if(result){
                    CustomSnackbar.sucess(text: 'Animais adicionados com sucesso!', context: context);
                    Routes.animals.navigator(context);
                  }else{
                    CustomSnackbar.error(text: 'Não foi possivel adicionar os animais!', context: context);
                  }
                },
              ),
            ],
          )
        ],
      ),

    );
  }

}
