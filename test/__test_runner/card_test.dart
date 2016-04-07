// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library test_runner.vm_test_config;

import 'package:unittest/vm_config.dart';
import '../card_test.dart' as test;

/// Sets the VmConfiguration and then calls the original test file.
void main() {
  useVMConfiguration();
  test.main();
}
