Received: from out198-2.us.a.mail.aliyun.com (out198-2.us.a.mail.aliyun.com [47.90.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145A280331;
	Wed, 19 Aug 2026 05:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787118729; cv=none; b=WgfqotNX3car1n/xXqlJJeEk6NdFwdh0mOdQIPKpkAgT+JVf58wBtaj//VU4RKEkN1gr1QiSdN7wKUuOG51opPksWFvG2Dvh2DlmAgJChTr/ubM4mDgaO8EyFcWZljLdj84UzCsyUMf/uno/4ET8gS5WFa+DKT1tH/uUEsRPZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787118729; c=relaxed/simple;
	bh=d+1L4BHjC0Yeu79FF4+DoXAKQzejfEEKmq7czElstxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uXTY6Eoxw8XCliY6fjmfzSNLGAB91WL2/p69D74koRM0PSPAW0qXjQwfIi44WL6vkYbFFsH5iaPa93uz3+gN/G/5QcWwM4lkBrYgwMm22tPfrK5HTVJKvQcMvR/e1kMCeWZ9dXGvlwexNQ36gHR7xY5pe+I7pEYDSBQ4TjYM+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.223866|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00575848-0.000891566-0.99335;FP=7740560421585456875|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.ir-3H5j_1787118688;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ir-3H5j_1787118688 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 13:51:47 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	kvm@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jim Mattson <jmattson@google.com>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v4 0/9] KVM: nSVM: Enable DecodeAssists for nested guests
Date: Wed, 19 Aug 2026 13:51:15 +0800
Message-ID: <cover.1787116250.git.zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SVM DecodeAssists feature provides decode state for selected
VM-Exits.  KVM currently does not expose this feature to L1.  Some L1
hypervisors may therefore treat the platform's SVM support as
incomplete.

In practice, this was observed with Hyper-V running on top of KVM.
Hyper-V appears to require DecodeAssists before enabling nested SVM for
its guests.  Virtualizing the feature lets users enable Hyper-V
virtualization features inside a Windows VM when needed, e.g. to run
QEMU/KVM in WSL.  Without DecodeAssists, Hyper-V does not enable nested
SVM because DecodeAssists is missing from KVM's virtual SVM model.

Virtualize DecodeAssists for nested SVM.  Propagate instruction bytes
from VMCB02 for hardware-originated data #NPF and intercepted data #PF
VM-Exits.  For KVM-generated exits, synthesize the architectural
EXITINFO state and use matching bytes from the emulator when available,
fetching missing bytes through L2's address translation only as a
fallback.  Do not use the fallback for SEV guests, whose encrypted
memory cannot provide plaintext instruction bytes to KVM.

The selftest coverage in this version is intentionally broad and may be
more extensive than necessary.  Some redundant cases can be removed in
a later revision, but for now the series provides a comprehensive test
set for users to exercise hardware-reflected, KVM-synthesized,
userspace-injected, and boundary cases.

The selftest has been run with kvm.force_emulation_prefix both disabled
and enabled.

Changes since v3:
- Rebase onto kvm-x86/next.
- Register DecodeAssists in the CPUID 0x8000000A SVM capability
  initializer so that common code validates its CPUID word before the
  SVM code enables it for nested guests.
- Make the VMCB02 instruction-byte source const and simplify the
  synthesized-byte copy and fallback-fetch flow.

v3:
https://lore.kernel.org/r/cover.1785411877.git.zhang_wei@open-hieco.net

Changes since v2:
- Rebase onto kvm-x86/next.
- Track hardware-provided instruction bytes independently of the VMCB02
  exit code, and preserve the bytes when L0 handles an intercepted #PF
  before reflecting it to L1.
- Select the instruction-byte source using host-owned VMCB02 state
  instead of control fields in guest-owned VMCB12.
- Record whether a queued #PF VM-Exit has a matching emulator context,
  so userspace-injected #PF exits do not consume stale emulator bytes.
- Stop fallback instruction fetches at noncanonical addresses and at the
  32-bit linear-address boundary.
- Extend the selftest with regression coverage for replacing a hardware
  #NPF with a synthesized #NPF and for userspace-injected #PF during
  emulation, and harden its page layout and ucall handling.

v2:
https://lore.kernel.org/r/cover.1783999988.git.zhang_wei@open-hieco.net

Changes since v1:
- Split the implementation into seven patches to make the individual
  pieces easier to review.
- Add EXITINFO virtualization for emulator-generated MOV CR/DR, INTn,
  INVLPG, and INVLPGA intercepts.
- Limit GuestInstrBytes propagation to data #NPF and intercepted #PF
  exits, and clear the fields for instruction-fetch and unrelated exits.
- Provide GuestInstrBytes for KVM-synthesized data #PF/#NPF exits.  Use
  matching emulator bytes first and fetch missing bytes from L2 RIP as a
  fallback, while avoiding fallback reads for SEV guests.
- Expand the selftest beyond hardware #NPF and stale-state coverage to
  exercise hardware, synthesized, userspace-injected, instruction-fetch,
  page-boundary, and CS-limit cases.

v1:
https://lore.kernel.org/r/20260629125205.52394-1-zhang_wei@open-hieco.net

Tina Zhang (9):
  KVM: x86: Add helper to provide intercept linear addresses
  KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
  KVM: nSVM: Track hardware-provided instruction bytes
  KVM: nSVM: Propagate hardware DecodeAssist bytes to VMCB12
  KVM: x86: Track emulator-originated nested #PF VM-Exits
  KVM: nSVM: Use emulator bytes for synthesized nested #NPF/#PF
  KVM: nSVM: Fetch missing DecodeAssist bytes for synthesized #NPF/#PF
  KVM: nSVM: Advertise DecodeAssists to L1
  KVM: selftests: Add nested SVM DecodeAssists test

 arch/x86/include/asm/kvm_host.h               |   1 +
 arch/x86/kvm/cpuid.c                          |   1 +
 arch/x86/kvm/emulate.c                        |  29 +-
 arch/x86/kvm/kvm_emulate.h                    |   1 +
 arch/x86/kvm/svm/nested.c                     | 174 +++-
 arch/x86/kvm/svm/svm.c                        |  72 +-
 arch/x86/kvm/svm/svm.h                        |  20 +-
 arch/x86/kvm/x86.c                            |  33 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../kvm/x86/svm_nested_decode_assists_test.c  | 791 ++++++++++++++++++
 11 files changed, 1094 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c


base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
-- 
2.43.7
