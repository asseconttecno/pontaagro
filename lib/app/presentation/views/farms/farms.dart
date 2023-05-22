

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../config/routes.dart';
import '../../../config/theme_colors.dart';
import '../../controllers/farms_controller.dart';
import '../../widgets/custom_alert.dart';
import '../../widgets/custom_snackbar.dart';
import 'alert_add_farm.dart';

class FarmsView extends StatefulWidget {
  const FarmsView({Key? key}) : super(key: key);

  @override
  State<FarmsView> createState() => _FarmsViewState();
}

class _FarmsViewState extends State<FarmsView> {
  @override
  Widget build(BuildContext context) {


    return Consumer<FarmsController>(
      builder: (_, farms, __) {
        return Scaffold(
          appBar: AppBar(title: Text('Minhas Fazendas'),),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            children: farms.listFarms.map((e) =>
                Dismissible(
                  key: ValueKey<int>(e.id ?? 0),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(CupertinoIcons.trash, color: Colors.white,size: 40,),
                  ),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (DismissDirection direction) async {
                    CustomAlert.custom(context,
                        title: 'Deseja excluir essa fazenda\ne todos os animais?',
                        textCancel: 'Cancelar',
                        textConfirm: 'Confirmar',
                        confirm: () async {
                          final result = await farms.deleteFarm(e.id ?? 0);
                          if(result){
                            CustomSnackbar.sucess(text: 'Fazenda excluida com sucesso!', context: context);
                          }else{
                            CustomSnackbar.error(text: 'Não foi possivel excluir a fazenda!', context: context);
                          }
                        }
                    );
                    return false;
                  },
                  child: InkWell(
                    onTap: (){
                      farms.farmSelected = e;
                      Routes.animals.navigator(context);
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      child: ListTile(
                        title: Text(e.name, style: TextStyle(fontSize: 20), maxLines: 1,),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Animais'),
                            Text(e.numAnimals.toString(), style: TextStyle(fontSize: 18),),
                          ],
                        )
                      ),
                    ),
                  ),
                )
            ).toList(),
          ),

          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add, color: Colors.white,),
            onPressed: () {
              CustomAlert.custom(context,
                body: AlertAddFarmView()
              );
            },
          ),
        );
      }
    );
  }
}
