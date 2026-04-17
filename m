Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A42FE056
	for <kvm@vger.kernel.org>; Fri, 17 Apr 2026 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411129; cv=none; b=E6cqGm3amJpfkCLbq9KX1JVy8f2C6YnJhuh/QxZq2s3kMxDnv14vX3ECsXk4ZbyLDffHs1e+LLtGXwGLaOnsivILo3KxCU4qUXWaWW1X7dwdc7AtxNVPfHnueCpYUy3ul/qBjf+hM5qu1tC005lbc1FLnLYQpTrFFS5lmzE8j9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411129; c=relaxed/simple;
	bh=PaJpXF4U4vVQBCA+RaqZridguVOUfkC+wsUvXozaJ1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BvFWSTTAXWyqBPosqo/RniW3RB7adxb/PyZV/SRmREt9Tiq+gnk8ccEK1F8zbBDsQ0dI6aa7a4csl10IQRvD4Lj71AOX7DUnXL5D5/Us28DLJs8o76GFzMI4MtTuD7eOv12B5fFjqxC016dgqcoH/Qezjau6BXwlpi3pJN2vgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cFSPFDzc; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cFSPFDzc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776411127; x=1807947127;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PaJpXF4U4vVQBCA+RaqZridguVOUfkC+wsUvXozaJ1o=;
  b=cFSPFDzc6Kpr2nnIeUFECnGOsERDFdQrnSuPOZ9HAfWvl//g8D/7Y4hg
   0fVUX7lKCGnWb+OLtDbjyCdjam5uoqKpJOq6f3beDEvqw5rAYFgDiIbhU
   +6tx44k/IRrx5Dn+iyBkC1FZo3oBhhlWAtmujuvWxJTDmsv+0FSeePW0K
   SV8K1BQfnvwCMvW0WjTcSC2LtFGdnKA47N5X3G8g5k6mPTUNt6QKQwUb+
   DvDJT5N0G6DZeC9qkS/7kKwg4vxqQh2IUFbhelGDd9akxopX6r5MSgQ0c
   Pn2yQhI8AiHDzIrFLs5G/Q5P+8K5WVvsnpP0ILOIgEocz59uUq429eQXt
   w==;
X-CSE-ConnectionGUID: K63C+ZIBSrmBjV/M7KNmZg==
X-CSE-MsgGUID: V8ElSP3NSByh5mFDIoaZIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="100070114"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="100070114"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:06 -0700
X-CSE-ConnectionGUID: /mej1juLR0aF6sNUsMBMMw==
X-CSE-MsgGUID: dDRSaQ1ARJ6XbBSnjpfEGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="226284817"
Received: from litbin-desktop.sh.intel.com ([10.239.159.60])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 00:32:01 -0700
From: Binbin Wu <binbin.wu@linux.intel.com>
To: kvm@vger.kernel.org
Cc: pbonzini@redhat.com,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	xiaoyao.li@intel.com,
	chao.gao@intel.com,
	kai.huang@intel.com,
	binbin.wu@linux.intel.com
Subject: [RFC PATCH 00/27] KVM: x86: Add a paranoid mode for CPUID verification
Date: Fri, 17 Apr 2026 15:35:43 +0800
Message-ID: <20260417073610.3246316-1-binbin.wu@linux.intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This RFC series is to allow public capture of feedback from TDX
developers before we have too much internal conversations on it and to
initiate code review of Sashiko. It is not yet intended for review by
KVM maintainers. Sean and Paolo, please feel free to ignore this version.

Originally, we had issues on TDX when a new hardware feature, which is a
host state clobbering feature, is supported by new TDX modules/platforms.
A host state clobbering feature requires KVM to save and restore the
feature's related MSR(s) on host/guest transitions; otherwise, if the
feature is used by TDs, the host state will be corrupted, leading to
unexpected behavior on the host.

Currently KVM hardcodes a deny list for unsupported host clobbering
features for TDX, i.e. HLE, RTM and WAITPKG. However, KVM can't keep a
list of bits that it may not know about (e.g. the upcoming FRED support
in TDX).

We had been working internally to propose a TDX specific solution to
solve the host state clobbering feature issue. But during a PUCK meeting,
Sean mentioned that KVM had a more permissive CPUID configuration
interface than desired and there were problems due to it in the past for
normal VMs as well. Sean suggested that KVM should introduce a more
paranoid mode to check CPUID from userspace for VMs in general, as well
as an opt-in interface for userspace. And TDX should use the
infrastructure to enforce paranoid mode non-optionally.

This RFC patch series adds a paranoid CPUID verification mode for KVM on
x86, where KVM must be explicitly aware of every CPUID feature exposed
to the guest. When the CPUID paranoid mode is opted-in by userspace or
enforced, KVM will reject any unknown or unsupported feature from
userspace. And it starts to enforce paranoid CPUID verification for TDX.

This patch series touches a lot of lines and involves many subtle CPUID
details. We may not expect reviews on these CPUID leaf specific details
yet, but feedback is welcome on the framework to build the CPUID overlays
and how paranoid CPUID verification is implemented.

The changes are only tested on Intel platforms. Compile-tested only for
SVM.

The series is organized in following parts:
===========================================
- Patch 1 ~ 2:  Cleanup patches.

- Patch 3 ~ 11: Construct CPUID overlays
  This part extends kvm_cpu_caps[] into a 2D array indexed by an "overlay"
  dimension (CPUID_OL_DEFAULT, CPUID_OL_SVM, CPUID_OL_TDX), allowing
  each overlay to maintain its own set of supported CPUID features. 
  Having separate overlays for VMX and TDX helps handle cases where
  KVM's support for certain features differs on Intel-compatible
  platforms, e.g., HLE, RTM and WAITPKG are not supported for TDX in
  KVM. There will be new host state clobbering features like this in
  the future.
  Having separate overlays for VMX and SVM helps handle cases where a
  common feature has support on one vendor but not the other. Setting
  the support in common code requires additional handling in vendor
  specific code, e.g., SVM code needs to clear IBT, BUS_LOCK_DETECT
  and MSR_IMM.
  More overlays could be added in the future if needed.

  KVM_GET_SUPPORTED_CPUID and KVM_GET_EMULATED_CPUID are also promoted
  to VM-scoped IOCTLs so that userspace can query per-VM-type CPUID
  capabilities. CPUID overlays are a KVM internal concept; the overlay is
  decided by VM type and/or platform vendor.

- Patch 12 ~ 19: Build allowed CPUID values for different overlays
  This part builds a comprehensive table of allowed CPUID values covering
  the basic, extended, Centaur, and KVM paravirt CPUID ranges.
  For each CPUID output register, the validation follows one of three
  rules:
  1. Ignored: the register is added to the ignored set and KVM skips
     validation of the userspace-provided value.
  2. Mask/value check: a new KVM-only CPUID leaf enum is defined with a
     corresponding reverse_cpuid[] entry, and an allowed mask or fixed
     value is initialized per-overlay.
  3. Zero check: for reserved registers or registers where no bits are
     supported, userspace input is checked against zero.

- Patch 20 ~ 25: Implement paranoid CPUID verification
  This part adds CPUID paranoid verification to reject userspace CPUID
  configurations that set unsupported or unknown bits when paranoid mode
  is enabled for a VM. 
  Also, it adds the opt-in interface KVM_CAP_X86_CPUID_PARANOID for
  userspace and unconditionally enforces CPUID paranoid mode for TDs.

- Patch 26 ~ 27: Remove the hardcoded filter for TDX.
  This part removes the hardcoded deny list for unsupported host
  clobbering features for TDX, and relies on the allowed mask for the TDX
  overlay to filter and check generically.

Opens:
======
- CPUID overlays VS. open-code checks for specific features in vendor
  specific callbacks.
  Open-code checks for specific features in vendor callback will have
  less code changes, however, it tightly couples normal VM feature
  enablement with TDX. If a new host-state-clobbering feature is added
  for normal VMs, the developer has to remember to update the TDX filter
  list(s). Or when a common x86 feature is added for only VMX/SVM, the
  developer has to remember to clear the bit for the other vendor.
  Relying solely on mailing list reviews to catch these omissions may be
  more error-prone than using an overlay approach.

- This patch series uses a 2D array in common KVM code to accommodate KVM
  CPUID capabilities for different overlays. This avoids adding init ops
  and runtime ops to call into vendor modules for a few reasons:
  1. kvm_ops_update() is called after ops->hardware_setup(), inside which
     the KVM CPU capabilities are built, runtime x86 ops can not be
     called. Need some workaround to allow it.
  2. These inputs to build the KVM CPU capabilities for overlays are from
     the common KVM code or via the common KVM code helpers, which make
     the callbacks in vendor module just duplication of similar tedious
     code.
  But conceptually, putting vendor-specific overlay data in the related
  vendor module is cleaner.

- This patch combines vCPU capability initialization and paranoid CPUID
  verification. It refactors the vCPU capability initialization to iterate
  over userspace CPUID entries rather than reverse_cpuid[], combining the
  paranoid check with capability setup. The purpose is to avoid iterating
  over CPUID entries twice for vCPU capability initialization and paranoid
  check separately. However, this can change the code for vCPU capability
  initialization a bit even when paranoid mode is disabled. It could be
  separated if we want to minimize the change for the non-paranoid mode.

- This patch series checks a CPUID register if part of the 32-bit range
  is reserved. I am not sure this is necessary for all cases. It could be
  simplified if we believe these reserved bits won’t cause problems
  according to the property of the CPUID register, so that they can be
  treated as ignored registers.

Binbin Wu (27):
  KVM: x86: Fix emulated CPUID features being applied to wrong sub-leaf
  KVM: x86: Reorder the features for CPUID 7
  KVM: x86: Add definitions for CPUID overlays
  KVM: x86: Extend F() and its variants for CPUID overlays
  KVM: x86: Extend kvm_cpu_cap_{set/clear}() to configure overlays
  KVM: x86: Populate TDX CPUID overlay with supported feature bits
  KVM: x86: Support KVM_GET_{SUPPORTED,EMULATED}_CPUID as VM scope
    ioctls
  KVM: x86: Thread @kvm to KVM CPU capability helpers
  KVM: x86: Use overlays of KVM CPU capabilities
  KVM: x86: Use vendor-specific overlay flags instead of F_CPUID_DEFAULT
  KVM: SVM: Drop unnecessary clears of unsupported common x86 features
  KVM: x86: Split KVM CPU cap leafs into two parts
  KVM: x86: Add a helper to initialize CPUID multi-bit fields
  KVM: x86: Add a helper to init multiple feature bits based on raw
    CPUID
  KVM: x86: Add infrastructure to track CPUID entries ignored in
    paranoid mode
  KVM: x86: Init allowed masks for basic CPUID range in paranoid mode
  KVM: x86: Init allowed masks for extended CPUID range in paranoid mode
  KVM: x86: Handle Centaur CPUID leafs in paranoid mode
  KVM: x86: Track KVM PV CPUID features for paranoid mode
  KVM: x86: Add per-VM flag to track CPUID paranoid mode
  KVM: x86: Make kvm_vcpu_after_set_cpuid() return an error code
  KVM: x86: Verify userspace CPUID inputs in paranoid mode
  KVM: x86: Account for runtime CPUID features in paranoid mode
  KVM: x86: Skip paranoid CPUID check for KVM PV leafs when base is
    relocated
  KVM: x86: Add new KVM_CAP_X86_CPUID_PARANOID
  KVM: x86: Add a helper to query the allowed CPUID mask
  KVM: TDX: Replace hardcoded CPUID filtering with the allowed mask

 Documentation/virt/kvm/api.rst  |   18 +
 arch/x86/include/asm/kvm_host.h |   75 +-
 arch/x86/kvm/cpuid.c            | 1224 +++++++++++++++++++++----------
 arch/x86/kvm/cpuid.h            |  118 ++-
 arch/x86/kvm/reverse_cpuid.h    |   82 +++
 arch/x86/kvm/svm/nested.c       |    4 +-
 arch/x86/kvm/svm/sev.c          |    6 +-
 arch/x86/kvm/svm/svm.c          |   49 +-
 arch/x86/kvm/vmx/hyperv.c       |    2 +-
 arch/x86/kvm/vmx/nested.c       |    8 +-
 arch/x86/kvm/vmx/tdx.c          |   60 +-
 arch/x86/kvm/vmx/vmx.c          |   77 +-
 arch/x86/kvm/x86.c              |   97 ++-
 arch/x86/kvm/x86.h              |    2 +-
 include/uapi/linux/kvm.h        |    1 +
 15 files changed, 1298 insertions(+), 525 deletions(-)


base-commit: 6b802031877a995456c528095c41d1948546bf45
-- 
2.46.0

