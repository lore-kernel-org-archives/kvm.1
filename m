Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6A535FC2;
	Wed, 23 Sep 2026 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790172188; cv=none; b=G5ukK/qP57daAdzDnyonOh7/K1q10QKDiY47MiuQ54m9Hu9KJfkyRnXtp40RjxL8gf5PRjpuEAIORuI/dq6aZB/ZJqGsNvVh3HCxE/vv1K7u5Zqt5WJRqQ2iTocOfREqdY0XcZ4t+ijAbG/UtZeWcluH1cjchWPaIzf11Z6lSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790172188; c=relaxed/simple;
	bh=LZWYjaV1PIFi+CHr1jE0waMWz+jlFsj9NPpYluI37+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OJFKTOS1h54zv4y/5ej/FPZ0Yx9zwbmvwatU7bBpALijwkyIZOvS4APVEZuaGHAhrb1gc3TQ4spihymd8ADHgMVKjfNM2eYtHXNXVA8YsCS3LcINoIm0a9X/0q7DHqG4PcBbNwX9d1cvDXF6epK/TtX6mlUrKYs+zMe0LP+oQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.7435471|0.6808907;CH=green;DM=|SPAM|false|;DS=CONTINUE|ham_system_inform|0.006375-0.00109542-0.99253;FP=7073882334777987063|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jL9oyZ0_1790172167;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.jL9oyZ0_1790172167 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 23 Sep 2026 22:02:52 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: Sean Christopherson <seanjc@google.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	zhouyanjing@hygon.cn,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/8] KVM: nSVM: Enable DecodeAssists for nested guests
Date: Wed, 23 Sep 2026 22:02:25 +0800
Message-ID: <cover.1790171702.git.zhang_wei@open-hieco.net>
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

The complete selftest passed with kvm.force_emulation_prefix both
disabled and enabled in an isolated VM running a kernel built from
this series on the base commit below.  SEV and live migration have
not been tested.

Changes since v7:
- Rebase onto kvm-x86/next at the base commit listed below.
- Revise the INVLPG comment as suggested by Jim.

Previous versions (including earlier changelogs):
v7:
https://lore.kernel.org/r/cover.1789721173.git.zhang_wei@open-hieco.net
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


base-commit: 30b5175943e709911702d8a9364145e911f57e3f
-- 
2.43.7
