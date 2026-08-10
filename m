Received: from out198-13.us.a.mail.aliyun.com (out198-13.us.a.mail.aliyun.com [47.90.198.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4EC3A382F
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350678; cv=none; b=X4wQQrJ9+zFMQ7cXfm7LHOKksYZSS7pA9eLqgPLbug/TxLoiyQBgATPLTQPWrGSamTY/riJG6p59GiRm2wAG4pKIBF3fn5Uyq/gQg2zQvquLkmL5afLv2XN01p/VyV/i2x0WLW50C+yqwpB3Tp82PzupY0cjfWw7QM2rDwjqUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350678; c=relaxed/simple;
	bh=+HeCQiWep24I134KEN9cqJ0cvaT5siAwCu6k2390Rp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LlOGMyFW71JxuXUGa1FnQaCLs4vaq8Rgfg6JFtQuTKf/W9XFBQlM6egyYLyQkSnYW3rqtoS/42jum5YfLctAT3uh3fnOuMbYmKKPCfzTnBEticFCYmn+gLJ0dl3uAxwQ/vLEEFk6/pcQjm7/w6o/Gb7IfaJz/vnwsqHoh4SJr1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07437109|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00974696-4.09803e-05-0.990212;FP=7199979514931766635|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.iiL7hCG_1786350652;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iiL7hCG_1786350652 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 16:30:58 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v2 0/9] target/i386: Fix Hygon vendor-specific CPU behavior
Date: Mon, 10 Aug 2026 16:29:47 +0800
Message-ID: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hygon Dhyana uses the HygonGenuine vendor string, but a number of
guest-visible and KVM-facing interfaces follow AMD-compatible behavior.
QEMU currently keys several of these paths only on AuthenticAMD, so Hygon
guests can see vendor-inconsistent CPUID/MSR state or use the wrong KVM
PMU/MCE handling paths.

This series makes those checks explicit for Hygon where appropriate.

Guest-visible CPU ABI changes are gated by the new
x-hygon-vendor-abi-fixes property.  The property defaults to true for new
machine types and is disabled for pc-11.0 and older, so existing machine
types keep their previous Hygon ABI for migration compatibility.

The KVM injected-MCE and PMU path changes are not CPUID model table
changes.  They make QEMU use the AMD-compatible runtime handling that
Linux/KVM already uses for Hygon.

The series covers:

  * AMD CPUID[0x80000001].EDX aliases for Hygon
  * hiding Intel cache CPUID leaves 2 and 4 for Hygon
  * hiding IA32_ARCH_CAPABILITIES for Hygon unless old ABI requires it
  * AMD MCE status encoding for Hygon memory-failure injection
  * AMD PMU MSR setup/save/restore paths for Hygon
  * disabling Intel-style MCA broadcast for Hygon injected MCEs
  * AMD IOMMU HT GPA hole layout for Hygon on new machine types
  * AMD legacy cache fallback for Hygon when legacy-cache=on
  * AMD-shaped default ucode-rev value for Hygon

Changes in v2:

  * Rebased onto v11.1.0-rc3.  Moved the compatibility property to
    pc_compat_11_1 and wired it into the i440fx and q35 11.1 machine
    options.  (Zhao)
  * Patch 1: removed the single-use CPUID-alias helper and checked Hygon
    directly at the call site.  Also updated the hygon_vendor_abi_fixes
    field comment to emphasize that it is a machine-type compatibility
    option.  (Zhao)
  * Patch 4: removed the single-use MCE-status helper and checked Hygon
    directly at the call site.  (Zhao)
  * Patch 5: reworked the PMU vendor checks around a common PMU vendor-family
    abstraction, covering host/guest compatibility, PMU initialization,
    and PMU MSR save/restore.  (Zhao)
  * Collected Reviewed-by tags for patches 2, 3, and 8.

Tested with:

  ninja -C build

  build/pyvenv/bin/meson test -C build --print-errorlogs \
      qemu:qtest-x86_64/test-x86-cpuid-compat \
      qemu:func-x86_64-mem_addr_space

Tina Zhang (9):
  target/i386: Sync AMD CPUID aliases for Hygon
  target/i386: Hide Intel cache CPUID leaves for Hygon
  target/i386: Hide ARCH_CAPABILITIES for Hygon
  target/i386/kvm: Use AMD MCE status encoding for Hygon
  target/i386/kvm: Use AMD PMU MSR paths for Hygon
  target/i386: Do not broadcast injected MCEs for Hygon
  hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
  target/i386: Use AMD legacy cache fallback for Hygon
  target/i386: Use AMD ucode-rev default for Hygon

 hw/i386/pc.c                                  | 23 ++++-
 hw/i386/pc_piix.c                             |  1 +
 hw/i386/pc_q35.c                              |  1 +
 include/hw/i386/pc.h                          |  3 +
 target/i386/cpu.c                             | 73 ++++++++++----
 target/i386/cpu.h                             | 13 +++
 target/i386/helper.c                          |  2 +-
 target/i386/kvm/kvm.c                         | 75 +++++++++++----
 .../functional/x86_64/test_mem_addr_space.py  | 37 ++++++++
 tests/qtest/test-x86-cpuid-compat.c           | 95 +++++++++++++++++++
 10 files changed, 282 insertions(+), 41 deletions(-)

-- 
2.43.7
