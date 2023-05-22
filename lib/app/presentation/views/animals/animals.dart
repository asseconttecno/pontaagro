

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../config/routes.dart';
import '../../../data/models/animal_model.dart';
import '../../controllers/animals_controller.dart';
import '../../controllers/farms_controller.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_snackbar.dart';
import 'add_animal.dart';

class AnimalsView extends StatefulWidget {
  const AnimalsView({Key? key}) : super(key: key);

  @override
  State<AnimalsView> createState() => _AnimalsViewState();
}

class _AnimalsViewState extends State<AnimalsView> {


  @override
  Widget build(BuildContext context) {

    return Consumer<AnimalsController>(
      builder: (_, animals,__) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Routes.farms.navigator(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: Text(context.read<FarmsController>().farmSelected?.name ?? ''),
          ),
          body: Column(
            children: [
              Container(color: Colors.white,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(5),
                  child: const Text('Animais da Fazenda', style: TextStyle(color: Colors.grey),)
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: FutureBuilder<List<AnimalModel>>(
                    future: context.read<AnimalsController>().getListAnimals(
                        context.read<FarmsController>().farmSelected?.id ?? 0
                    ),
                    builder: (_, snapshot){
                      Widget resultado = Container();

                      switch( snapshot.connectionState ){
                        case ConnectionState.none :
                        case ConnectionState.waiting :
                          resultado = const Center(child: CircularProgressIndicator());
                          break;
                        case ConnectionState.active :
                        case ConnectionState.done :
                          if( snapshot.hasError ){
                            resultado = GestureDetector(
                                child: const Icon(Icons.autorenew_outlined, size: 70,),
                                onTap: (){
                                  setState(() {});
                                }
                            );
                          }else if(snapshot.data != null && snapshot.data!.isNotEmpty) {
                            final data = snapshot.data!;
                            context.read<FarmsController>().updateNumAnimals(data.length);
                            resultado = ListView(
                              children: data.map((e) =>
                                  Dismissible(
                                    key: ValueKey<int>(e.id ?? 0),
                                    background: Container(
                                      color: Colors.red,
                                      alignment: Alignment.centerRight,
                                      padding: const EdgeInsets.only(right: 15),
                                      child: const Icon(CupertinoIcons.trash, color: Colors.white,size: 40,),
                                    ),
                                    direction: DismissDirection.endToStart,
                                    confirmDismiss: (DismissDirection direction) async {
                                      bool isDelete = false;
                                      await CustomAlert.custom(context,
                                          title: 'Deseja excluir este animal?',
                                          textCancel: 'Cancelar',
                                          textConfirm: 'Confirmar',
                                          confirm: () async {
                                            isDelete = await context.read<AnimalsController>().deleteAnimal(e.id ?? 0);
                                            if(isDelete){
                                              CustomSnackbar.sucess(text: 'Animal excluido com sucesso!', context: context);
                                              context.read<FarmsController>().updateNumAnimals(data.length - 1);
                                            }else{
                                              CustomSnackbar.error(text: 'Não foi possivel excluir o Animal!', context: context);
                                            }
                                          }
                                      );
                                      return isDelete;
                                    },
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 0.5,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      child: ListTile(
                                        title: Text(e.name,
                                          style: const TextStyle(fontWeight: FontWeight.bold),),
                                        subtitle: Text(e.tag),
                                        trailing: const Icon(Icons.pets_sharp),
                                      ),
                                    ),
                                  )
                              ).toList(),
                            );
                          }else{
                            context.read<FarmsController>().updateNumAnimals(0);
                            resultado = const Center(
                              child: Text('Não possui Animais Cadastrados'),
                            );
                          }
                          break;
                      }
                      return resultado;

                    },
                  ),
                ),
              )
            ],
          ),

          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add, color: Colors.white,),
            onPressed: () {
              Routes.addAnimals.navigator(context);
            },
          ),
        );
      }
    );
  }
}
