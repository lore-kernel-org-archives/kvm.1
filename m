Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E49151EDF2;
	Thu, 15 Oct 2026 20:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095720; cv=none; b=GmUYI3UT9rs8qHXWaFYPZCL4E3a3lwrhqZx3EKFHMqwfN5OBA/5/0vN/Qub7V6EzxqbB3trITff4+LFTyH+TajlAlkcGolbjxLDrowwgugMrYrn+XMghRNSZVmCjiNTLqJO4eRbF4eyAF8saY3i3azmsoTtMVduNCRu32bWYC44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095720; c=relaxed/simple;
	bh=wOuDJ6WsP6oCgfBBWAx/7lYpc+JVh022Ql1ySHocHI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rlo0t3GvjE9ZXSD/J1vH8d+CWnFoeTV+ov98U+9bE/yRbN4kKNIAHvVJvA0lJhA5B6XLxDTHUtGhKZRjBqNQBudjQ1zWk2F5SY8alKPmI+L/asmIQs6FXk8s4lHpoc77eDoq4mRLN48y0gVjDjbAGCgqhe6KfyOmUek/cKSoz8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIsrsDNJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIsrsDNJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792095719; x=1823631719;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wOuDJ6WsP6oCgfBBWAx/7lYpc+JVh022Ql1ySHocHI8=;
  b=IIsrsDNJPdDjTOuSMxXmitIQDxBfDE27g8uIW0JQUsFPtPxx3N3XdgLe
   QDNXackys4vlq29Wmoz8Bs+/9cWLLnjQA2c0me6CNhnwHyx4Wik6yXhRe
   ERc1gwfhZx1VJpRXukwckhrMpi3D5iBeRvUYwvrtJLJSpdOnX30V+Rfie
   UAgUt7a11aYtLQ2Qztf5T20BSUHlyvRWD9Ic1oK2K6qOGcDUFkB6afQJp
   bw5kTnroqJFAX0cZh4QCvQ58iUTX6FuFC29AMIpf3Wav1fkpcHbJLxWH7
   EkCQGG4JzhWCjmFcPOrdGtj/jymdukjf59uoz6WvWzAcLGnTnKLS77Bak
   w==;
X-CSE-ConnectionGUID: UissLOHHRkWiMGIcKDjXhw==
X-CSE-MsgGUID: h/NyvfrXRW6oHuMO8F86gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="911073"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="911073"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 13:21:58 -0700
X-CSE-ConnectionGUID: V38FKx9ORe2QUdfiBFhd0Q==
X-CSE-MsgGUID: UFC6PtS3Q4aarAop6//X3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1844427"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa003.fm.intel.com with ESMTP; 15 Oct 2026 13:21:57 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Chao Gao <chao.gao@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Matlack <dmatlack@google.com>,
	Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Kishen Maloor <kishen.maloor@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v5 0/6] KVM: x86: Add LASS virtualization support
Date: Thu, 15 Oct 2026 13:19:34 -0700
Message-ID: <20261015201940.1655956-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linear Address Space Separation (LASS) is a security feature that blocks
accesses across the user/kernel boundary based on bit 63 of the linear
address alone, before any page walk is performed. Host support for LASS
has been merged [1][2]. This series adds the KVM virtualization support.

Patches
-------
I am posting a refreshed version because kvm-x86/next has advanced and some
patches needed to be rebased. v5 contains only a couple of minor changes.
Overall, the series is ready for maintainer review (and potential inclusion
in the next cycle).

Changes in v5
-------------
 - Rebased the patches onto kvm-x86/next (kvm-x86-next-2026.10.13)
 - Added a function comment to vmx_is_lass_violation() (patch 4)
 - Dropped the LASS x86 selftest (already posted separately [3])
 - Avoided the LASS specific KVM CR4 write test (patch 6)
 - Replaced Binbin's SoBs with Reviewed-bys
 - Picked up review and test tags

v4: https://lore.kernel.org/all/20260806011536.4172258-1-sohil.mehta@intel.com/

Background
----------
The host support series [4] covers the motivation, base enforcement
mechanism, kernel toggling of RFLAGS and CR4.LASS, and the userspace
exception notifications. Here's a brief summary of the SDM bits [5] that
affects KVM support.

When LASS is enabled, the CPU applies a violation check using bit 63 to
every access to a linear address prior to page walks. A user-mode access
to a supervisor address, or a supervisor-mode access to a user address,
typically raises #GP (or #SS in rare cases) instead of a #PF that
SMAP/SMEP alone would produce. LASS takes effect only in IA-32e mode.

Enforcement for supervisor-mode data accesses additionally requires SMAP
to be enabled, and is suppressed for explicit accesses when RFLAGS.AC=1.
Linear addresses used for TLB invalidation (INVLPG, INVPCID, INVVPID)
are not subject to LASS. Unlike canonicality checks, LASS only applies
to code fetches and not branch targets.

Note, LASS is now part of the SDM instead of the ISE. There are minor
changes to the wording but nothing substantial. It also includes a
clarification that the relative ordering of LASS and canonicality checks
is not defined and cannot be determined by software.

KVM support
-----------
Hardware enforces LASS on guest code that runs natively, so KVM mostly needs
to let the guest turn it on. The exception is instruction emulation, when KVM
must apply the same LASS violation checks, so that emulated accesses behave
the same way.

For enabling, KVM advertises LASS to userspace, and lets the guest set
CR4.LASS, including in nested VMX, when LASS is enumerated in its CPUID.

Patch 1-4: Enhance the emulator to handle LASS violation checks.
Patch   5: Guest CPUID and CR4 handling. Expose LASS to userspace.
Patch   6: Extend set_sregs_test selftest for LASS.

Testing
-------
1. Basic enumeration and enabling in guest and nested environment.
2. LASS enforcement tests (userspace + LKDTM + test kernel module)
 - Userspace access to kernel address (read, write, instr fetch)
 - Kernel access to user address (read, write, instr fetch)
 - RFLAGS.AC=1 suppression (read, write)
 - FEP tests for the above cases

The x86 userspace selftest was posted separately and is under review for x86
inclusion [3].

KVM selftests and kvm-unit-tests run guest code in the lower half at CPL0, so
enabling CR4.LASS makes the next instruction fetch a violation and
triple-faults the guest. I used a set of LLM generated kvm-unit-tests [6] that
overcome the limitation. Planning to clean them up and post them separately.

Kishen Maloor and Farrah Chen tested v4 on Sierra Forest and Clearwater
Forest, using the QEMU support [7] to expose LASS to the guest.

Links
-----
[1]: https://lore.kernel.org/lkml/20251201231537.736899-1-dave.hansen@linux.intel.com/
[2]: https://lore.kernel.org/lkml/20260413154235.1543087-1-dave.hansen@linux.intel.com/
[3]: https://lore.kernel.org/lkml/20261009020025.4175228-1-sohil.mehta@intel.com/
[4]: https://lore.kernel.org/all/20251118182911.2983253-1-sohil.mehta@intel.com/
[5]: "Linear-Address Pre-Processing", Intel SDM (June 2026), Vol 3, Chapter 4.
[6]: https://github.com/sohilmeh/kvm-unit-tests/tree/lass-llm
[7]: https://lore.kernel.org/all/20260826035734.114685-1-kishen.maloor@intel.com/

Previous versions
-----------------
v4: https://lore.kernel.org/all/20260806011536.4172258-1-sohil.mehta@intel.com/
v3: https://lore.kernel.org/lkml/20230913124227.12574-1-binbin.wu@linux.intel.com/
v2: https://lore.kernel.org/all/20230718131844.5706-1-guang.zeng@intel.com/
v1: https://lore.kernel.org/all/20230601142309.6307-1-guang.zeng@intel.com/
v0: https://lore.kernel.org/lkml/20230420133724.11398-1-guang.zeng@intel.com/


Binbin Wu (1):
  KVM: x86: Add an emulator flag to differentiate branch targets from
    fetches

Sohil Mehta (2):
  KVM: x86: Use linear_read_system() to read the TSS I/O bitmap
  KVM: selftests: Extend set_sregs_test to cover LASS

Zeng Guang (3):
  KVM: x86: Add LASS violation checks during instruction emulation
  KVM: VMX: Implement LASS violation check
  KVM: x86: Virtualize LASS and advertise support to userspace

 arch/x86/include/asm/kvm-x86-ops.h            |  1 +
 arch/x86/include/asm/kvm_host.h               |  2 +
 arch/x86/kvm/cpuid.c                          |  1 +
 arch/x86/kvm/emulate.c                        | 28 ++++++--
 arch/x86/kvm/kvm_emulate.h                    |  4 +-
 arch/x86/kvm/regs.h                           |  4 +-
 arch/x86/kvm/vmx/main.c                       |  1 +
 arch/x86/kvm/vmx/nested.c                     | 11 +--
 arch/x86/kvm/vmx/sgx.c                        |  3 +-
 arch/x86/kvm/vmx/vmx.c                        | 68 ++++++++++++++++++-
 arch/x86/kvm/vmx/vmx.h                        |  3 +
 arch/x86/kvm/x86.c                            |  9 ++-
 .../selftests/kvm/include/x86/processor.h     |  2 +
 .../selftests/kvm/x86/set_sregs_test.c        |  3 +
 14 files changed, 125 insertions(+), 15 deletions(-)


base-commit: dea4f6380f4ec96e8f3b0aaf2343764bd0d25ef4
-- 
2.43.0

