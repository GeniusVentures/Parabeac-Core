import 'package:parabeac_core/generation/generators/pb_generator.dart';
import 'package:parabeac_core/generation/generators/util/pb_input_formatter.dart';
import 'package:parabeac_core/input/sketch/entities/style/shared_style.dart';
import 'package:parabeac_core/input/sketch/entities/style/style.dart';
import 'package:parabeac_core/input/sketch/entities/style/text_style.dart';
import 'package:parabeac_core/input/sketch/helper/symbol_node_mixin.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/inherited_bitmap.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/pb_shared_instance.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/pb_shared_master_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_symbol_storage.dart';
import 'package:parabeac_core/interpret_and_optimize/services/intermediate_node_searcher_service.dart';
import 'package:quick_log/quick_log.dart';
import 'package:parabeac_core/controllers/main_info.dart';

class PBSymbolInstanceGenerator extends PBGenerator {
  PBSymbolInstanceGenerator() : super();

  var log = Logger('Symbol Instance Generator');

  String genParameters(PBSharedInstanceIntermediateNode source, {String prepend}) {

    var buffer = StringBuffer();

    for (PBSharedParameterValue param in source.sharedParamValues ?? []) {
      switch (param.type) {
        case PBSharedInstanceIntermediateNode:
          PBIntermediateNode intNode = PBSymbolStorage().getSymbolInstance(param.value);
          intNode ??= PBSymbolStorage().getSharedMasterNodeBySymbolID(param.value);
          if (intNode != null) {
            buffer.write('${param.name}: ${intNode.name},');
            String siString = genParameters(intNode, prepend: intNode.name);
            buffer.write(', ${siString}');
          }
          break;
        case InheritedBitmap:
          buffer.write('${param.name}: ');
          var ovrName = SN_UUIDtoVarName[source.UUID +'/' + param.UUID + '_image'];
          if (ovrName != null) {
            buffer.write('${ovrName} ?? ');
          }
          buffer.write('\"assets/${param.value["_ref"]}\",');
          break;
        case TextStyle:
          buffer.write('${param.name}: ');
          var ovrName = SN_UUIDtoVarName[source.UUID +'/' + param.UUID + '_textStyle'];
          if (ovrName != null) {
            buffer.write('${ovrName} ?? ');
          }
          buffer.write('${SharedStyle_UUIDToName[param.value] ?? "TextStyle()"},');
          break;
        case Style:
          buffer.write('${param.name}: null'); // TODO: ${SharedStyle_UUIDToName[param.value] ?? "SharedStyle()"},');
          break;
        default:
          buffer.write('${param.name}: ');
          var ovrName = SN_UUIDtoVarName[source.UUID +'/' + param.UUID + '_stringValue'];
          if (ovrName != null) {
            buffer.write('${ovrName} ?? ');
          }
          buffer.write('\"${param.value}\",');
          break;

      }
    }

    return buffer.toString();

  }

  @override
  String generate(PBIntermediateNode source) {
    if (source is PBSharedInstanceIntermediateNode) {
      String method_signature = source.functionCallName;
      if (method_signature == null) {
          log.error(' Could not find master name on: $source');
          return 'Container(/** This Symbol was not found **/)';
      }
      method_signature = PBInputFormatter.formatLabel(method_signature,
          destroy_digits: false, space_to_underscore: false, isTitle: false);
      var buffer = StringBuffer();


      method_signature = method_signature[0].toLowerCase() +
          method_signature.substring(1, method_signature.length);

      buffer.write('LayoutBuilder( \n');
      buffer.write('  builder: (context, constraints) {\n');
      buffer.write('    return ');
      buffer.write(method_signature);
      buffer.write('(context, constraints, ');
      if (source.overrideValues.isNotEmpty) {
        source.generator.manager.addImport('package:${MainInfo().projectName}/document/shared_props.g.dart');
      }
      buffer.write(genParameters(source));
      // end of return function();
      buffer.write(');\n');
      // end of builder: (context, constraints) {
      buffer.write('}\n');
      // end of LayoutBuilder()
      buffer.write(')');
      return buffer.toString();
    }
  }
}
