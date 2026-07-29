Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9249A3C3789;
	Wed, 29 Jul 2026 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785354204; cv=none; b=rma+4dFW2fPZnlNLcf2d0tnwJdUCcQ90Y+7hMhqkccait8wYpMpgIDG0gYjyDHAczehpSQvL3wpSyQs8CiZ+bKKL49XYm/x+6SmzEtuxjZdiXdfr5MwuqsyhpcV0R4568iiNwjiptz5jtu5rMt1RbCT/TiOXRZ/XUGAiXjKE62w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785354204; c=relaxed/simple;
	bh=l03aqByXu/pj5O3Oa8syBJJoGKm09QFioB6XETZ7/9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hX3BK49rco1J+nXp3x9i8Y9XB/2grCMr6wOJV7RNr0XI08RspMvR4ci2lp0tGdYH10Mk3T/XJ3EcCxNj328PuKfcnU/11hHi5BTXg49bceHeJ9WMRhjpyybpXbpSS5sUzr53LBvP4Foizw9ipX4WQv8RssAuudOTJ63ffcskHB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0xbH+0Y; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0xbH+0Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785354198; x=1816890198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l03aqByXu/pj5O3Oa8syBJJoGKm09QFioB6XETZ7/9k=;
  b=Q0xbH+0YgIBTk9N0hOFfeNxixuKdPJrOYAVC8Q3Zb//jrt/u6eQKdA3c
   jiS9kmgV+mXjA+LOofaG5Tp0Htfn6u27aminIbnltvVYdSfCmjtm5WgkS
   +X0DNF9MLI1N/992anU4C5ueJYhaASVHSRE2ci3RZCrzSShTmVb39tJRA
   T85gexPNl8Klgls7atU31NvQ7FbgrJvOSOppeUIWsE74DWg2W2v2yJZVI
   RZMpMUUX43Mr/jqoxPquGaN4Fxa+hP941eAYteDEOIQhxrGJ0nTQBvFui
   ihmHLc0Om1T5N4FCohgmb0u5ApOeN3n4dPRBEjOJ0r/T/B97dJgrDRqJk
   A==;
X-CSE-ConnectionGUID: i+Bfj4TATKGXarejS/gxng==
X-CSE-MsgGUID: YO3QFHyxRgWbk4DSlQsV5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103508229"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103508229"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 12:43:15 -0700
X-CSE-ConnectionGUID: HRXN+2/mQtGYhowJJE5akg==
X-CSE-MsgGUID: s9diZpe2SyeiECEuEhAJuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="256769216"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa007.fm.intel.com with ESMTP; 29 Jul 2026 12:43:15 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v6 00/20] KVM: x86: Enable APX for guests
Date: Wed, 29 Jul 2026 19:16:36 +0000
Message-ID: <20260729191656.598771-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

On 7/21/2026 12:09 AM, Paolo Bonzini wrote:
> please give a read to its comments in case it found something important.

Here is a small follow-up revision addressing Sashiko's comments:

 * Patch02: Fix "register saving" wording in the changelog.
 * Patch17: Add the APX leaf to cpuid_function_is_indexed().

Rerunning Sashiko locally, it still appears to be somewhat confused by
the potential in-kernel usages and a few ordering of changes, so it may
report similar issues again on this posting.

I assume the V5 changes are still under review, so attaching the previous
cover letter and leaving the V5 notes in each patch.

---

One topic worth highlighting first is about how to handle userspace
writes to the APX state through the KVM XSAVE API, following the
discussion here:

  https://lore.kernel.org/CABgObfaocwfLdUBKJYYYEDH8X3n6iEbMsscbaCe_C=8JNnhDBA@mail.gmail.com

So what this revision ended up with is just to keep those copy paths from
userspace and acknowledge the redundant copy to VCPU cache / guest
fpstate. Patch3 has more context on that.

Besides that, this revision has several fixes and improvements. Sean
gave feedbacks. 0-day spotted on an issue. Also, since the preparatory
patches have been merged into the mainline, finally a review bot could
provide some feedbacks as well. The major changes are:

 1. VMX Instruction Information Extension

    During the time of V4, 0-day reported out an issue with patch7.
    Fixing that also revealed patch4 was missing another function.

    With a review bot's feeback, patch7 was also updated to ensure EGPR
    indices for handling debug-register accesses. Also looking at
    associated macros, patch6 was added for further cleanup.

 2. Emulator Register Tracking

    The review bot at hand also found a potential shift-out-bounds issue
    in the register tracking. Patch10 was fixed.

 3. APX Feature Exposure

    As per Sean's feedback, the APX XCR0 and userspace exposure were
    reworked a bit in patch14-18.

Thanks,
Chang

Reference:
 * Repo: git://github.com/intel/apx.git apx-kvm_v6
 * V5: https://lore.kernel.org/20260512011502.53072-1-chang.seok.bae@intel.com
 * KVM-unit-test patch: https://lore.kernel.org/20260420212355.507827-1-chang.seok.bae@intel.com

Chang S. Bae (19):
  KVM: x86: Extend VCPU registers for EGPRs
  KVM: VMX: Save guest EGPRs in VCPU cache
  KVM: x86: Support APX state for XSAVE ABI
  KVM: VMX: Refactor VMX instruction information access
  KVM: VMX: Refactor instruction information decoding
  KVM: VMX: Remove unused control-register access defines
  KVM: VMX: Refactor register index retrieval from exit qualification
  KVM: VMX: Support instruction information extension
  KVM: nVMX: Propagate extended instruction information
  KVM: x86: Support EGPR accessing and tracking for emulator
  KVM: x86: Handle EGPR index and REX2-incompatible opcodes
  KVM: x86: Support REX2-prefixed opcode decode
  KVM: x86: Reject EVEX-prefixed instructions
  KVM: x86: Guard valid XCR0.APX settings
  KVM: x86: Add APX to supported XCR0
  KVM: x86: Expose APX foundation feature to userspace
  KVM: x86: Expose APX sub-features to userspace
  KVM: x86: selftests: Add APX state and ABI test
  KVM: x86: selftests: Add APX state handling and XCR0 sanity checks

Sean Christopherson (1):
  KVM: x86: Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init()

 arch/x86/Kconfig.assembler                    |   5 +
 arch/x86/include/asm/cpuid/api.h              |   1 +
 arch/x86/include/asm/kvm_host.h               |  19 ++
 arch/x86/include/asm/kvm_vcpu_regs.h          |  50 +++++
 arch/x86/include/asm/vmx.h                    |  22 +-
 arch/x86/kvm/Kconfig                          |   4 +
 arch/x86/kvm/cpuid.c                          |  27 ++-
 arch/x86/kvm/cpuid.h                          |   2 +
 arch/x86/kvm/emulate.c                        | 121 +++++++----
 arch/x86/kvm/kvm_emulate.h                    |  21 +-
 arch/x86/kvm/reverse_cpuid.h                  |   6 +
 arch/x86/kvm/svm/svm.c                        |   8 +-
 arch/x86/kvm/vmenter.h                        |   1 +
 arch/x86/kvm/vmx/nested.c                     |  75 +++----
 arch/x86/kvm/vmx/nested.h                     |   2 +-
 arch/x86/kvm/vmx/vmcs12.c                     |   1 +
 arch/x86/kvm/vmx/vmcs12.h                     |   3 +-
 arch/x86/kvm/vmx/vmenter.S                    |  31 ++-
 arch/x86/kvm/vmx/vmx.c                        |  28 ++-
 arch/x86/kvm/vmx/vmx.h                        |  77 ++++++-
 arch/x86/kvm/x86.c                            |  92 +++++++--
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     | 120 +++++++++++
 tools/testing/selftests/kvm/x86/apx_test.c    | 191 ++++++++++++++++++
 tools/testing/selftests/kvm/x86/state_test.c  |   3 +
 .../selftests/kvm/x86/xcr0_cpuid_test.c       |  19 ++
 26 files changed, 802 insertions(+), 128 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/apx_test.c


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.53.0

