Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0031F3128B6;
	Tue, 28 Apr 2026 05:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353977; cv=none; b=Hq9EOUhDGUvCIjYSnU6pitDOoBJU8OMBNg2CRSxQn59ySD4NrIj3UIz7jyYx8/YrhFMCYSUaKOOu3sNSP7VMEOG+WQaee6XtKFqVgoKLI2wmIMh7+0SPc9GN9Sfnwc7UWDQDcXZeS6H+7jPah/zt95c9/t3nKT4ukohipYb+6cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353977; c=relaxed/simple;
	bh=i3yVVYelNDMh8MY5WCys9RfgZhb0sc8HuvpTySdHf4w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WW3MHFyrjgJ+EMQP+ng8Ow/BT1YH3ZxejAXVZNITgq6bU3X1XnZPlsbxos2z1EtvgUQSp96ULziQ5RFPhe1V2hx7hBTNGP6ZeiG7YzX1opivVtXG6wZ9ywYdZGHi92xbkVg18mwIJdwnYurPly5RfovPWsPJumoFZgE4Wxb5CF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C0CKmuKz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C0CKmuKz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353976; x=1808889976;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=i3yVVYelNDMh8MY5WCys9RfgZhb0sc8HuvpTySdHf4w=;
  b=C0CKmuKzJmSIRjA4aJmt2sO/2wi/W+KkrZQFqH7PKnTaR20bS8+yYz3U
   8WURRpSmakxa1EkY80Fnh0Xp1S0coNkSmIzl5SzAMLfoqa34LhUmznbmM
   6mZbpbfWarZN5muNQfohhdoCl8DnyCJIejv4WqVzjGT3lZjXFiBpBGbtQ
   LMMQfHMFNJm6QGJv9y9reoyFKMc1ibnFQa3QobX4U6TO2XR50K5HfN9VN
   e6VltM0whcdLEQ3CbHV6zdjXaCeW6JjGNty8n5In6agC2wiKCMlKoTO8x
   YpIU6GKal/T2YfzB2xv4xVhSvY5bAEB+08EgYFrtXsF3CQYF9W2QG8C2e
   A==;
X-CSE-ConnectionGUID: yJKX1yUKQ+qdYthMGwhx9g==
X-CSE-MsgGUID: JcIVQRs/QQWa+UL/HXSuTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131665"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131665"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:13 -0700
X-CSE-ConnectionGUID: X/wP4DM9Ss65m+CzvuhQSg==
X-CSE-MsgGUID: o+GUW00BTVOvxNpVXRj6jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130154"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:13 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 00/20] KVM: x86: Enable APX for guests
Date: Tue, 28 Apr 2026 05:00:51 +0000
Message-ID: <20260428050111.39323-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This revision tries to reflect the recent design discussions [1]. Notably
the series also depends on preparatory work [1,2], so should be on hold
until they are merged. But the intention here is to sort out next level
of details by collecting feedbacks.

Below is a summary of the recently established direction:

  Since the V2 posting [4], Sean gave his feedbacks that led to shift the
  approach. The initial approach was access physical EGPRs directly
  similar to vector registers, but this introduces non-uniform access
  patterns against directly accessing VCPU regs[].

  To maintain uniformity, EGPRs need to be stored in regs[]. Sean's reg
  accessor infra updates [1] makes this feasible. It was also realized
  that saving EGPRs outside of the fastpath is not viable, as fastpath
  handlers may access EGPRs as well.

  Then, saving EGPRs on entry code appears to be the choice. This also
  looks to provide some degree of robustness (but not completely yet
  though [*]) for when the kernel clobbers those registers. The VCPU XCR0
  can gate this path to avoid #UD from non-APX guests.

  The conditional path should be also under speculation-safety, rather
  than wild guest control. Paolo's rework on entry code [2] will
  establish a SPEC_CTRL macro which allows a finer control.

  For userspace interactions, the EGPR state in regs[] can be copied
  directly to/from the userspace buffer at the boundary of ABI handlers.

With this design concept in mind, here are a couple of points to call out
while each patch has a note of changes:

  * Entry changes

    The entry code is first refactored to generalize (64-bit) register
    save/restore via macros (part1-3). This simplifies integration of
    EGPR handling (patch5). I also sorted to simplify the register saving
    path by skipping VM-Fail check.

  * XSAVE ABI

    Similar to PKRU, the state is not managed by XSAVE internally but is
    exposed via the XSAVE format. KVM fully owns both ends: storage and
    ABI handling so KVM-side changes alone cover the support. There are 
    some subtlties (noted in patch6) in arrangement with the existing 
    copy function.

Finally, series layout and relevant test comments:

  * Part1, PATCH 01-03: Prepare entry code by macrofying GPR handling
    Most KVM test will capture any regression out of it. I also tested it 
    more explicitly with tweaking the posted patch [3].

  * Part2, PATCH 04-06: Establish EGPR state management
    These new state management flow is rather unique compared to other
    XSTATEs. This fact leads to new test cases (patch18), in addition to
    state_test (patch19).

  * Part3, PATCH 07-11: Update VMX handlers for extended reg. indices
    Previously I tweaked to test an exit case like LGDT with an extended 
    ID. But this part leans into VMX unless KVM is paranoid.

  * Part4, PATCH 12-15: Add emulator support for REX2
    KVM unit test patch [3] covers emulator changes.

  * Part5, PATCH 16-19: Expose features and add selftests
    XCR0 tests basically covers the exposition.

This series is currently based on an old commit (02896e0065ca) in x86 KVM
next branch and includes preparatory patches [1,2]. It can be also found
here:
  git://github.com/intel/apx.git apx-kvm_v3

Thanks,
Chang

References:
[1] Sean's preparatory series:
    https://lore.kernel.org/kvm/20260409224236.2021562-1-seanjc@google.com/
[2] Paolo's SPEC_CTRL refactoring:
    https://lore.kernel.org/kvm/20260427105848.44865-1-pbonzini@redhat.com/
[3] KVM unit tests:
    https://lore.kernel.org/kvm/20260420212355.507827-1-chang.seok.bae@intel.com/
[4] Previous version (V2):
    https://lore.kernel.org/kvm/20260112235408.168200-1-chang.seok.bae@intel.com/
[5] APX specification:
    https://cdrdv2.intel.com/v1/dl/getContent/784266
[*] E.g. NMIs at entry code could mess up with APX-clobbering handlers
    when XCR0[APX]=0. VMX extention to afford XCR0 switching by hardware
    itself could be an option to avoid the issue.

Chang S. Bae (20):
  KVM: VMX: Macrofy 64-bit GPR swapping in __vmx_vcpu_run()
  KVM: SVM: Macrofy 64-bit GPR swapping in __svm_vcpu_run()
  KVM: SEV: Macrofy 64-bit GPR swapping in __svm_sev_es_vcpu_run()
  KVM: x86: Extend VCPU registers for EGPRs
  KVM: VMX: Save guest EGPRs in VCPU cache
  KVM: x86: Support APX state for XSAVE ABI
  KVM: VMX: Refactor VMX instruction information access
  KVM: VMX: Refactor instruction information decoding
  KVM: VMX: Refactor register index retrieval from exit qualification
  KVM: VMX: Support instruction information extension
  KVM: nVMX: Propagate the extended instruction info field
  KVM: x86: Support EGPR accessing and tracking for emulator
  KVM: x86: Handle EGPR index and REX2-incompatible opcodes
  KVM: x86: Support REX2-prefixed opcode decode
  KVM: x86: Reject EVEX-prefixed instructions
  KVM: x86: Guard valid XCR0.APX settings
  KVM: x86: Expose APX foundation feature to guests
  KVM: x86: Expose APX sub-features to guests
  KVM: x86: selftests: Add APX state and ABI test
  KVM: x86: selftests: Add APX state handling and XCR0 sanity checks

 arch/x86/Kconfig.assembler                    |   5 +
 arch/x86/include/asm/kvm_host.h               |  35 +++-
 arch/x86/include/asm/kvm_vcpu_regs.h          |  11 -
 arch/x86/include/asm/vmx.h                    |   2 +
 arch/x86/kvm/Kconfig                          |   4 +
 arch/x86/kvm/cpuid.c                          |  28 ++-
 arch/x86/kvm/cpuid.h                          |   2 +
 arch/x86/kvm/emulate.c                        | 121 +++++++----
 arch/x86/kvm/kvm_emulate.h                    |  13 +-
 arch/x86/kvm/reverse_cpuid.h                  |   6 +
 arch/x86/kvm/svm/svm.c                        |   8 +-
 arch/x86/kvm/svm/vmenter.S                    |  51 +----
 arch/x86/kvm/vmenter.h                        |  51 +++++
 arch/x86/kvm/vmx/nested.c                     |  74 +++----
 arch/x86/kvm/vmx/nested.h                     |   2 +-
 arch/x86/kvm/vmx/vmcs12.c                     |   1 +
 arch/x86/kvm/vmx/vmcs12.h                     |   3 +-
 arch/x86/kvm/vmx/vmenter.S                    |  67 +++---
 arch/x86/kvm/vmx/vmx.c                        |  26 ++-
 arch/x86/kvm/vmx/vmx.h                        |  77 ++++++-
 arch/x86/kvm/x86.c                            |  76 ++++++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     | 120 +++++++++++
 tools/testing/selftests/kvm/x86/apx_test.c    | 192 ++++++++++++++++++
 tools/testing/selftests/kvm/x86/state_test.c  |   3 +
 .../selftests/kvm/x86/xcr0_cpuid_test.c       |  19 ++
 26 files changed, 803 insertions(+), 195 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/apx_test.c


base-commit: 109b8abcee6413717b09ba6b0bd4b3bc5aaa4608
-- 
2.51.0

