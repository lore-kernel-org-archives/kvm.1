Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946431E835;
	Mon, 20 Jul 2026 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784569568; cv=none; b=Np2jlagdpcZn/frZb5BlIZ3wNpN4VjuXl0elJDPLAq3wSf6HvntieHWT95rza928NqsXk5ulaa5g2iz8AsF6cL+7d1iVPbtoXmXqsjLJ+6favizPhJ2Hud8GsU7dv3Jc+ZQHSB1SDtW4vF0BMFFlC10SW3tvR6rPzNZuhBJrQJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784569568; c=relaxed/simple;
	bh=FhUTE9Vtp7hoVusBs2MO5iWCm8sxrn1iR6A3nhN7A0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dw7jaZ+N9lq5p+Th0EVnyXdjV6N/xdf1O5qqRTEOgFRyY9Lvd5RMqLNztSswPnTV6dXUkqHegBKeIh9+u51grnQcvjF7lx0vIZKJ7dYABB+/3y0xz6hwTGbH7Jdj/6Y625JHLXAUbJPhAU7PT4ghHi7JJbauQmi+ezuYg+MdjY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kNO7QjQ8; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kNO7QjQ8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784569561; x=1816105561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FhUTE9Vtp7hoVusBs2MO5iWCm8sxrn1iR6A3nhN7A0E=;
  b=kNO7QjQ8rrNrKDa7sia13tJhw+uX/kq11Lnx6HSe5KH0dpenTb/C/9jO
   GQCd6r2ViKwDTftfFd2BcUS2UofAnPbpxAT7ZxlOjG4kTgiouG5OvMHUV
   eVQmPCyFZbCSn79EJz4uw7CAcOZx+QJeKee16k8SMtywVuNuUZoRPMVn7
   Q3MsYqbl//qWfGugk60vjRYXHzxj62nNS/4bO//zEAR1lGUP5ThAojj9D
   X8hecxR9J81KZ5VNF1F1YSCPHWRHqYlqkRP+gFsXc3L7qkB1JN77Kk21Z
   wrhPTlxkm914qlyEZLVCEHgZhH4VqjDEZOsP/mcl1OoqyXxqb7nfL74S7
   g==;
X-CSE-ConnectionGUID: W4cMHVfkRAaDNsorh2gmnw==
X-CSE-MsgGUID: Bk4Q8LpxR1iXnU/5Q42PKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="72691619"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="72691619"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 10:45:55 -0700
X-CSE-ConnectionGUID: I+4Rq9IRQWKm2N+GE6IiTA==
X-CSE-MsgGUID: 5e4nQTDzQF2FPSA0dVM9IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="257575330"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa007.jf.intel.com with ESMTP; 20 Jul 2026 10:45:55 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v5 00/20] KVM: x86: Enable APX for guests
Date: Mon, 20 Jul 2026 17:19:29 +0000
Message-ID: <20260720171949.498680-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo and Sean,

Here is another iteration for this enabling series.

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

Along with the in-tree KVM x86 selftests, this time I ensured running the
x86 KVM-unit-test comparing between:

 * Baseline - Paolo's `queue` branch
 * This series on non-APX systems, and
 * This series on APX hardware

The full set is also available at:

  git://github.com/intel/apx.git apx-kvm_v5

Thanks,
Chang

Relevant Posting
 * V4: https://lore.kernel.org/20260512011502.53072-1-chang.seok.bae@intel.com
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
  KVM: x86: Add APX in supported XCR0
  KVM: x86: Expose APX foundation feature to userspace
  KVM: x86: Expose APX sub-features to userspace
  KVM: x86: selftests: Add APX state and ABI test
  KVM: x86: selftests: Add APX state handling and XCR0 sanity checks

Sean Christopherson (1):
  KVM: x86: Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init()

 arch/x86/Kconfig.assembler                    |   5 +
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
 25 files changed, 801 insertions(+), 128 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/apx_test.c


base-commit: a204badd8432f93b7e862e7dac6db0fe3d65f370
-- 
2.53.0

