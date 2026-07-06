Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D853B8921
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 05:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317375; cv=none; b=DDxils4WTtQ2hj1VPZuuNs1jrDOWNWD9KMefUaPF/mB/k1Pv0ybCOkef2UQEl7CVDcrFph3roUZ//nEyRvq0dfwT1MDOgmO6YTZ9MloDJ1/DWbUFJHnyONSRghsclCjIOa//QIQAax8hgZYDu/4/p+rHydwQXXAQY0/YgHsri5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317375; c=relaxed/simple;
	bh=tmbzqr8KKJVyD9vMzE86ykFX3QfxNHQ+ez8FsjXRCTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWVoTqeI96pcRppgmiWNdG/AXxqQSSG6LbYBV8X6QmY2kChDo2kkl9/kVtXbOl07ZrlazvUMCLwcYFEvc2V/I0eE2zb1dYc0wFcSPelIzxiCA9FdPchNTbF2/oljBLwhDhjB90wLIKnoCj+gJVCCmP7AnhZZLPOXOyfvJM2L7g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07448388|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00202762-2.34808e-05-0.997949;FP=7181971576053058843|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037006180;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.iEEStYR_1783317350;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iEEStYR_1783317350 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 13:56:03 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Tina Zhang <zhang_wei@hygon.cn>
Subject: [PATCH v1 0/9] target/i386: Fix Hygon vendor-specific CPU behavior
Date: Mon,  6 Jul 2026 13:55:21 +0800
Message-ID: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <zhang_wei@hygon.cn>

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

Tests were added for the Dhyana CPUID/ucode compatibility behavior and
for the Hygon HT GPA hole memory-layout case.

Tested with:

  ninja -C build

  build/pyvenv/bin/meson test -C build --print-errorlogs \
      qemu:qtest-i386/test-x86-cpuid-compat \
      qemu:qtest-x86_64/test-x86-cpuid-compat \
      qemu:func-x86_64-mem_addr_space

Tina Zhang (9):
  target/i386: Sync AMD CPUID aliases for Hygon
  target/i386: Hide Intel cache CPUID leaves for Hygon
  target/i386: Hide ARCH_CAPABILITIES for Hygon
  target/i386/kvm: Use AMD MCE status encoding for Hygon
  target/i386/kvm: Use AMD PMU MSR paths for Hygon
  target/i386: Do not broadcast injected MCEs for Hygon
  hw/i386: Apply AMD IOMMU HT GPA hole to Hygon
  target/i386: Use AMD legacy cache fallback for Hygon
  target/i386: Use AMD ucode-rev default for Hygon

 hw/i386/pc.c                                  | 22 +++--
 target/i386/cpu.c                             | 86 +++++++++++++----
 target/i386/cpu.h                             | 12 +++
 target/i386/helper.c                          |  6 +-
 target/i386/kvm/kvm.c                         | 36 +++++--
 .../functional/x86_64/test_mem_addr_space.py  | 36 +++++++
 tests/qtest/test-x86-cpuid-compat.c           | 95 +++++++++++++++++++
 7 files changed, 263 insertions(+), 30 deletions(-)

-- 
2.43.7
