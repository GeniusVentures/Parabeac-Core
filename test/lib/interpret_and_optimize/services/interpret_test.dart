import 'dart:io';
import 'dart:math';

import 'package:parabeac_core/controllers/interpret.dart';
import 'package:parabeac_core/controllers/main_info.dart';
import 'package:parabeac_core/input/sketch/entities/layers/artboard.dart';
import 'package:parabeac_core/input/sketch/entities/layers/group.dart';
import 'package:parabeac_core/input/sketch/entities/layers/sketch_text.dart';
import 'package:parabeac_core/input/sketch/entities/objects/frame.dart';
import 'package:parabeac_core/input/sketch/helper/sketch_page.dart';
import 'package:parabeac_core/input/sketch/helper/sketch_project.dart';
import 'package:parabeac_core/input/sketch/helper/sketch_screen.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/inherited_container.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/layouts/temp_group_layout_node.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pb_intermediate_node.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_configuration.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_context.dart';
import 'package:parabeac_core/interpret_and_optimize/helpers/pb_project.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:parabeac_core/interpret_and_optimize/entities/inherited_scaffold.dart';

class MockProject extends Mock implements SketchProject {}

class MockPage extends Mock implements SketchPage {}

class MockScreen extends Mock implements SketchScreen {}

class MockArtboard extends Mock implements Artboard {
  @override
  Future<PBIntermediateNode> interpretNode(PBContext currentContext) {
    return Future.value(InheritedScaffold(
      this,
      currentContext: currentContext,
      name: name,
      isHomeScreen: isFlowHome,
    ));
  }
}

class MockGroup extends Mock implements Group {
  @override
  Future<PBIntermediateNode> interpretNode(PBContext currentContext) =>
      Future.value(TempGroupLayoutNode(this, currentContext, name,
          topLeftCorner: Point(boundaryRectangle.x, boundaryRectangle.y),
          bottomRightCorner: Point(
              boundaryRectangle.x + boundaryRectangle.width,
              boundaryRectangle.y + boundaryRectangle.height)));
}

class MockContainer extends Mock implements SketchText {
  @override
  Future<PBIntermediateNode> interpretNode(PBContext currentContext) =>
      Future.value(InheritedContainer(
        this,
        Point(boundaryRectangle.x, boundaryRectangle.y),
        Point(boundaryRectangle.x + boundaryRectangle.width,
            boundaryRectangle.y + boundaryRectangle.height),
        name,
        currentContext: currentContext,
      ));
}

void main() {
  MockProject project;
  MockPage page;
  MockScreen screen;
  MockArtboard artboard;
  MockGroup mockGroup;
  MockContainer container;
  group('Interpret test', () {
    setUp(() {
      Interpret().init(
        '${Directory.current.path}/test/lib/interpret_and_optimize/services',
        PBConfiguration.genericConfiguration(),
      );

      MainInfo().configurationType = 'default';

      project = MockProject();
      page = MockPage();
      screen = MockScreen();
      artboard = MockArtboard();
      mockGroup = MockGroup();
      container = MockContainer();

      when(project.pages).thenReturn([page]);
      when(page.getPageItems()).thenReturn([screen]);
      when(screen.AITree).thenReturn(artboard);
      when(artboard.children).thenReturn([mockGroup]);

      when(artboard.isVisible).thenReturn(true);
      when(artboard.isFlowHome).thenReturn(true);
      when(mockGroup.isVisible).thenReturn(true);
      when(container.isVisible).thenReturn(true);

      when(artboard.name).thenReturn('testArtboard');
      when(mockGroup.name).thenReturn('testGroup');
      when(container.name).thenReturn('testContainer');

      when(artboard.type).thenReturn('artboard');
      when(mockGroup.type).thenReturn('group');
      when(container.type).thenReturn('text');

      when(page.name).thenReturn('testName');
      when(mockGroup.children).thenReturn([container]);
      when(mockGroup.boundaryRectangle).thenReturn(Frame(
        x: 100,
        y: 100,
        width: 200,
        height: 200,
      ));
      when(artboard.boundaryRectangle).thenReturn(Frame(
        x: 100,
        y: 100,
        width: 200,
        height: 200,
      ));
      when(container.boundaryRectangle).thenReturn(Frame(
        x: 100,
        y: 100,
        width: 200,
        height: 200,
      ));
    });
    test('', () async {
      var mainTree = await Interpret()
          .interpretAndOptimize(project, 'projectName', 'projectPath');
      expect(mainTree != null, true);
      expect(mainTree is PBProject, true);
      expect(mainTree.forest.first.rootNode is InheritedScaffold, true);
      // expect(mainTree.forest.first.rootNode.child is InjectedAlign, true);

      ///TODO: Check the type of the leaf node
      expect(mainTree.forest.first.rootNode.child.child != null, true);
    });
  });
}
