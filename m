Received: from out198-14.us.a.mail.aliyun.com (out198-14.us.a.mail.aliyun.com [47.90.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEB72F39CE;
	Tue, 14 Jul 2026 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784005862; cv=none; b=i8mRtgYAJYzSCiLuCsqRt9AW2SlnSR3SxvoHY4K1HkuJHZmp3DzExaxyLIyzPD5iJQBcrmpGcxUHaEv0mb5R2JgUt0yv11vchQQB+x6JMpgV5vn0bagK4NKWAf91Mk8W1n+gjtbdSTPPI5nduXTX5UVmKdiAPjGVMYBKrQo3L7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784005862; c=relaxed/simple;
	bh=S3W/K+vdlxpaIftUdCGCAGgCqT7NxLo/v9YMSGWE2p0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WWf84pOzkKAUVNP6EZLUlBTVugv6F2LblX91V5sZnapqYFm0W8rUcVIa4KyHgz8LSMtfDRZqzK+iSScYvRKxr9W/S3gvXngyVSYxVueMOgumkDwWxG0oofDvqLqr2lXy0gN0ov3PVVXHcFNGtVrMQ5cl6nep159Wh2Aik+ZWfvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.7101|0.3226961;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.00459152-0.000871729-0.994537;FP=8010776433320183803|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.iKeOBy-_1784005805;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iKeOBy-_1784005805 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 14 Jul 2026 13:10:34 +0800
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
Subject: [PATCH v2 0/8] KVM: nSVM: Enable DecodeAssists for nested guests
Date: Tue, 14 Jul 2026 13:09:56 +0800
Message-ID: <cover.1783999988.git.zhang_wei@open-hieco.net>
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

Virtualize DecodeAssists for nested SVM.  Propagate fresh hardware
instruction bytes from VMCB02, synthesize the architectural EXITINFO
state for emulator-generated intercepts, and provide instruction bytes
for KVM-synthesized data #PF/#NPF exits.  Prefer matching bytes already
fetched by the emulator, and fetch missing bytes from L2 RIP only as a
fallback.  Avoid fallback reads for SEV guests, whose encrypted memory
cannot provide plaintext instruction bytes to KVM.

The selftest coverage in this version is intentionally broad and may be
more extensive than necessary.  I kept the full set for now to cover
hardware-originated, KVM-synthesized, userspace-injected, and boundary
cases; it can be trimmed later if some cases prove redundant.

The selftest has been run with kvm.force_emulation_prefix both disabled
and enabled.

---
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
  KVM: x86: Add intercept_linear_addr to x86_instruction_info
  KVM: nSVM: Synthesize DecodeAssists EXITINFO for emulated intercepts
  KVM: nSVM: Track fresh VMCB02 DecodeAssist bytes
  KVM: nSVM: Propagate hardware DecodeAssist bytes to VMCB12
  KVM: nSVM: Use emulator bytes for synthesized nested #NPF/#PF
  KVM: nSVM: Fetch missing DecodeAssist bytes for synthesized #NPF/#PF
  KVM: nSVM: Advertise DecodeAssists to L1
  KVM: selftests: Add nested SVM DecodeAssists test

 arch/x86/kvm/emulate.c                        |  30 +-
 arch/x86/kvm/kvm_emulate.h                    |   1 +
 arch/x86/kvm/svm/nested.c                     | 188 ++++-
 arch/x86/kvm/svm/svm.c                        |  56 +-
 arch/x86/kvm/svm/svm.h                        |  24 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/processor.h     |   1 +
 .../kvm/x86/svm_nested_decode_assists_test.c  | 694 ++++++++++++++++++
 8 files changed, 980 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/svm_nested_decode_assists_test.c


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.43.7
