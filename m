Received: from out198-17.us.a.mail.aliyun.com (out198-17.us.a.mail.aliyun.com [47.90.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59CA3B8921
	for <kvm@vger.kernel.org>; Mon,  6 Jul 2026 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317388; cv=none; b=qLiL8735vXe1dB2TwT+/8Lf2syiaLarf6yEjntH9avCWap8nzseylvXusFBnuaRqJNjUEMh5USzfAaUX+pMo5274sSxWAB0J2sH8gXmUrn1Fobf8IczIE3C51wa2mHjlJj4LYdMxhRXGQWpKGLXZbRmxImH/O/93sSFDzQp1zRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317388; c=relaxed/simple;
	bh=a93VFKIVIrCPkQcwGTWpZudDsB5iTXPjLMIukE8w9bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8BegOLyK7S/U/tUZzEWDcELImhu5obbRZEhVPd4eO6P9W/DgrEuUW2lKFrDpDrOKcFihy3+3mFNCm7hbEo76OVVbCmzAAOExi98xfZLaoBOz/1ayAHPwgOqpVROJrxc4Hux8S3EW/hUvxApb8nzlsxRb062vO72hsoEXmO4S6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net; spf=pass smtp.mailfrom=open-hieco.net; arc=none smtp.client-ip=47.90.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=open-hieco.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=open-hieco.net
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436273|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0135109-3.74173e-05-0.986452;FP=7603985663140579731|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021130;MF=zhang_wei@open-hieco.net;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.iEESttH_1783317367;
Received: from localhost.localdomain(mailfrom:zhang_wei@open-hieco.net fp:SMTPD_---.iEESttH_1783317367 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 06 Jul 2026 13:56:07 +0800
From: zhang_wei@open-hieco.net
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Tina Zhang <zhang_wei@open-hieco.net>,
	Yanjing Zhou <zhouyanjing@hygon.cn>
Subject: [PATCH v1 7/9] hw/i386: Apply AMD IOMMU HT GPA hole to Hygon
Date: Mon,  6 Jul 2026 13:55:28 +0800
Message-ID: <20260706055530.1752094-8-zhang_wei@open-hieco.net>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
References: <20260706055530.1752094-1-zhang_wei@open-hieco.net>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tina Zhang <zhang_wei@open-hieco.net>

QEMU reserves the HyperTransport special GPA range near the 1 TiB
boundary only for AMD vCPUs.  That range is reserved by the AMD IOMMU
GPA layout, and Linux validates VFIO DMA mappings against IOMMU reserved
regions.

If guest RAM, hotplug address space, or 64-bit MMIO windows overlap the
range, VFIO DMA_MAP can fail with -EINVAL or the IOMMU can report faults
such as INVALID_DEVICE_REQUEST.

The Linux AMD IOMMU driver also handles Hygon systems and reserves the HT
range unless the IOMMU advertises FEATURE_HT_RANGE_IGNORE.  Treat Hygon
vCPUs as using the same AMD IOMMU HT GPA-hole layout in QEMU's PC memory
layout code.

This changes the guest physical memory map for Hygon, so gate the new
Hygon behavior with x-hygon-vendor-abi-fixes.  pc-11.0 and older machine
types keep the previous Hygon memory layout, while the existing
enforce_amd_1tb_hole compatibility keeps the old AMD behavior for pc/q35
<= 7.0.

Add functional coverage for Dhyana on the current q35 machine type and
for the pc-q35-11.0 compatibility case.

Signed-off-by: Yanjing Zhou <zhouyanjing@hygon.cn>
Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
---
 hw/i386/pc.c                                  | 18 +++++++---
 .../functional/x86_64/test_mem_addr_space.py  | 36 +++++++++++++++++++
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 11dade642f..4c029d6a4b 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -735,6 +735,12 @@ static hwaddr pc_max_used_gpa(PCMachineState *pcms, uint64_t pci_hole64_size)
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
@@ -759,12 +765,14 @@ void pc_memory_init(PCMachineState *pcms,
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
index 61b4a190b4..e4b4aee008 100755
--- a/tests/functional/x86_64/test_mem_addr_space.py
+++ b/tests/functional/x86_64/test_mem_addr_space.py
@@ -208,6 +208,24 @@ def test_phybits_low_tcg_q35_71_amd(self):
         self.assertEqual(self.vm.exitcode(), 1, "QEMU exit code should be 1")
         self.assertRegex(self.vm.get_log(), r'phys-bits too low')
 
+    def test_phybits_low_tcg_q35_hygon(self):
+        """
+        Check that Dhyana on the default q35 machine follows the AMD IOMMU
+        HT reserved GPA range on new machine types.
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
@@ -225,6 +243,24 @@ def test_phybits_ok_tcg_q35_70_amd(self):
         self.vm.shutdown()
         self.assertNotRegex(self.vm.get_log(), r'phys-bits too low')
 
+    def test_phybits_ok_tcg_q35_110_hygon(self):
+        """
+        Same as the default q35 Dhyana case except that here we check that
+        the q35-11.0 compatibility setting keeps the old memory layout.
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

