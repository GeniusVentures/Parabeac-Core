import 'package:parabeac_core/input/sketch/entities/layers/symbol_instance.dart';
import 'package:parabeac_core/input/sketch/entities/style/shared_style.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_intermediate_group.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_intermediate_item.dart';

class PBIntermediateTree {
  String projectName;
  List<SharedStyle> sharedStyles = [];
  Map<String, SymbolInstance> sharedSymbols = {};
  PBIntermediateItem rootItem;
  List<PBIntermediateGroup> groups = [];
  PBIntermediateTree(this.projectName, this.sharedStyles, this.sharedSymbols);
}