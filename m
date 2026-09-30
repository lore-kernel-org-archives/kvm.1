Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DFC51C060;
	Wed, 30 Sep 2026 21:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804092; cv=none; b=XJBQvSJvvnMGLHk7pkTdacf/KeyjE67hQHtYZWcQh+kUtlKc+2jGtrNFWprE4HKlN/poa4K9AK/yjwskD+r4/ps7tgAtnV7R8tg+Fd0a+rFunSmWa2ZXLfi9zxBWeVZqjy73jD9ADKJJDcFhAsPsJ6E+0hhmaKqUlawzNfWs2o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804092; c=relaxed/simple;
	bh=3sgeO2svJG1Hu6UNZIg6niItrptZaC3G/VO/QVfhUB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a3XANCz6fXIgNFf26SdZCEb8CzEDCLxji1gh/GwCUgov+71LSxGAIv/kexgiPRxlgy/9WJ7R9Jv+UXODyAk3eoQNM6oJnpdET8g32GgIZPeyNHC/44OzyKIXE80/U31tzRfOZ0aftQZCeaRAZgvN83tcnAgo86wtTEPcalGHqzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SKMtK+4c; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKMtK+4c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790804089; x=1822340089;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3sgeO2svJG1Hu6UNZIg6niItrptZaC3G/VO/QVfhUB8=;
  b=SKMtK+4cxsmK8BZ3ZXMG67KKG6MdH55GNzTfcSlLmarqYlYaYJT2Zwwd
   7nD0B1uYnl+IzN0xtomiN1P7vWAfsRz8X0XuMuEU/dg8sPLO/NTuII4Sk
   K+7cJClZcXwHwnJYHxVujQrkpp2N9DdtLBpyHjPSv8frEZx9krLPJp404
   ywNRLrgJTK2GJluUYzPcVbI89FUstQ3xk/Wn7zLD0LAlPblwdxkSw2teJ
   6kgct0AfkcqaJaFITb9DlUj18pO+out2ejO5+OYlAIm6GVcxGhMFQGMoN
   LokbzHm9jnmcZ8nxHLHChw6xruWwLkvLLycicAI+ARLayXq73X5fmKWsz
   g==;
X-CSE-ConnectionGUID: Do6XXStsRuexZURwiKp+NQ==
X-CSE-MsgGUID: c4+L+jyrR9SCjDQLhioY5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="94432634"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="94432634"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 14:34:48 -0700
X-CSE-ConnectionGUID: 4zkIA1bvTz2iZ5HBvW3KjQ==
X-CSE-MsgGUID: J8Ikj4toSk6xhUnuY9oH0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; 
   d="scan'208";a="283867183"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by fmviesa005.fm.intel.com with ESMTP; 30 Sep 2026 14:34:48 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v8 00/20] KVM: x86: Enable APX for guests
Date: Wed, 30 Sep 2026 21:07:30 +0000
Message-ID: <20260930210750.1487547-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Paolo,

Here is a rebase onto the KVM next tree including Zhao's test tag.

I expect Sashiko to reply to a bunch of patches. I previously found some
false positives, so I will comment on them again in this posting.

Thanks,
Chang

References:

 * Repository: git://github.com/intel/apx.git apx-kvm_v8
 * KVM unit test: https://lore.kernel.org/20260420212355.507827-1-chang.seok.bae@intel.com
 * Previous posting, V7:
   https://lore.kernel.org/kvm/20260902021804.718676-1-chang.seok.bae@intel.com

Thanks,
Chang

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


base-commit: d4b7fb647204f0c81dfeae2d1a708e4d858e0c94
-- 
2.53.0

