Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0089F38C40C;
	Sun, 13 Sep 2026 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789281846; cv=none; b=Q6U1xn9+MPObdrYMmjwBjkAfm8ij4mQ0Oou+guufrIx8I43bCtXLrntqvQzWs7I/yWp4fm7Yy7PxOVwThGUheFk3BrXDMmLHTgr79PjueY4/tyd6b1H6JGyEdU5lo/u4unHVvuhRxbCiXC13rE2xizVcr1K7MOuXWXg1ykwkcnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789281846; c=relaxed/simple;
	bh=UN3EiVW6dDlO5NeyftBc2lAVCAxHJagRYukNqQHVrDg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQn79R82d8pOA8BexvvNmL/ESBJv9raAmp+Kf3yTNHZ/MfqX3dsTUV+PUf0HeYW5mvW0gXqH+jHLhKUUkgKGLfQ57Aa5aP1IfRQSJ5sZci1cQW+TfjvTTr24//5LeOfsJ/qsim9tHGaT47FgQHd5JPiqHME14/m6tErj6uChRWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1127893|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00652923-0.00111774-0.992353;FP=7181974258020044279|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032023038;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jCORvhE_1789281829;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jCORvhE_1789281829 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 13 Sep 2026 14:43:54 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/8] KVM: nSVM: Enable DecodeAssists for nested guests
Date: Sun, 13 Sep 2026 14:43:40 +0800
Message-ID: <cover.1789281096.git.zhang_wei@open-hieco.net>
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
QEMU/KVM in WSL.

Virtualize both parts of DecodeAssists for nested SVM.  For emulated
MOV CR/DR, INTn, INVLPG, and related intercepts, populate EXITINFO1 as
specified by the architecture.  INVLPGA's address remains in saved guest
rAX.  Leave EXITINFO1 unchanged when DecodeAssists is not exposed.

For data #NPF and intercepted data #PF exits, propagate current hardware
instruction bytes when available.  For an emulator-generated #NPF, keep
the bytes used to decode the instruction and fetch any missing tail.
Queued #PF exits, including userspace-injected exceptions, use an
on-demand fetch from the current L2 CS:RIP.  Instruction-fetch faults
report zero bytes, and SEV guests do not use the memory-fetch fallback.

The selftest covers synthesized EXITINFO1, hardware and synthesized
instruction bytes, and truncated fetches.  Two MMIO cases check that
emulator-generated #NPF exits retain cached bytes after instruction
memory changes, while userspace-injected #PF exits do not reuse an old
emulator cache after MMIO completion.

The updated selftest passed with kvm.force_emulation_prefix both disabled
and enabled in an isolated VM using the v6 implementation.  SEV paths
have not been tested.

Changes since v5:
- Rebase onto kvm-x86/next at the base commit listed below.
- Reuse __linearize() for INVLPG and name the instruction-info field
  invlpg_linear_addr.
- Integrate EXITINFO1 generation into svm_check_intercept() instead of
  using a separate switch.  Leave undefined EXITINFO2 fields unchanged.
- Invalidate instruction bytes by clearing only insn_len.  Leave the
  VMCB12 fields untouched when DecodeAssists is not exposed, and stop
  clearing unused instruction-byte buffer tails.
- Remove the extra argument to nested_svm_exit_handled(); opcode exits
  are excluded by the instruction-byte applicability check.
- Replace the synthesized-byte staging buffer with direct VMCB02
  updates, and add an emulator accessor instead of inspecting the fetch
  cache in nSVM.  Reuse the cache only for the current emulator exception.
- Add the complete fallback before cache reuse so that no intermediate
  patch depends on a later patch to fetch missing bytes.  Reuse the
  generic guest-memory read helper with instruction-fetch permissions,
  checking address boundaries between page-sized chunks.
- Extend the MOVSB regression test to modify the opcode while MMIO is
  pending, restore userspace-injected #PF coverage, and give the MMIO
  source its own page.  Both MMIO cases run without forced emulation.

Previous versions:
v5:
https://lore.kernel.org/r/20260824123954.315112-1-zhang_wei@open-hieco.net
v4:
https://lore.kernel.org/r/cover.1787116250.git.zhang_wei@open-hieco.net
v3:
https://lore.kernel.org/r/cover.1785411877.git.zhang_wei@open-hieco.net
v2:
https://lore.kernel.org/r/cover.1783999988.git.zhang_wei@open-hieco.net
v1:
https://lore.kernel.org/r/20260629125205.52394-1-zhang_wei@open-hieco.net

Tina Zhang (8):
  KVM: x86: Provide INVLPG linear address to intercept handlers
  KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
  KVM: nSVM: Track valid hardware DecodeAssist bytes
  KVM: nSVM: Propagate hardware DecodeAssist bytes to VMCB12
  KVM: nSVM: Fetch DecodeAssist bytes for synthesized faults
  KVM: nSVM: Use emulator bytes for synthesized nested #NPF
  KVM: nSVM: Advertise DecodeAssists to L1
  KVM: selftests: Add nested SVM DecodeAssists test

 arch/x86/kvm/cpuid.c                          |   1 +
 arch/x86/kvm/emulate.c                        |  40 ++
 arch/x86/kvm/kvm_emulate.h                    |   4 +
 arch/x86/kvm/svm/nested.c                     | 163 +++++-
 arch/x86/kvm/svm/svm.c                        |  34 +-
 arch/x86/kvm/svm/svm.h                        |   3 +
 arch/x86/kvm/x86.c                            |  23 +-
 arch/x86/kvm/x86.h                            |   3 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../kvm/x86/svm_nested_decode_assists_test.c  | 547 ++++++++++++++++++
 11 files changed, 814 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c


base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97
-- 
2.43.7
