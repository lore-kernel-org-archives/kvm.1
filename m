Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9011C84CB
	for <kvm@vger.kernel.org>; Thu,  3 Sep 2026 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788395380; cv=none; b=YZW+i3M/XMIVFoPCeimS4LAA7w9r3nHJjvaLWj1tmL5f3aUj8u+j8ShBpW7Q9ITLzM/YqNTKkQOi0an6XxJC1zu46sSgcNte4RGoOqQVM982rbNZP4qBjO1hxqUpDRS2pA0CUjRhTkWNHXg6K9R6RWDJOs36kJ8kbIQ+9kmTOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788395380; c=relaxed/simple;
	bh=zknjuecCDJxzIyAgZM0rdMtP4y5bJzzI3TID4000CWI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EcMqmtJdJ0MquTt/C/z63gTfqG7ZjQLmiuuld9fyWa6lCv2G1geLuq7KFvC/+L41VyB5Do3vB2qK2Ny5rtGGUbmLy0lsQ45mbVLptGKSzv+G1q5x/7tT5ka9hQ5G4ofp+FzM3h2S/avDe1xi3XNWfDUIIokaOtQBfhbwlDCri5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAOJga1G; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAOJga1G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788395378; x=1819931378;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=zknjuecCDJxzIyAgZM0rdMtP4y5bJzzI3TID4000CWI=;
  b=gAOJga1G7mHJfACq+8X4G56vn/SrjIfTjUfqdRwd+QqZBOWVkZ/0rafI
   JMz9qctsngWi+IxXagAXvdrBNs1Fu7cRKNGpRK8ND1XqhSWf6GwNYha7W
   dbzSvmqmHsXGvxSMSryH01roRjsKwjTr4fdP6EUZkiwgUaXvnmwkphRV1
   xXaqipNQxhRrfnungqyRd0SHurD1ciLQD6Z3GTE4VscSLP4VEZHtrXbj/
   XBlh+G33hvGT0ztJnbCmHzKPrwp+ebv5cVenFy2LJpAJSa2RZNJm7tU77
   e5N8dNfnQkphDAXbDREvzR20L7f/N92aPbkbj0uLn1hRZ+7yVJE5xKjso
   Q==;
X-CSE-ConnectionGUID: 2xEsCwRWTl2CDvT8X63S4g==
X-CSE-MsgGUID: 6avPcSfRQq6nKxpiypd0qA==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="106387938"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="106387938"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 17:29:37 -0700
X-CSE-ConnectionGUID: olpGPJRiTj6Ekv6vTGKGeQ==
X-CSE-MsgGUID: +R5vuPaDRoyTNu7qiE8XXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="293062027"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 17:29:35 -0700
Date: Thu, 3 Sep 2026 08:29:32 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Sean Christopherson <seanjc@google.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, Yosry Ahmed <yosry@kernel.org>,
	kvm@vger.kernel.org, yi1.lai@intel.com
Subject: [sean-jc:x86/evmcs_vmptrldst] [KVM]  7fecb27e8d: bunch of
 kselftests.kvm failures
Message-ID: <202609030248.b516759d-lkp@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



Hello,

kernel test robot noticed "kselftests.kvm.hyperv_evmcs.fail" on:

commit: 7fecb27e8d353adda91989eb01b3ae200b846a42 ("KVM: selftests: Always assert that vmwrite() succeeds") https://github.com/sean-jc/linux x86/evmcs_vmptrldst

in testcase: kselftests
version: kselftests-x86_64-f5098b6bae76-1_20260727
with following parameters:

	group: kvm

config: x86_64-rhel-9.4-kselftests
compiler: gcc-14
test machine: 16 threads Intel(R) Core(TM) i7-13620H (Raptor Lake) with 32G memory

If you fix the issue in a separate patch/commit (i.e. not just a new version of the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yi1.lai@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202609030248.b516759d-lkp@intel.com

The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20260903/202609030248.b516759d-lkp@intel.com

Detailed log:
# selftests: kvm: evmcs_smm_controls_test
# Random seed: 0x7ad5b4f9
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=5240 tid=5240 errno=4 - Interrupted system call
#      1	0x0000000000412f61: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000406f86: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402cc6: main at evmcs_smm_controls_test.c:93
#      5	0x00007f0a85d39ca7: ?? ??:0
#      6	0x00007f0a85d39d64: ?? ??:0
#      7	0x00000000004030c0: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 16 selftests: kvm: evmcs_smm_controls_test # exit=254
# selftests: kvm: hyperv_evmcs
# Random seed: 0x28ca1a80
# Running L1 which uses EVMCS to run L2
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=5437 tid=5437 errno=4 - Interrupted system call
#      1	0x0000000000414021: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000408046: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402d93: main at hyperv_evmcs.c:272
#      5	0x00007fc6db76aca7: ?? ??:0
#      6	0x00007fc6db76ad64: ?? ??:0
#      7	0x0000000000403060: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 23 selftests: kvm: hyperv_evmcs # exit=254
# selftests: kvm: nested_close_kvm_test
# Random seed: 0xe2dada4
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=5827 tid=5827 errno=4 - Interrupted system call
#      1	0x0000000000412be1: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000406c06: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402c6f: main at nested_close_kvm_test.c:82
#      5	0x00007f4fd2c0fca7: ?? ??:0
#      6	0x00007f4fd2c0fd64: ?? ??:0
#      7	0x0000000000402e40: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 34 selftests: kvm: nested_close_kvm_test # exit=254
# selftests: kvm: nested_dirty_log_test
# Random seed: 0x7c40823f
# Nested TDP: disabled
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=5856 tid=5856 errno=4 - Interrupted system call
#      1	0x0000000000413361: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000407386: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x000000000040321f: test_dirty_log at nested_dirty_log_test.c:260
#      5	0x0000000000402c00: main at nested_dirty_log_test.c:283
#      6	0x00007fbd8e249ca7: ?? ??:0
#      7	0x00007fbd8e249d64: ?? ??:0
#      8	0x0000000000402d10: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 35 selftests: kvm: nested_dirty_log_test # exit=254
# selftests: kvm: nested_exceptions_test
# Random seed: 0x7c40823f
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=5910 tid=5910 errno=4 - Interrupted system call
#      1	0x00000000004140a1: assert_on_unhandled_exception at processor.c:781
#      2	0x00000000004080c6: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402d1c: main at nested_exceptions_test.c:236
#      5	0x00007fee32f1bca7: ?? ??:0
#      6	0x00007fee32f1bd64: ?? ??:0
#      7	0x00000000004030b0: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 37 selftests: kvm: nested_exceptions_test # exit=254
# selftests: kvm: nested_invalid_cr3_test
# Random seed: 0x7c40823f
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=5942 tid=5942 errno=4 - Interrupted system call
#      1	0x0000000000412ee1: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000406f06: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402c7a: main at nested_invalid_cr3_test.c:92
#      5	0x00007f8e4f5e8ca7: ?? ??:0
#      6	0x00007f8e4f5e8d64: ?? ??:0
#      7	0x0000000000402e60: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 38 selftests: kvm: nested_invalid_cr3_test # exit=254
# selftests: kvm: nested_tdp_fault_test
# Random seed: 0x29ff5ccd
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=5996 tid=5996 errno=4 - Interrupted system call
#      1	0x0000000000413361: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000407386: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000403792: run_test at nested_tdp_fault_test.c:275
#      5	0x0000000000402c09: main at nested_tdp_fault_test.c:302
#      6	0x00007f0aeb9e0ca7: ?? ??:0
#      7	0x00007f0aeb9e0d64: ?? ??:0
#      8	0x0000000000402d30: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 40 selftests: kvm: nested_tdp_fault_test # exit=254
# selftests: kvm: nested_tsc_adjust_test
# Random seed: 0x29ff5ccd
# IA32_TSC_ADJUST is -4294971814 (-1 * TSC_ADJUST_VALUE + -4518).
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=6025 tid=6025 errno=4 - Interrupted system call
#      1	0x0000000000413061: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000407086: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402c80: main at nested_tsc_adjust_test.c:139
#      5	0x00007feace2e2ca7: ?? ??:0
#      6	0x00007feace2e2d64: ?? ??:0
#      7	0x0000000000402ea0: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 41 selftests: kvm: nested_tsc_adjust_test # exit=254
# selftests: kvm: nested_tsc_scaling_test
# Random seed: 0x29ff5ccd
# L1's scale down factor is: 7
# L2's scale up factor is: 4
# real TSC frequency is around: 2918711892
# L1's TSC frequency is around: 417032779
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=6057 tid=6057 errno=4 - Interrupted system call
#      1	0x00000000004147e1: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000408806: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000403e31: main at nested_tsc_scaling_test.c:199
#      5	0x00007f4446ebeca7: ?? ??:0
#      6	0x00007f4446ebed64: ?? ??:0
#      7	0x0000000000404130: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 42 selftests: kvm: nested_tsc_scaling_test # exit=254
# selftests: kvm: smm_test
# Random seed: 0x1392625a
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=7454 tid=7454 errno=4 - Interrupted system call
#      1	0x0000000000412f21: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000406f46: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402d4b: main at smm_test.c:137
#      5	0x00007f32887b2ca7: ?? ??:0
#      6	0x00007f32887b2d64: ?? ??:0
#      7	0x0000000000403000: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 53 selftests: kvm: smm_test # exit=254
# selftests: kvm: state_test
# Random seed: 0x17d47c3
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=7487 tid=7487 errno=4 - Interrupted system call
#      1	0x00000000004147e1: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000408806: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402cb2: main at state_test.c:281
#      5	0x00007f1838094ca7: ?? ??:0
#      6	0x00007f1838094d64: ?? ??:0
#      7	0x0000000000403610: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 54 selftests: kvm: state_test # exit=254
# timeout set to 120
# selftests: kvm: vmx_preemption_timer_test
# Random seed: 0x17d47c3
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=7523 tid=7523 errno=4 - Interrupted system call
#      1	0x0000000000413721: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000407746: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402c8b: main at vmx_preemption_timer_test.c:176
#      5	0x00007f5c8d197ca7: ?? ??:0
#      6	0x00007f5c8d197d64: ?? ??:0
#      7	0x00000000004032e0: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 55 selftests: kvm: vmx_preemption_timer_test # exit=254
# selftests: kvm: vmx_apic_access_test
# Random seed: 0x16490829
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=8014 tid=8014 errno=4 - Interrupted system call
#      1	0x00000000004133e1: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000407406: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402c6d: main at vmx_apic_access_test.c:94
#      5	0x00007fc6a12a7ca7: ?? ??:0
#      6	0x00007fc6a12a7d64: ?? ??:0
#      7	0x0000000000402ed0: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 70 selftests: kvm: vmx_apic_access_test # exit=254
# timeout set to 120
# selftests: kvm: vmx_apicv_updates_test
# Random seed: 0x3a977e6
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=8046 tid=8046 errno=4 - Interrupted system call
#      1	0x0000000000413361: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000407386: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402c8b: main at vmx_apicv_updates_test.c:129
#      5	0x00007f35dc7a6ca7: ?? ??:0
#      6	0x00007f35dc7a6d64: ?? ??:0
#      7	0x0000000000402ec0: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 71 selftests: kvm: vmx_apicv_updates_test # exit=254
# selftests: kvm: vmx_invalid_nested_guest_state
# Random seed: 0x3a977e6
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=8126 tid=8126 errno=4 - Interrupted system call
#      1	0x00000000004131a1: assert_on_unhandled_exception at processor.c:781
#      2	0x00000000004071c6: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402ef7: vcpu_run_to_io at vmx_invalid_nested_guest_state.c:69
#      5	0x0000000000403022: vm_create_and_run_l2 at vmx_invalid_nested_guest_state.c:96
#      6	0x000000000040304f: test_invalid_l2_guest_state at vmx_invalid_nested_guest_state.c:108
#      7	0x0000000000402beb: main at vmx_invalid_nested_guest_state.c:173
#      8	0x00007f8a1e522ca7: ?? ??:0
#      9	0x00007f8a1e522d64: ?? ??:0
#     10	0x0000000000402db0: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 74 selftests: kvm: vmx_invalid_nested_guest_state # exit=254
# selftests: kvm: triple_fault_event_test
# Random seed: 0x4e7569c4
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=8648 tid=8648 errno=4 - Interrupted system call
#      1	0x00000000004130a1: assert_on_unhandled_exception at processor.c:781
#      2	0x00000000004070c6: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402d22: main at triple_fault_event_test.c:85
#      5	0x00007f27d646aca7: ?? ??:0
#      6	0x00007f27d646ad64: ?? ??:0
#      7	0x0000000000403190: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 93 selftests: kvm: triple_fault_event_test # exit=254
# selftests: kvm: aperfmperf_test
# Random seed: 0x622713c7
# 
# ==== Test Assertion Failure ====
#   include/x86/vmx.h:434: __vmwrite(encoding, value)
#   pid=8724 tid=8724 errno=4 - Interrupted system call
#      1	0x0000000000413361: assert_on_unhandled_exception at processor.c:781
#      2	0x0000000000407386: _vcpu_run at kvm_util.c:1687
#      3	 (inlined by) vcpu_run at kvm_util.c:1698
#      4	0x0000000000402e04: main at aperfmperf_test.c:168
#      5	0x00007f032476dca7: ?? ??:0
#      6	0x00007f032476dd64: ?? ??:0
#      7	0x0000000000403340: _start at ??:?
#   vmwrite[0x0] = 0x0 hit VM-Fail
not ok 95 selftests: kvm: aperfmperf_test # exit=254

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

