Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457878;
	b=uW6wYqjaUHnK1lmUJvRxSamezxlFaMOASPrdHc5lA74JUaUgu9Si8cAb5V8ZNjpnkU0L
	 gxNk2Y19MzJrKfpFBQ5e5JIIc9dgpsVA4oS3bYiwJ6N+KSCft07Ah6GKp0tgmIQ23quGu
	 7lP71QaCHLEdT9qTO8b91SnMQS5dhwmm/29AKnQeYCYRJxmRpRKfSr4tn6FQfC71UIAAO
	 Xa5g2LxfdsBqDJmFaBuYYQIeNGE+gPzVG6vZ4txB8LwV/ahhH49s8OW76Wr+1yFzwmDLN
	 UzGmHOkWxV9cYK9KvrVzvu9863lsmlmGdEOkAZaFW1xIlltqtNiQQJdTdJVvPH8y70g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457878;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=x46FNggFLyCFADdG3kfk1dU0MCYJX1yYIMy3lHBv//E=;
	b=aE5T+a2C6H1wXCR2MQ9bEBPGClpZkT/ej1SZzBwGXBZUooRS/Yq3pWsAqBx2okAIqdZs
	 CUJzdoKaUVN5zymUoRPNbM46+6udTnitAodujECZylDr03xgOm2nZtDkvHGCr4nC2nPTC
	 GGNPvByaTvZ1DK2oDfF2U9+ICWtc3ERrCSLB76yTmh8/IJCaOuEzVDtMo2kAs6asj5FeT
	 gcwl833FRGGsfO1YFfZ6lSHxoa6vi/MM0k0Itd2KdIAnZPNK9+DqS8sQO+y5ygsM0YyBr
	 l3QPzXVitiEX9u5VA3TT7oA4MzZP8VKa+e9uiMvrL5a8di8IjWl6OOUYKoeGYO+TdJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lwoT8v1V;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93048606A31A;
	Mon, 23 Nov 2026 18:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93048606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lwoT8v1V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457878; x=1826993878;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NHx14LIPimSvdtZ2UJKxvy1RVJvWNcrGC49YR81r+iE=;
  b=lwoT8v1V2ZBLYdW9+zKjx+DJMOKun4jp48BzBJ6TOjCOu6LNmr6vQ5Hv
   scagpIVi38zEPHMNweWqRSPenWyrxopJuAjChj4SYazZbcSxwXcB5M59/
   /7h8bWbuZEgDTE+F6RIkKYeyH09uSo2p4a/uusftnLgg3gygrczSOTsC1
   2WxafEYSx+ZnfrpgB5Z8vt7Gongg5qSvq/3WERQMFnphJIoGCgDmiJtxU
   JcZbM5OA4Y8+9ayuY0FyP/1DBWa3CekX+rCMHgA0gaZgXKrdIUgbHc3OU
   VaAa2BRtKr7ELqiFhL1k5wBBgD1QduuyAPLKkT588DpzEIB5I+NQ/rLLG
   w==;
X-CSE-ConnectionGUID: D3gc6S3kQMmRjMLDBzLmvw==
X-CSE-MsgGUID: anKGI0g+R+GhfmBwBz6/Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288756"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288756"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:01 -0800
X-CSE-ConnectionGUID: 4ZsJ8tUxQX61Eqoe/Gx9CA==
X-CSE-MsgGUID: R3mMHPqIQUmyEyyBagu15g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241015"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:00 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 00/20] KVM: x86: Enable APX for guest
Date: Mon, 23 Nov 2026 17:37:12 +0000
Message-ID: <20261123173732.1072124-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here it is v10 but I think the series is winding down. Besides Jim Mattson's
review tags - thanks!, this respin includes a few more changes addressing his
feedback:

 * Patch 03: Simplify EGPR handling.
 * Patch 04: Remove a redundant check.
 * Patch 11: Mask high-order bits for segment registers.

I also came to other minor touches like VCPU -> vCPU.

As usual, they can be also found in
  git://github.com/intel/apx.git apx-kvm_v10 (based on the next branch)

V9: https://lore.kernel.org/20261117180310.921701-1-chang.seok.bae@intel.com

Thanks,
Chang

Chang S. Bae (19):
  KVM: x86: Extend vCPU registers for EGPRs
  KVM: VMX: Save guest EGPRs in vCPU cache
  KVM: x86: Support EGPRs on vCPU RESET/INIT events
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
  KVM: x86: Document EVEX-prefix not implemented
  KVM: x86: Guard valid XCR0.APX settings
  KVM: x86: Add APX to supported XCR0
  KVM: x86: Expose APX feature to userspace
  KVM: selftests: Add APX state and ABI test
  KVM: selftests: Add APX state handling and XCR0 sanity checks

Sean Christopherson (1):
  KVM: x86: Move KVM_SUPPORTED_{XCR0,XSS} into kvm_x86_vendor_init()

 arch/x86/Kconfig.assembler                    |   5 +
 arch/x86/include/asm/cpuid/api.h              |   1 +
 arch/x86/include/asm/kvm_host.h               |  25 +++
 arch/x86/include/asm/kvm_vcpu_regs.h          |  50 +++++
 arch/x86/include/asm/vmx.h                    |  22 +-
 arch/x86/kvm/Kconfig                          |   4 +
 arch/x86/kvm/cpuid.c                          |  33 ++-
 arch/x86/kvm/cpuid.h                          |   2 +
 arch/x86/kvm/emulate.c                        | 138 +++++++++---
 arch/x86/kvm/kvm_emulate.h                    |  21 +-
 arch/x86/kvm/reverse_cpuid.h                  |   6 +
 arch/x86/kvm/svm/svm.c                        |   8 +-
 arch/x86/kvm/vmenter.h                        |   1 +
 arch/x86/kvm/vmx/common.h                     |   5 +
 arch/x86/kvm/vmx/nested.c                     |  72 +++---
 arch/x86/kvm/vmx/nested.h                     |   2 +-
 arch/x86/kvm/vmx/vmcs12.c                     |   4 +
 arch/x86/kvm/vmx/vmcs12.h                     |   3 +-
 arch/x86/kvm/vmx/vmenter.S                    |  31 ++-
 arch/x86/kvm/vmx/vmx.c                        |  36 ++-
 arch/x86/kvm/vmx/vmx.h                        |  63 +++++-
 arch/x86/kvm/vmx/vmx_ops.h                    |   9 +
 arch/x86/kvm/x86.c                            | 114 ++++++++--
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     | 120 ++++++++++
 tools/testing/selftests/kvm/x86/apx_test.c    | 209 ++++++++++++++++++
 tools/testing/selftests/kvm/x86/state_test.c  |   3 +
 .../selftests/kvm/x86/xcr0_cpuid_test.c       |  19 ++
 28 files changed, 871 insertions(+), 136 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/apx_test.c


base-commit: cbe54fc3462b3949ab27b9ae81fb9ddb509040c7
-- 
2.53.0

