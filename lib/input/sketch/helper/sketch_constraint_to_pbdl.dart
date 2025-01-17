// import 'package:parabeac_core/interpret_and_optimize/entities/subclasses/pbdl_constraints.dart';

// PBDLConstraints convertSketchConstraintToPBDLConstraint(
//     int resizingConstraint) {
//   var constraints = sketchConstraintBitFieldToPBDLMap[resizingConstraint];
//   if (constraints == null) {
//     print(
//         '[PBDL Conversion Error] We don\' support this `resizingConstraint` from Sketch.');
//   }
//   return constraints;
// }

// /// A map that references the Sketch Constraint Bitmap to PBDL Constraints.
// /// For reference: https://www.notion.so/parabeac/2ff2c018c44644d9bba6bc4567f249c2?v=5c9a4978c96b4ee1aab8b219e3a2c006
// var sketchConstraintBitFieldToPBDLMap = {
//   63: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: false),
//   18: PBDLConstraints(
//       pinLeft: true,
//       pinRight: true,
//       pinTop: true,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: false),
//   31: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: false),
//   27: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: false),
//   19: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: true,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: false),
//   22: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: true,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: false),
//   30: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: false),
//   26: PBDLConstraints(
//       pinLeft: true,
//       pinRight: true,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: false),
//   23: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: true,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: false),
//   59: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: false),
//   51: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: false),
//   50: PBDLConstraints(
//       pinLeft: true,
//       pinRight: true,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: false),
//   58: PBDLConstraints(
//       pinLeft: true,
//       pinRight: true,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: false),
//   55: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: false),
//   54: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: false),
//   62: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: false),
//   61: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: true),
//   29: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: true),
//   25: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: true),
//   17: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: true,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: true),
//   57: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: true),
//   49: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: true),
//   53: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: true),
//   52: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: true),
//   20: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: true,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: true),
//   60: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: true),
//   28: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: false,
//       fixedWidth: true),
//   21: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: true,
//       pinBottom: true,
//       fixedHeight: false,
//       fixedWidth: true),
//   47: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: false),
//   15: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: false),
//   11: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: false),
//   43: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: false),
//   35: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: true,
//       fixedWidth: false),
//   34: PBDLConstraints(
//       pinLeft: true,
//       pinRight: true,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: true,
//       fixedWidth: false),
//   39: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: true,
//       fixedWidth: false),
//   38: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: true,
//       fixedWidth: false),
//   46: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: false),
//   14: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: false),
//   10: PBDLConstraints(
//       pinLeft: true,
//       pinRight: true,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: false),
//   42: PBDLConstraints(
//       pinLeft: true,
//       pinRight: true,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: false),
//   45: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: true),
//   13: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: true),
//   9: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: true),
//   41: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: true),
//   33: PBDLConstraints(
//       pinLeft: true,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: true,
//       fixedWidth: true),
//   37: PBDLConstraints(
//       pinLeft: false,
//       pinRight: false,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: true,
//       fixedWidth: true),
//   36: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: false,
//       pinBottom: true,
//       fixedHeight: true,
//       fixedWidth: true),
//   44: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: false,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: true),
//   12: PBDLConstraints(
//       pinLeft: false,
//       pinRight: true,
//       pinTop: true,
//       pinBottom: false,
//       fixedHeight: true,
//       fixedWidth: true)
// };
