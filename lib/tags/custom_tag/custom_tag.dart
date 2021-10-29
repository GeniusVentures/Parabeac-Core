import 'package:directed_graph/directed_graph.dart';
import 'package:parabeac_core/controllers/main_info.dart';
import 'package:parabeac_core/generation/generators/import_generator.dart';
import 'package:parabeac_core/generation/generators/pb_generator.dart';
import 'package:parabeac_core/generation/generators/plugins/pb_plugin_node.dart';
import 'package:parabeac_core/generation/generators/util/pb_input_formatter.dart';
import 'package:parabeac_core/generation/generators/value_objects/file_structure_strategy/commands/write_symbol_command.dart';
import 'package:parabeac_core/generation/generators/value_objects/file_structure_strategy/file_ownership_policy.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/interfaces/pb_injected_intermediate.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_constraints.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/pb_shared_instance.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/pb_shared_master_node.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/child_strategy.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_context.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_intermediate_node_tree.dart';
import 'package:parabeac_core/tags/custom_tag/custom_tag_bloc_generator.dart';
import 'package:uuid/uuid.dart';
import 'package:recase/recase.dart';

class CustomTag extends PBTag implements PBInjectedIntermediate {
  @override
  String semanticName = '<custom>';

  CustomTag(
    String UUID,
    Rectangle3D frame,
    String name, {
    PBIntermediateConstraints constraints,
  }) : super(
          UUID,
          frame,
          name,
          contraints: constraints,
        ) {
    generator ??= _getGenerator();
    childrenStrategy = TempChildrenStrategy('child');
  }

  /// Function that examines the configuration and assigns a generator
  /// to `this` [CustomTag] and assigns it a State management generator
  PBGenerator _getGenerator() {
    if (MainInfo().configuration.stateManagement.toLowerCase() == 'bloc') {
      return CustomTagBlocGenerator();
    }
    return CustomTagGenerator();
  }

  @override
  void extractInformation(PBIntermediateNode incomingNode) {}

  @override
  PBTag generatePluginNode(Rectangle3D frame, PBIntermediateNode originalRef,
      PBIntermediateTree tree) {
    return CustomTag(
      null,
      frame,
      originalRef.name.replaceAll('<custom>', '').pascalCase + 'Custom',
      constraints: originalRef.constraints.clone(),
    );
  }

  /// Handles `iNode` to convert into a [CustomTag].
  ///
  /// Returns the [PBIntermediateNode] that should go into the [PBIntermediateTree]
  PBIntermediateNode handleIntermediateNode(
    PBIntermediateNode iNode,
    PBIntermediateNode parent,
    CustomTag tag,
    PBIntermediateTree tree,
  ) {
    iNode.name = iNode.name.replaceAll('<custom>', '');

    // If `iNode` is [PBSharedMasterNode] we need to place the [CustomEgg] betweeen the
    // [PBSharedMasterNode] and the [PBSharedMasterNode]'s children. That is why we are returing
    // `iNode` at the end.
    if (iNode is PBSharedMasterNode) {
      // TODO: temporal fix, uncomment later
      // tree.addEdges(
      //     newTag, tree.childrenOf(iNode).cast<Vertex<PBIntermediateNode>>());

      // tree.replaceChildrenOf(iNode, [tag]);
      return iNode;
    } else if (iNode is PBSharedInstanceIntermediateNode) {
      iNode.parent = parent;

      tree.replaceNode(iNode, tag);

      tree.addEdges(tag, [iNode]);

      return tag;
    } else {
      // [iNode] needs a parent and has not been added to the [tree] by [tree.addEdges]
      iNode.parent = parent;
      // If `iNode` has no children, it likely means we want to wrap `iNode` in [CustomEgg]
      if (tree.childrenOf(iNode).isEmpty) {
        /// Wrap `iNode` in `newTag` and make `newTag` child of `parent`.
        tree.removeEdges(iNode.parent, [iNode]);
        tree.addEdges(tag, [iNode]);
        tree.addEdges(parent, [tag]);
        return tag;
      }
      tree.replaceNode(iNode, tag, acceptChildren: true);

      return tag;
    }
  }
}

class CustomTagGenerator extends PBGenerator {
  /// Variable that dictates in what directory the tag will be generated.
  static const DIRECTORY_GEN = 'controller/tag';

  @override
  String generate(PBIntermediateNode source, PBContext context) {
    var children = context.tree.childrenOf(source);
    var titleName = PBInputFormatter.formatLabel(
      source.name,
      isTitle: true,
      destroySpecialSym: true,
    );
    var cleanName = PBInputFormatter.formatLabel(source.name.snakeCase);

    // TODO: correct import
    context.managerData.addImport(FlutterImport(
      '$DIRECTORY_GEN/$cleanName.dart',
      MainInfo().projectName,
    ));
    context.configuration.generationConfiguration.fileStructureStrategy
        .commandCreated(WriteSymbolCommand(
            Uuid().v4(), cleanName, customBoilerPlate(titleName),
            relativePath: '$DIRECTORY_GEN',
            symbolPath: 'lib',
            ownership: FileOwnership.DEV));

    if (source is CustomTag) {
      return '''
        $titleName(
          child: ${children[0].generator.generate(children[0], context)}
        )
      ''';
    }
    return '';
  }

  String customBoilerPlate(String className) {
    return '''
      import 'package:flutter/material.dart';

      class $className extends StatefulWidget{
        final Widget child;
        $className({Key key, this.child}) : super (key: key);

        @override
        _${className}State createState() => _${className}State();
      }

      class _${className}State extends State<$className> {
        @override
        Widget build(BuildContext context){
          return widget.child;
        }
      }
      ''';
  }
}
