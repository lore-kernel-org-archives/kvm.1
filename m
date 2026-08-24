Received: from out198-11.us.a.mail.aliyun.com (out198-11.us.a.mail.aliyun.com [47.90.198.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CBF377575
	for <kvm@vger.kernel.org>; Mon, 24 Aug 2026 04:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787547556; cv=none; b=MwLuCDOiYLy4pzWh7JAhKInQPpiiNNy+qAbJuCl81TPjXGqdFPv1utOYNN6hNWnYT+FKKuxaXBXv5kjurvEPLoJLF8slDnvYPfRhn5jVBKxifI7QLm43T30OgjSPUXKOWxLyevYYHFexbHTHp+cgY6h75XvLl5uqcrjqRPvrFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787547556; c=relaxed/simple;
	bh=Bpia/xt2KQoGRRnjfdu6blTKLdpHUUVY3EsREN2HIwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cNvNCD7u2toQZfPKWdsesG2ancCxmSNmxTwP5iQ30Or/gv021gvHLI0WASrmvGmPKjRIjAZ3y9Mob29Do2ZAS/MPaqwJ1SHbPEFIbSr5iVTx7CeAvwPSp81X9qnMz+Vk9fgVG4aM5baHfaDcMX6tC7UBKyFJB1xC8pgSt2uAUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436294|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0025186-6.99882e-05-0.997411;FP=7163947419377878315|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.ivXOSjE_1787547213;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.ivXOSjE_1787547213 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 24 Aug 2026 12:53:38 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v3 00/10] target/i386: Fix Hygon vendor-specific CPU behavior
Date: Mon, 24 Aug 2026 12:53:04 +0800
Message-ID: <20260824045314.162941-1-zhang_wei@open-hieco.net>
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
machine types and is disabled for pc-11.1 and older, so existing machine
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

Changes in v3:

  * Rebased onto QEMU master at v11.1.0-453-geea8fe61b8.  Use the
    pc_compat_11_1 infrastructure already present upstream and remove the
    duplicate compatibility wiring from the i440fx and q35 11.0 machine
    options.  Preserve the old Hygon ABI through pc-11.1 and update the
    affected commit messages accordingly.  (Zhao)
  * Split the PMU change into a no-functional-change vendor-family
    refactoring patch followed by the Hygon-specific change.  (Zhao)
  * Fold enforce_amd_1tb_hole and x-hygon-vendor-abi-fixes into the IOMMU
    HT GPA hole helper and update its comment.  Use explicit pc-q35-11.2
    and pc-q35-11.1 machine versions in the functional tests and include
    those versions in the test names.  (Zhao)
  * Remove the redundant vendor-specific comment from the ucode-rev
    default path.  (Zhao)
  * Update the hygon_vendor_abi_fixes field comment to follow the style of
    other machine-type compatibility fields.
  * Add Reviewed-by tags from Zhao Liu to the Hygon MCE status, MCE
    broadcast, and ucode-rev patches.

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

Tina Zhang (10):
  target/i386: Sync AMD CPUID aliases for Hygon
  target/i386: Hide Intel cache CPUID leaves for Hygon
  target/i386: Hide ARCH_CAPABILITIES for Hygon
  target/i386/kvm: Use AMD MCE status encoding for Hygon
  target/i386/kvm: Classify PMU vendor families
  target/i386/kvm: Use AMD PMU MSR paths for Hygon
  target/i386: Do not broadcast injected MCEs for Hygon
  hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
  target/i386: Use AMD legacy cache fallback for Hygon
  target/i386: Use AMD ucode-rev default for Hygon

 hw/i386/pc.c                                  | 30 ++++--
 target/i386/cpu.c                             | 68 +++++++++----
 target/i386/cpu.h                             | 12 +++
 target/i386/helper.c                          |  2 +-
 target/i386/kvm/kvm.c                         | 75 +++++++++++----
 .../functional/x86_64/test_mem_addr_space.py  | 36 +++++++
 tests/qtest/test-x86-cpuid-compat.c           | 95 +++++++++++++++++++
 7 files changed, 275 insertions(+), 43 deletions(-)

-- 
2.43.7
