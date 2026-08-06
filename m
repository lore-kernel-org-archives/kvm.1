Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00929B795;
	Thu,  6 Aug 2026 01:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979126; cv=none; b=EoGCN+Xl1skO0C21acLUJe5nY6iUIrFlIvDJtlnvtjytB3mTNSqlYno7ir3yq3hV+Tp+nfoCFob67ALioRkJJzKC6aC7ahIXVqh4SyZXGME7Phw1bflvLMSUPiLhPPruo3WYGl8iS1sFR1Cf11m7ZKktmtS5OFHfC4CSW8N6+5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979126; c=relaxed/simple;
	bh=fjvHqJNgNwdx1vjprYiRBOzPt8BTiUkkRl4bqI9CcMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1fSoXPQ9wqmyXJMTk/ZueHJGmsUQRKDI1iNR+5yKLLyTre8RTkk86JDs+aWwbnySz8qNTc04lbrZGX1VHoRBHJ1YGp/0zEcuQlGBnjCIFqXYu/bPuCJAwoY4QbEk9QdBvkUATmR77NfybzDPiASRuAPTwJk4PdkwNH+0xEx6Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IRsbNSok; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IRsbNSok"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785979124; x=1817515124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fjvHqJNgNwdx1vjprYiRBOzPt8BTiUkkRl4bqI9CcMs=;
  b=IRsbNSokYwJVH2wWYH1MqkV7713ZXVNUcZrgstgC5/QWkIv337bzDFUW
   CV0xKQKxVDP8Yc45Ncn+Q4WEbyRZYs5+Gz+wliKXZ8VmtI2L516SNpTqM
   hmcGjTLTQzdBTrtHGyPFvcVfJuKsLH/SAwiUxvwb0vJi5ZPjUEPrDCdm9
   AiOjJc4b/0Ce3pYYSY2y39wp90zw6QXAhW1ihLPdSqARSUkeen7TDiSxf
   T+8x7EDB+fXleofp+u/S9tTGK+y1lK/CHV4PUjPFUYDkc7O5WgYcp8v/z
   KLeGE/+qd9DNx9rAx74VzkIYu6t3HP/dABYqQh8T8Zcgxb7XjIV2BxlTH
   g==;
X-CSE-ConnectionGUID: GTucjUrmR9yRLPFFvm7/iw==
X-CSE-MsgGUID: PHWLsmBmQTuUqUYGz9gElQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="86593960"
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="86593960"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 18:18:43 -0700
X-CSE-ConnectionGUID: yu82HgoJSCiFKjA+G8OpyA==
X-CSE-MsgGUID: n+Sc0AVgTEW2uUkQn8/XlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,207,1779174000"; 
   d="scan'208";a="265804604"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 05 Aug 2026 18:18:42 -0700
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
	Sohil Mehta <sohil.mehta@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 0/7] KVM: x86: Add LASS virtualization support
Date: Wed,  5 Aug 2026 18:15:29 -0700
Message-ID: <20260806011536.4172258-1-sohil.mehta@intel.com>
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
The previous version of the LASS KVM series (v3) was posted as part of
the combined LAM and LASS KVM series. The LAM patches from that series,
along with the emulator flag cleanups that LASS depended on, were merged
separately. The remaining LASS patches went unposted for some time while
the host support was being merged.

I have refreshed the patches and rebased them onto the latest
kvm-x86/next branch. This iteration is marked as v4 to keep a sense of
continuity.

v3: https://lore.kernel.org/lkml/20230913124227.12574-1-binbin.wu@linux.intel.com/

Changes in v4
-------------
- Rebased the patches onto kvm-x86/next (7.2-rc2 based)
- Reorganized the patches and reworded the changelogs
- Switched to gva_t for the LASS address parameter throughout
- Advertised LASS with X86_64_F() so it isn't exposed on 32-bit
- Exempted branch targets from LAM untagging
- Added emulator TSS I/O bitmap cleanup
- Added basic KVM and x86 selftests

Background
----------
The host support series [3] covers the motivation, base enforcement
mechanism, kernel toggling of RFLAGS and CR4.LASS, and the userspace
exception notifications. Here's a brief summary of the SDM bits [4] that
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
KVM must apply the same LASS violation checks as hardware during
instruction emulation so that emulated accesses behave the same way.

Patch 1-4: Enhance the emulator to handle LASS violation checks.
Patch   5: Guest CPUID and CR4 handling. Expose LASS to userspace.
Patch 6-7: Basic KVM and x86 selftest for LASS.

Though functional, the tests in patches 6 and 7 are fairly limited and
mainly for reference and discussion.

Testing
-------
1. Basic enumeration and enabling in guest and nested environment.
2. LASS enforcement tests (userspace + LKDTM + test kernel module)
 - Userspace access to kernel address (read, write, instr fetch)
 - Kernel access to user address (read, write, instr fetch)
 - RFLAGS.AC=1 suppression (read, write)
 - FEP tests for the above cases

KVM selftests and kvm-unit-tests run guest code in the lower half at
CPL0, so enabling CR4.LASS makes the next instruction fetch a violation
and triple-faults the guest. We are evaluating if the infrastructure can
be enhanced to test LASS enforcement.

Links
-----
[1]: https://lore.kernel.org/lkml/20251201231537.736899-1-dave.hansen@linux.intel.com/
[2]: https://lore.kernel.org/lkml/20260413154235.1543087-1-dave.hansen@linux.intel.com/
[3]: https://lore.kernel.org/all/20251118182911.2983253-1-sohil.mehta@intel.com/
[4]: "Linear-Address Pre-Processing", Intel SDM (June 2026), Vol 3, Chapter 4.

Previous versions
v3: https://lore.kernel.org/lkml/20230913124227.12574-1-binbin.wu@linux.intel.com/
v2: https://lore.kernel.org/all/20230718131844.5706-1-guang.zeng@intel.com/
v1: https://lore.kernel.org/all/20230601142309.6307-1-guang.zeng@intel.com/
v0: https://lore.kernel.org/lkml/20230420133724.11398-1-guang.zeng@intel.com/

Binbin Wu (1):
  KVM: x86: Add an emulator flag to differentiate branch targets from
    fetches

Sohil Mehta (3):
  KVM: x86: Use linear_read_system() to read the TSS I/O bitmap
  KVM: selftests: Add coverage for LASS CPUID and CR4 handling
  selftests/x86: Add a userspace test for LASS enforcement

Zeng Guang (3):
  KVM: x86: Add LASS violation checks during instruction emulation
  KVM: VMX: Implement LASS violation check
  KVM: x86: Virtualize LASS and advertise support to userspace

 arch/x86/include/asm/kvm-x86-ops.h            |   1 +
 arch/x86/include/asm/kvm_host.h               |   2 +
 arch/x86/kvm/cpuid.c                          |   1 +
 arch/x86/kvm/emulate.c                        |  28 ++-
 arch/x86/kvm/kvm_emulate.h                    |   4 +-
 arch/x86/kvm/regs.h                           |   4 +-
 arch/x86/kvm/vmx/main.c                       |   1 +
 arch/x86/kvm/vmx/nested.c                     |  11 +-
 arch/x86/kvm/vmx/sgx.c                        |   3 +-
 arch/x86/kvm/vmx/vmx.c                        |  51 ++++-
 arch/x86/kvm/vmx/vmx.h                        |   3 +
 arch/x86/kvm/x86.c                            |   9 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   2 +
 tools/testing/selftests/kvm/x86/lass_test.c   |  56 +++++
 .../selftests/kvm/x86/set_sregs_test.c        |   3 +
 tools/testing/selftests/x86/Makefile          |   3 +-
 tools/testing/selftests/x86/lass.c            | 196 ++++++++++++++++++
 18 files changed, 363 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/lass_test.c
 create mode 100644 tools/testing/selftests/x86/lass.c


base-commit: 2dfab80a305700a45bd947350dae253ba4e30c41
-- 
2.43.0

