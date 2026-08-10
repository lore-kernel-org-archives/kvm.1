Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5973A8FE6
	for <kvm@vger.kernel.org>; Mon, 10 Aug 2026 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350677; cv=none; b=Fy2TYPA2YePccvuRprxxrIb7WoHzncCvs4ONCSTL8naXESlE8jKmrFmFTyG1j5SH3MyOc/6yAbBoJXRZuJfQFeVsSK4wHAIdLROqkzI53koasj/0FESn2LhPrh0wv6uoLYJaC/67TlwXUa70PPTFOiKqB2TwZnKugFVC61xY1BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350677; c=relaxed/simple;
	bh=6vO4s8/8AexPMSLozm1nrLMmouEbbw67bkzoGKP5OT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgdMpSgIMENJy68ms0or/J1XyxdIZnVB/KAvNpotLJMWCEGJxzadAKvqM9zpqnqeemCkPjcxISD3ugndz9TexCArTXIgvuYuQw07a2k//y/yoZKu7BQsTY7FRurB0MytAOtBPBh0V2wFdte/t3paElloZ6Z26UD6XGiwoUrOpJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=115.124.28.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436353|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.014778-0.000114728-0.985107;FP=7607367760908667379|1|1|1|0|-1|-1|-1;HT=maildocker-contentspam033037032089;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.iiL7hP8_1786350663;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iiL7hP8_1786350663 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Aug 2026 16:31:04 +0800
From: Tina Zhang <zhang_wei@open-hieco.net>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yanjing Zhou <zhouyanjing@hygon.cn>,
	Tina Zhang <zhang_wei@open-hieco.net>
Subject: [PATCH v2 7/9] hw/i386: Reserve AMD IOMMU HT GPA range for Hygon
Date: Mon, 10 Aug 2026 16:29:54 +0800
Message-ID: <20260810082956.1768042-8-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
References: <20260810082956.1768042-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pc_memory_init() avoids the AMD IOMMU HyperTransport range below 1 TiB
only for AMD vCPUs.  Dhyana therefore allows RAM, hotplug address space,
or 64-bit PCI MMIO to overlap 0xfd00000000-0xffffffffff.

Linux supports Dhyana platforms in the AMD IOMMU driver.  The driver
reports this range as reserved unless the IOMMU advertises
FEATURE_HT_RANGE_IGNORE.  A VFIO device cannot DMA to guest addresses
that QEMU places in the reserved range: VFIO_DMA_MAP may fail with
-EINVAL, or the IOMMU may report an INVALID_DEVICE_REQUEST fault.

Apply the AMD IOMMU HT GPA layout to Hygon vCPUs.  When the possible
address space reaches the reserved range, move RAM above 4 GiB to 1 TiB;
also expose the range as reserved in E820 when the vCPU can address it.

Changing the GPA layout affects migration, so enable the Hygon behavior
through x-hygon-vendor-abi-fixes.  pc-11.0 and older machine types retain
their previous Hygon layout.  The existing enforce_amd_1tb_hole setting
continues to preserve the AMD layout of pc/q35 machine types through 7.0.

Add functional tests for Dhyana with the current q35 machine type and
with pc-q35-11.0 compatibility.

Signed-off-by: Yanjing Zhou <zhouyanjing@hygon.cn>
Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 hw/i386/pc.c                                  | 18 ++++++---
 .../functional/x86_64/test_mem_addr_space.py  | 37 +++++++++++++++++++
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2b4e322b2f..04aef6c267 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -738,6 +738,12 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
 #define AMD_ABOVE_1TB_START  (AMD_HT_END + 1)
 #define AMD_HT_SIZE          (AMD_ABOVE_1TB_START - AMD_HT_START)
 
+static bool x86_cpu_has_amd_iommu_ht_gpa_hole(const X86CPU *cpu)
+{
+    return IS_AMD_CPU(&cpu->env) ||
+           (IS_HYGON_CPU(&cpu->env) && cpu->hygon_vendor_abi_fixes);
+}
+
 void pc_memory_init(PCMachineState *pcms,
                     MemoryRegion *system_memory,
                     MemoryRegion *rom_memory,
@@ -762,12 +768,14 @@ void pc_memory_init(PCMachineState *pcms,
     linux_boot = (machine->kernel_filename != NULL);
 
     /*
-     * The HyperTransport range close to the 1T boundary is unique to AMD
-     * hosts with IOMMUs enabled. Restrict the ram-above-4g relocation
-     * to above 1T to AMD vCPUs only. @enforce_amd_1tb_hole is only false in
-     * older machine types (<= 7.0) for compatibility purposes.
+     * The HyperTransport range close to the 1T boundary is reserved by the
+     * AMD IOMMU GPA layout.  Apply the ram-above-4g relocation only to vCPUs
+     * that use that layout. @enforce_amd_1tb_hole preserves older AMD
+     * machine types (<= 7.0), and x-hygon-vendor-abi-fixes preserves older
+     * Hygon machine types (<= 11.0).
      */
-    if (IS_AMD_CPU(&cpu->env) && pcmc->enforce_amd_1tb_hole) {
+    if (x86_cpu_has_amd_iommu_ht_gpa_hole(cpu) &&
+        pcmc->enforce_amd_1tb_hole) {
         /* Bail out if max possible address does not cross HT range */
         if (pc_max_used_gpa(pcms, pci_hole64_size) >= AMD_HT_START) {
             x86ms->above_4g_mem_start = AMD_ABOVE_1TB_START;
diff --git a/tests/functional/x86_64/test_mem_addr_space.py b/tests/functional/x86_64/test_mem_addr_space.py
index 61b4a190b4..b80f9acd99 100755
--- a/tests/functional/x86_64/test_mem_addr_space.py
+++ b/tests/functional/x86_64/test_mem_addr_space.py
@@ -208,6 +208,25 @@ def test_phybits_low_tcg_q35_71_amd(self):
         self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
+    def test_phybits_low_tcg_q35_hygon(self):
+        """
+        Same as q35-7.1 AMD case except that here we check that Dhyana
+        follows the same AMD IOMMU HT reserved GPA range on new machine
+        types.
+        """
+        self.ensure_64bit_binary()
+        self.set_machine('q35')
+        self.vm.add_args('-S', '-cpu', 'Dhyana,phys-bits=40',
+                         '-m', '512,slots=1,maxmem=976G',
+                         '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        self.vm.wait()
+        self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
+        self.assertRegex(self.vm.get_log(), r'phys-bits too low')
+
     def test_phybits_ok_tcg_q35_70_amd(self):
         """
         Same as q35-7.0 AMD case except that here we check that QEMU can
@@ -225,6 +244,24 @@ def test_phybits_ok_tcg_q35_70_amd(self):
         self.vm.shutdown()
         self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
 
+    def test_phybits_ok_tcg_q35_110_hygon(self):
+        """
+        Same as q35-7.1 Dhyana case except that here we check that the
+        q35-11.0 compatibility setting keeps the old memory layout.
+        """
+        self.ensure_64bit_binary()
+        self.set_machine('pc-q35-11.0')
+        self.vm.add_args('-S', '-cpu', 'Dhyana,phys-bits=40',
+                         '-m', '512,slots=1,maxmem=976G',
+                         '-display', 'none',
+                         '-object', 'memory-backend-ram,id=mem1,size=1G',
+                         '-device', 'pc-dimm,id=vm0,memdev=mem1')
+        self.vm.set_qmp_monitor(enabled=False)
+        self.vm.launch()
+        time.sleep(self.DELAY_Q35_BOOT_SEQUENCE)
+        self.vm.shutdown()
+        self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
+
     def test_phybits_ok_tcg_q35_71_amd(self):
         """
         Same as q35-7.1 AMD case except that here we check that QEMU can
-- 
2.43.7

