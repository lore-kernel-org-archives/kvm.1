Received: from out28-101.mail.aliyun.com (out28-101.mail.aliyun.com [115.124.28.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A439B4A5;
	Fri, 18 Sep 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721801; cv=none; b=Wb/l4N9SJuJ+JkGOiATUGDudSO5e+AlYcpQSZf8NfERGFD/beF9xQJRQCtT2w+kiKsma6PREZ/rRrMYrq195nbP9aMjRnPFVAyJwKkOTX3AFfpeocggoynG3zb/peEdtVZC88F4s8JPYyAuFD9LLc8AG7Rhe+hqi/YCYsfrEtk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721801; c=relaxed/simple;
	bh=HNCrEhIxicQlTKQSr+qbu9zTctD/Y2vdJuqlQmZ/CKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G8zId9I0tL71qdzv8vYyOXixdQTko+9iZ78DzKrMqA7yrWeLMzakhr0PTpaCh/Xw8FBnIkPQzY2UfSVXaHRl3e6BRKA145q1yK4o5HFWIxDbdsUSxupg/kaX45zGc+dGcOCkZhqRI6PvdKFeA9eLe5CFWm2b4TdsK42ouusthxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1867809|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.006375-0.00109542-0.99253;FP=7109916802226474487|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jGgS5HU_1789721780;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jGgS5HU_1789721780 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 18 Sep 2026 16:56:26 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/8] KVM: nSVM: Enable DecodeAssists for nested guests
Date: Fri, 18 Sep 2026 16:56:10 +0800
Message-ID: <cover.1789721173.git.zhang_wei@open-hieco.net>
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
specified by the architecture.  Preserve MOV-to-CR0 decode information
for selective CR0 write intercepts.  INVLPGA's address remains in saved
guest rAX.  Leave EXITINFO1 unchanged when DecodeAssists is not exposed.

For data #NPF and intercepted data #PF exits, propagate current hardware
instruction bytes when available.  For an emulator-generated #NPF, keep
the bytes used to decode the instruction and fetch any missing tail.
Queued #PF exits, including userspace-injected exceptions, use an
on-demand fetch from the current L2 CS:RIP.  Instruction-fetch faults
report zero bytes, and SEV guests do not use the memory-fetch fallback.

The selftest checks hardware and forced-emulation instruction intercepts
against the same expected values, including selective CR0 writes.  It
also covers hardware and synthesized instruction bytes, truncated
fetches, cache preservation after instruction memory changes during
MMIO, and userspace-injected #PF after MMIO completion.

Before rebasing, the updated selftest passed with
kvm.force_emulation_prefix both disabled and enabled in an isolated VM
using the v7 implementation.  The non-FEP cases also passed on the
physical host.  After rebasing onto the base commit below, the affected
KVM objects and selftest build successfully; runtime validation on the
new base is still pending.  SEV paths have not been tested.

Changes since v6:
- Rebase onto kvm-x86/next at the base commit listed below and use
  cpu_feature_enabled() in place of the removed static_cpu_has() API.
- Document why get_invlpg_linear_addr() ignores __linearize() failures:
  the address is computed before a failure and matches em_invlpg().
- Use CR_VALID and SVM_EXITINFO_REG_MASK for MOV CR/DR decode state,
  and retain MOV-to-CR0 information for selective CR0 write intercepts.
- Use the common VMCB02 invalidation helper for synthesized exits that
  do not provide instruction bytes.
- Extend kvm_read_guest_virt_helper() with an optional bytes_read output
  and make kvm_fetch_guest_virt() return the number of bytes read.
  Remove the nSVM page loop and handle instruction-fetch address wrapping
  and canonicality checks in the generic helper's existing loop.
- Run instruction-intercept tests without FEP as well as with FEP when
  enabled.  Add a MOV-to-CR0 selective-intercept case and poison insn_len
  and insn_bytes before each run.  Keep the CLTS check limited to bit 63.
- Add Jim's Reviewed-by tags for hardware-byte propagation and emulator
  cache reuse.

Previous versions (including earlier changelogs):
v6:
https://lore.kernel.org/r/cover.1789281096.git.zhang_wei@open-hieco.net
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
 arch/x86/kvm/emulate.c                        |  45 ++
 arch/x86/kvm/kvm_emulate.h                    |   4 +
 arch/x86/kvm/svm/nested.c                     | 142 ++++-
 arch/x86/kvm/svm/svm.c                        |  29 +
 arch/x86/kvm/svm/svm.h                        |   3 +
 arch/x86/kvm/x86.c                            |  56 +-
 arch/x86/kvm/x86.h                            |   2 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../kvm/x86/svm_nested_decode_assists_test.c  | 590 ++++++++++++++++++
 11 files changed, 862 insertions(+), 12 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c


base-commit: 70c944caf570fda2d79baa71435589a8db39f048
-- 
2.43.7
