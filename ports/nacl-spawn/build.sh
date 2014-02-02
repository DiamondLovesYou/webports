#!/bin/bash
# Copyright (c) 2014 The Native Client Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

ConfigureStep() {
  MakeDir ${BUILD_DIR}
  cp -rf ${START_DIR}/* ${BUILD_DIR}
}

BuildStep() {
  MAKE_TARGETS="libcli_main.a libnacl_spawn.a"
  if [ "${NACL_GLIBC}" = "1" ]; then
    NACLPORTS_CXXFLAGS+=" -fPIC"
    MAKE_TARGETS+=" libnacl_spawn.so test"
  fi
  SDKBuildSystemBuildStep
}

InstallStep() {
  cp libnacl_spawn.a ${NACLPORTS_LIBDIR}
  if [[ "${NACL_GLIBC}" != "0" ]]; then
    cp libnacl_spawn.so ${NACLPORTS_LIBDIR}
  fi
  cp libcli_main.a ${NACLPORTS_LIBDIR}
}