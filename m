Received: from out198-2.us.a.mail.aliyun.com (out198-2.us.a.mail.aliyun.com [47.90.198.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97D41A79E;
	Mon, 24 Aug 2026 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575248; cv=none; b=GwC8az/CRYwBG5wBphoHJBe3l7qNwd7JoogJJo3qNiIhd6Ln163avDCOwWYgARG2zBoIYqBmEut7eHwNSMmpJaDRKThxVz1iIJ6N9YWCGJFh+3oubG1WNm+NoO8p11lZEd3uU3UfixL8ZknWvfjfWYM5y6ZivyKOibK6wH/0BMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575248; c=relaxed/simple;
	bh=fNeTf521zd5l+z09OVJTYRfu7Nroa3OqJnDG4r0AN/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ahvd9YX8SVw56+KOLSvwH7szVvrYC4SGNCax712Mq4TQBCJ+D+9zNTAcC6GrH5iMloHiSZqouKqKFv8Pw9XnyFAbGLjhl50dP7d32hg1XbM4JFyAezEFK211Rmb4In1gOORIr+qZn26uQRB3X3BtRQjsHqUexhSt83N4tPhHqAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1074666|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00475415-0.00135263-0.993893;FP=282599232233064163|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iw1ggWy_1787575217;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iw1ggWy_1787575217 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 20:40:23 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v5 0/8] KVM: nSVM: Enable DecodeAssists for nested guests
Date: Mon, 24 Aug 2026 20:39:46 +0800
Message-ID: <20260824123954.315112-1-zhang_wei@open-hieco.net>
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

Virtualize both parts of DecodeAssists for nested SVM.  For emulated
MOV CR/DR, INTn, INVLPG, and INVLPGA intercepts, synthesize the
architectural EXITINFO state that hardware would provide to L1.

For data #PF and #NPF VM-Exits, provide GuestInstrBytes from fresh
VMCB02 state, matching emulator fetch bytes, or an on-demand fetch from
the current L2 CS:RIP, depending on how the nested VM-Exit was produced.
Instruction-fetch faults report no instruction bytes, and encrypted
guests do not use the on-demand fallback.

Add a focused selftest covering synthesized EXITINFO, hardware and
synthesized GuestInstrBytes, truncated instruction fetching, and
instruction-fetch faults.  The test has been run with
kvm.force_emulation_prefix both disabled and enabled.

Changes since v4:
- Drop the generic queued-exception provenance tracking for delayed and
  synthesized #PF VM-Exits.  Fetch their instruction bytes from the
  current L2 CS:RIP when constructing VMCB12 instead.
- Keep matching emulator fetch bytes only for synthesized #NPF exits,
  and use the on-demand fetch to fill any missing tail.
- Reduce the series from nine to eight patches by removing the generic
  x86 exception-tracking patch.
- Trim the selftest to focused cases that cover distinct implementation
  paths and regressions, removing redundant instruction variants,
  overlapping boundary cases, and userspace event-state coverage.

v4:
https://lore.kernel.org/r/cover.1787116250.git.zhang_wei@open-hieco.net

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

Tina Zhang (8):
  KVM: x86: Add helper to provide intercept linear addresses
  KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
  KVM: nSVM: Track fresh hardware DecodeAssist bytes
  KVM: nSVM: Propagate hardware DecodeAssist bytes to VMCB12
  KVM: nSVM: Use emulator bytes for synthesized nested #NPF
  KVM: nSVM: Fetch missing DecodeAssist bytes for synthesized #NPF/#PF
  KVM: nSVM: Advertise DecodeAssists to L1
  KVM: selftests: Add nested SVM DecodeAssists test

 arch/x86/kvm/cpuid.c                          |   1 +
 arch/x86/kvm/emulate.c                        |  29 +-
 arch/x86/kvm/kvm_emulate.h                    |   1 +
 arch/x86/kvm/svm/nested.c                     | 180 ++++++-
 arch/x86/kvm/svm/svm.c                        |  56 +-
 arch/x86/kvm/svm/svm.h                        |  17 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../kvm/x86/svm_nested_decode_assists_test.c  | 482 ++++++++++++++++++
 9 files changed, 754 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c


base-commit: 1b731e5ded480bd1e5546aed35584238661ce72e
-- 
2.43.7
