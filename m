Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AB8282F16;
	Tue, 12 May 2026 01:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778550022; cv=none; b=kIjkNsip3xRenUsjekBcUHl/Uny+emp2tXxumCFIH8AQEQnIcmbJfV4M2tQm4g5fDPcGzE2TQijczJxZRTXlSfh7tJ2FZwjWq/1ZJtsAM3QQcff1yjTipo+IKvcl6fiO3SozOAZMZl0uq2X50zrCZMYpgjufIcEoapDqybop+E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778550022; c=relaxed/simple;
	bh=WxRVBx+rScOi6pt31ruw4ipsv1RgAKDSG1++K/qKXqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jgfMTpPr4qxtXsSx09ylB+VWKm8gJk3yESBq1qEDTeVaPzXuzeEw857yswN54b7SO9N2eLAtO80mC7VAFoeM8WU/l0y3l+eY4bCzdHNiKxp6SYIz/HQ+RWUF2hgU+eTllQwbk98/vemfbx/XlO/6IlONyZnYjjVK4+ukVy2gIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A6+XTgUr; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A6+XTgUr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778550020; x=1810086020;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WxRVBx+rScOi6pt31ruw4ipsv1RgAKDSG1++K/qKXqo=;
  b=A6+XTgUr3rj05ZISsVyCFteThhvEQyvppTxSAlBvcjc8gQDvmqGUm68/
   SxTo/P+9CCZAdr2Zbft87KAzPmF/oZSTrTS5SmCT8adoCNFcwelbGwN1q
   kYlewOBG15UBn6CHXu3x14u00udiJ+mwanSK5U9mwYkS/KbxGZUTcQ5KD
   vlV64kEfkSLsABlaG4NZzYIvuwY8Lz9Y6yDN/qpRinrJesh8PHQZNkYsx
   w/KQ3/aphQUmUzuedK1tlRuiXApWbqevtmWjhsbVbY+qdChovZpqbYAx/
   qGMe1EAZtusxsUFZLB37ASvxj8PdVrSOc3g5tXVl8IKQJ+vkOrsEcNYB2
   A==;
X-CSE-ConnectionGUID: GCUGfWdnSTiL2HZE/LoQpg==
X-CSE-MsgGUID: NsIewXmIQNi9uk6hcA+zcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="83322095"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="83322095"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 18:40:19 -0700
X-CSE-ConnectionGUID: SYtxMwzVTv63TFfanlYpqg==
X-CSE-MsgGUID: TToWtoPqS86U0zxit7r9yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="234572739"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by fmviesa007.fm.intel.com with ESMTP; 11 May 2026 18:40:15 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v4 00/21] KVM: x86: Enable APX for guests
Date: Tue, 12 May 2026 01:14:41 +0000
Message-ID: <20260512011502.53072-1-chang.seok.bae@intel.com>
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

This round contains relatively smaller changes compared to previous
versions:

  * Generalize the load/store sequences to cover all GPRs (PATCH1-3)
  * Clarify APX exclusion from the x86 xstate copy functions (PATCH6)

A few notes for the x86-side changes:

  * Move the previously deprecated arch/x86/include/asm/inst.h into KVM
  * PATCH6 since x86 changes is better to gain an ACK from the x86
    maintainers before going anywhere

The patchset still depends on these in-flight series:

  * Paolo's SPEC_CTRL refactoring
    https://git.kernel.org/pub/scm/virt/kvm/kvm.git/commit/?h=queue&id=fcaf986d10768dddb23598d6f0560006dad0c8bd
  * Sean's preparatory series
    https://lore.kernel.org/kvm/20260409224236.2021562-1-seanjc@google.com/

A few notes are also worth retaining in the cover letter:

== State Management Design ==

  The initial approach (before V3) was access physical EGPRs directly
  similar to vector registers, but this introduces non-uniform access
  patterns against directly accessing VCPU regs[]. Sean thus gave his
  feedback to shift away from it.

  To maintain uniformity, EGPRs need to be stored in regs[]. Sean's reg
  accessor infra updates makes this feasible. It was also realized that
  saving EGPRs outside of the fastpath is not viable, as fastpath
  handlers may access EGPRs as well.

  Then, saving EGPRs on entry code appears to be the choice. This also
  looks to provide some degree of robustness (but not completely yet
  though [*]) for when the kernel clobbers those registers. The VCPU XCR0
  can gate this path to avoid #UD from non-APX guests.

  The conditional path should be also under speculation-safety, rather
  than wild guest control. Paolo's rework on entry code will establish a
  SPEC_CTRL macro which allows a finer control.

  For userspace interactions, the EGPR state in regs[] can be copied
  directly to/from the userspace buffer at the boundary of ABI handlers.

== Series Structure and Test Note ==

  * Part1, PATCH 01-03: Prepare entry code by macrofying GPR handling
    Most KVM test will capture any regression out of it. I also tested it
    more explicitly with tweaking the posted patch [1].

  * Part2, PATCH 04-07: Establish EGPR state management
    These new state management flow is rather unique compared to other
    XSTATEs. This fact leads to new test cases (patch20), in addition to
    state_test (patch21).

  * Part3, PATCH 08-12: Update VMX handlers for extended reg. indices
    Previously I tweaked to test an exit case like LGDT with an extended
    ID. But this part leans into VMX unless KVM is paranoid.

  * Part4, PATCH 13-16: Add emulator support for REX2
    KVM unit test patch [1] covers emulator changes.

  * Part5, PATCH 17-21: Expose features and add selftests
    XCR0 tests basically covers the exposition.

This series is currently based Sean's preparatory series on top of the
KVM's queue branch, which already includes Paolo's SPEC_CTRL rework. The
full set is also available at:

  git://github.com/intel/apx.git apx-kvm_v4

Thanks,
Chang

References:
[1] KVM unit tests:
    https://lore.kernel.org/kvm/20260420212355.507827-1-chang.seok.bae@intel.com
[2] Previous version (V3):
    https://lore.kernel.org/lkml/20260428050111.39323-1-chang.seok.bae@intel.com
[3] APX specification:
    https://cdrdv2.intel.com/v1/dl/getContent/784266
[*] E.g. NMIs at entry code could mess up with APX-clobbering handlers
    when XCR0[APX]=0. VMX extension to afford XCR0 switching by hardware
    itself could be an option to avoid the issue.

Chang S. Bae (20):
  KVM: VMX: Macrofy GPR swapping in __vmx_vcpu_run()
  KVM: SVM: Macrofy GPR swapping in __svm_vcpu_run()
  KVM: SEV: Macrofy GPR swapping in __svm_sev_es_vcpu_run()
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

Paolo Bonzini (1):
  x86/fpu: Ignore APX when copying from/to guest FPU

 arch/x86/Kconfig.assembler                    |   5 +
 arch/x86/include/asm/fpu/api.h                |   2 +-
 arch/x86/include/asm/kvm_host.h               |  52 +++--
 arch/x86/include/asm/kvm_vcpu_regs.h          |  25 ---
 arch/x86/include/asm/vmx.h                    |   2 +
 arch/x86/kernel/fpu/core.c                    |   9 +-
 arch/x86/kvm/Kconfig                          |   4 +
 arch/x86/kvm/cpuid.c                          |  28 ++-
 arch/x86/kvm/cpuid.h                          |   2 +
 arch/x86/kvm/emulate.c                        | 121 +++++++----
 arch/x86/{include/asm => kvm}/inst.h          |  88 +++++---
 arch/x86/kvm/kvm_emulate.h                    |  13 +-
 arch/x86/kvm/reverse_cpuid.h                  |   6 +
 arch/x86/kvm/svm/svm.c                        |   8 +-
 arch/x86/kvm/svm/vmenter.S                    | 107 ++--------
 arch/x86/kvm/vmenter.h                        |  44 ++++
 arch/x86/kvm/vmx/nested.c                     |  74 +++----
 arch/x86/kvm/vmx/nested.h                     |   2 +-
 arch/x86/kvm/vmx/vmcs12.c                     |   1 +
 arch/x86/kvm/vmx/vmcs12.h                     |   3 +-
 arch/x86/kvm/vmx/vmenter.S                    | 120 +++++------
 arch/x86/kvm/vmx/vmx.c                        |  26 ++-
 arch/x86/kvm/vmx/vmx.h                        |  77 ++++++-
 arch/x86/kvm/x86.c                            |  70 ++++++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     | 120 +++++++++++
 tools/testing/selftests/kvm/x86/apx_test.c    | 191 ++++++++++++++++++
 tools/testing/selftests/kvm/x86/state_test.c  |   3 +
 .../selftests/kvm/x86/xcr0_cpuid_test.c       |  19 ++
 29 files changed, 905 insertions(+), 318 deletions(-)
 delete mode 100644 arch/x86/include/asm/kvm_vcpu_regs.h
 rename arch/x86/{include/asm => kvm}/inst.h (62%)
 create mode 100644 tools/testing/selftests/kvm/x86/apx_test.c


base-commit: 98bfa4c89d413dfc69beedd1d3414d5bf15db5b9
-- 
2.51.0

