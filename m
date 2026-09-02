Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B672F12DA;
	Wed,  2 Sep 2026 02:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788317080; cv=none; b=QynFdPHrOaz8hZjM5q4p89v7lS/o3EJbkbG/ZGNq5SC4W1U8V/g2kmV6A5MI7jsaUO8qDGUrPTp0GpLthbp7LIlAnw96n69ddZE0rYXdpjpagqXGR0CncWxqgU7CWoF4lBGbGlqvDkNz/uaUM4rvobXOXOF5+Wz02FjjD40AZm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788317080; c=relaxed/simple;
	bh=mV863BZqmQh0jLKMjUwihEvc9fKL/uc+ODR/WZc6tZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nm/KalyupJ5yYzpU71ZPIqkbnn/6nFxChWQdkEGmWnyjLnuTn7yU7n3pg1skeAuX0gpOflV6EnfHhmCceNVRXlSoDEPy69GeDHNLb94bHuPfm20fQ8SR25vmCHFwQw4Gwu6nR7RDmuQB9em4bzaNRVQpzaQcFhrWrzQu8tCobWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qh2n4eQG; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qh2n4eQG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788317079; x=1819853079;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mV863BZqmQh0jLKMjUwihEvc9fKL/uc+ODR/WZc6tZ4=;
  b=Qh2n4eQGgnz3UV/7pTq9+DFVsnOAkWYgs3kWWHSnR/sMPu0RcRHgpHlC
   jSp/EONqQtPoOnjlf/svdVyc1mHCRHjyZgNEV3A/ichP0gPaqcwJYbb/n
   YYoq5O6RzPSPnqgvwB3M3xzxZT2v16gyboOPW4uKe/VS5FG/fe0KQDhYL
   KE40q39/7NRgQKJCX9Hl84sFq2lQBKMHHj8R0Uc0crihlUVjHbFBRBq1h
   oS4mCZC1Abp3uKHb+eKj4pvvWLzmUIWi7l19AAux+l53Vlgq3V2F13BAO
   9B37+pBIWfA4OKa/FXIpMAkwnuGJ0is8uXDWuoELIJhu3iC41E08GlBLG
   Q==;
X-CSE-ConnectionGUID: VX96hs1HSsy+Ol/u1xC/ug==
X-CSE-MsgGUID: yQwW0DTWTnyZHvPut1NV6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106282872"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="106282872"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 19:44:38 -0700
X-CSE-ConnectionGUID: Jcsu4giPSW+3+ywPOuJzIg==
X-CSE-MsgGUID: fUtSNZKzQk+uXWSqQl/blA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="272775470"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 01 Sep 2026 19:44:38 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	chang.seok.bae@intel.com
Subject: [PATCH v7 00/20] KVM: x86: Enable APX for guests
Date: Wed,  2 Sep 2026 02:17:44 +0000
Message-ID: <20260902021804.718676-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear KVM maintainers,

This respin is primarily a rebase onto v7.3, with the following minor
changes:

 * Patch 8: Adjust the core API usage from static_cpu_has() to
   cpu_feature_enabled().
 * Patch 2: Fix an unintended code comment change that was previously
   leaked to next patch.

Please let me know if there are any remaining issues that should be
addressed. I'm trying to figure out the next steps for the series.

Otherwise, I would appreciate your consideration for picking up this.

References:

 * Repo: git://github.com/intel/apx.git apx-kvm_v7
 * KVM unit test: https://lore.kernel.org/20260420212355.507827-1-chang.seok.bae@intel.com
 * V6: https://lore.kernel.org/kvm/20260729191656.598771-1-chang.seok.bae@intel.com/

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


base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.53.0

