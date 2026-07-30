Received: from out198-12.us.a.mail.aliyun.com (out198-12.us.a.mail.aliyun.com [47.90.198.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01B3417D9C;
	Thu, 30 Jul 2026 12:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785413338; cv=none; b=b6whAEkHJ+4urTh6yHOHcTQVS1awI3w8wfXYhJ3BX17yJBIC9YzqPVxthwq+MlJUcc1KMeVO+w3BbT03GzVGEA5mQA1/vAQlrJnPdiSkACiOmhBvCbPH1PN0kZSM9xjeDTSg4e3/cM2EoXtdKrl4h4UAEEXyJmN+8vU10JlyW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785413338; c=relaxed/simple;
	bh=i0fUlP3C1tk/tJLhhXbbh2KcWBQF7d+q9f6eN5gNaRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8MBudvLJIjAEDpE62EyIgp6+zsWCmCovm0U7QjJ9fDatiXyYyHuc4UJqeT50OOB6UWsoOBQVSTDffcGN9aArVUPZ4I7odbYOHHyCrWCMb1Q3HwM7IbLZR8g0oVOr7C+JNZoWjyRMVNKF1F837UhYVtWqOVUU5YdwuztbE4axFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.5503118|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00577751-0.00121098-0.993011;FP=8064819594755885051|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iZWlrl1_1785413310;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iZWlrl1_1785413310 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 30 Jul 2026 20:08:36 +0800
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
Subject: [PATCH v3 0/9] KVM: nSVM: Enable DecodeAssists for nested guests
Date: Thu, 30 Jul 2026 20:08:03 +0800
Message-ID: <cover.1785411877.git.zhang_wei@open-hieco.net>
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
 arch/x86/kvm/emulate.c                        |  29 +-
 arch/x86/kvm/kvm_emulate.h                    |   1 +
 arch/x86/kvm/svm/nested.c                     | 181 +++-
 arch/x86/kvm/svm/svm.c                        |  72 +-
 arch/x86/kvm/svm/svm.h                        |  20 +-
 arch/x86/kvm/x86.c                            |  33 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../kvm/x86/svm_nested_decode_assists_test.c  | 791 ++++++++++++++++++
 10 files changed, 1100 insertions(+), 30 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c


base-commit: 567329869b9c75c9d3df74b35fe10af9b51c479d
-- 
2.43.7
