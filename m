Received: from mail-oo1-f99.google.com (mail-oo1-f99.google.com [209.85.161.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0153E49E4
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 04:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654627; cv=none; b=SCg4AHtC+EO0Z1eCW86PNJ+U5LPoGNdv+Ddt5B1sl5ysDXYToFNsdtiHIkFlhQ+Qpood6Yr1Jk9oBhgFVdxmWdPeu+RvGriqhdy+w4bAAKFzwTqeLBDvsz5/zPVl3RRYUPZ5dlQ2G3UqT4+S5e3TISd//vOR9PF4Pn5jEVOIjy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654627; c=relaxed/simple;
	bh=4EnzBo94/wogs9p6WBG49DkcMOj39XOA58Mgzmbfhqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQfrJvsrUowqB/GNHN8ECPFb3VFMQbEvXKmOwyNqvP3K18te+2iF7M2XBtNgtRNbuHMx+TBPhLjIwod8LKWSk0WLvMpfnWxh40JIZOQzz/uGmq+oBevS5h0Z63qbxWZfiy+etlCbR84bCpPOWZJYQ4mtbVBnpWQZv51wOoiSma0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VHjQdaNg; arc=none smtp.client-ip=209.85.161.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VHjQdaNg"
Received: by mail-oo1-f99.google.com with SMTP id 006d021491bc7-6d88a208441so408127eaf.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 21:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654621; x=1791259421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QwnEpUDfw+7fPie+mcX7kjJEU0lPRR1jdyRNDD8g1m0=;
        b=ouRFQHlbS3O1zoloN+ylgtsogxaiACn763gYzFVbWhud43+bViViEwJfln68Z2JolF
         umewlsAuuYbVedlbvoUWDfTFLU305CnA0npFfV+qAVOarbho+0ocsLuzUI2F9HK6zMAH
         8C63VbL/yUVVASa4GlxuHD0X3BSacG70GLZESLdlUER8g0unpF/84hM+rzWPeafff0eb
         66w8bmh6251c9lsRKXJplAKvJHVe/X/VnKexUpLp4jzKBj1GMbAdEnLj4MMwXxAoTUN+
         4HaGUpBF2rbssFaJ5QBxrDc6ht2peOg1mOpzgmyks4agJo4voquxnPxYBvLs9b7HGhDr
         HnvQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsmm79/s92ifCudtVkntXrychfV/JjGMZTAhq9YTrg7RqqUiy2vfH6eKp91uON+JK8uRo=@vger.kernel.org
X-Gm-Message-State: AFuF++l7uDiFX/lqkgR3Cshk5O8wtW6jg5d+haMBFyFtFF6bs3rKzo9M
	diUttpFWDTZmyBxKdCAn1KCjqVI7gRBLZrkQ64oy1kGvXXFjfxyIRumvHfRuVNnzbuOIPUVSEDt
	4s1IM1aFY9RFOgXMYx8nIQUol/l7pG9Nlt35h9g254JuSrLmPBxEiOKlrGLgrMB2GCKb5MREJ5Q
	sc0PcnjPuxKvMsUBLTkO20fnTm/keSRlKfnEv+nHR9jJ5dhRthNuy08keV5JxTes0OG0PRG7oFI
	eF+
X-Gm-Gg: AYBFou2X6VZ+gaDT71xZuF+YVLECwm5HSbLzrbOz3eeaMj0SHRw3fRCB1Z2rAwiHiCd
	LDrjiD7qGe8y5UUbTHLAGcCQVdPsT9C3icHe9LJyUQNjeNNL2S8z61w67iwwcwMv5mCb7vvRKGH
	Mne8IViRX1OgYbDm1KSZTvFqvGD8GZ4cr5g2MTXj5OA+sg5gZJAH7pCza7IvI1ssZ6ZoGuijTPG
	M5fhO9AhcsJWWhsuriL4RmSmCi6dpzPQNj4QcPfD9dQrX4rFW3v8+pl83ax3PuxIauXUOtwTnDO
	Xn9vwWR8kmVullY8A8oIviN3+6kHSb7EEIGZqDolfz4tKyrq4joC3ydK8QNC7tXtN/bYXSAvA9Y
	oPCczr9jlLLRsfNAUWTntk/5PvBsCWh9PddMrd9QM2xL+K0lnkIjO2TUYL7lTdnI7U4X7gpezc/
	Y50aeKW7b8airAVPHP13HcBeoAte/vUNXfmGQ=
X-Received: by 2002:a05:6820:190b:b0:6c9:80d9:5e6 with SMTP id 006d021491bc7-6d43fd7c851mr13128575eaf.39.1790654621031;
        Mon, 28 Sep 2026 21:03:41 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-81d58a148a9sm1003252a34.8.2026.09.28.21.03.39
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:41 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30c0d568830so7722568eec.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 21:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654618; x=1791259418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QwnEpUDfw+7fPie+mcX7kjJEU0lPRR1jdyRNDD8g1m0=;
        b=VHjQdaNgsEqLzbnPQQMfISKNx8TW16XJIW5lKqiRMstRiF4M+cHEYaSwGDZot1H+Qw
         pdZOJx7+S53hYARt7tp+0qR7yHvbZwqtsLAILeVmT3Whk25CvLZ4wRbSpn0ghcR22BR0
         ZCkELX9FWEGfhPWbXwQYiuEE2Y7IdIsHb1Eeo=
X-Forwarded-Encrypted: i=1; AKwUvByIrTly+0Wn33gRXCVUu2sHO4uZJHY8Ql+ZrovQa2JJda/hJbZuK/ADp0wgE0tQ3lrWS2I=@vger.kernel.org
X-Received: by 2002:a05:7301:b05:b0:340:7202:d7fc with SMTP id 5a478bee46e88-342713a2732mr10393716eec.17.1790654618213;
        Mon, 28 Sep 2026 21:03:38 -0700 (PDT)
X-Received: by 2002:a05:7301:b05:b0:340:7202:d7fc with SMTP id 5a478bee46e88-342713a2732mr10393671eec.17.1790654617422;
        Mon, 28 Sep 2026 21:03:37 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:36 -0700 (PDT)
From: Zack Rusin <zack.rusin@broadcom.com>
To: Kiryl Shutsemau <kas@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	virtualization@lists.linux.dev,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	Christoph Lameter <cl@gentwo.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bo Gan <bo.gan@broadcom.com>,
	linux-mm@kvack.org,
	linux-arch@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 6/6] x86/percpu: Share decrypted storage before guest CPU setup
Date: Tue, 29 Sep 2026 00:02:55 -0400
Message-ID: <20260929040256.543767-7-zack.rusin@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929040256.543767-1-zack.rusin@broadcom.com>
References: <20260929040256.543767-1-zack.rusin@broadcom.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Convert every possible CPU's decrypted section after per-CPU setup and
before the boot CPU registers its buffers. This replaces KVM's object
loop and shares VMware steal-time storage without a driver conversion
path or readiness state.

UP KVM registers inside setup_arch(), so convert before guest_late_init()
there and move VMware's UP registration to that hook. Stop boot on a
conversion failure: inconsistent page state must not be published to the
hypervisor. Host SME keeps its existing mappings. Skip Hyper-V vTOM
per-CPU storage: its visibility callbacks require later Hyper-V
initialization.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/r/aqqGUAX65s4LdJkr@thinkstation
Link: https://lore.kernel.org/r/aqvxQoIoYhJTZpAC@thinkstation
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 arch/x86/hyperv/ivm.c              |  4 ++++
 arch/x86/include/asm/mem_encrypt.h |  2 ++
 arch/x86/include/asm/x86_init.h    |  2 ++
 arch/x86/kernel/cpu/vmware.c       |  2 +-
 arch/x86/kernel/kvm.c              | 35 -----------------------------------
 arch/x86/kernel/setup.c            |  2 ++
 arch/x86/kernel/setup_percpu.c     |  2 ++
 arch/x86/mm/mem_encrypt.c          | 22 ++++++++++++++++++++++
 8 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 2ce4dfe53472..4a5c735c9c52 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -887,6 +887,10 @@ void __init hv_vtom_init(void)
 	cc_set_mask(ms_hyperv.shared_gpa_boundary);
 	physical_mask &= ms_hyperv.shared_gpa_boundary - 1;
 
+	/* vTOM has no early per-CPU consumers and needs the Hyper-V setup. */
+	x86_init.paging.skip_percpu_decryption = true;
+	x86_init.paging.early_decrypt_page = NULL;
+
 	x86_platform.hyper.is_private_mmio = hv_is_private_mmio;
 	x86_platform.guest.enc_cache_flush_required = hv_vtom_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required = hv_vtom_tlb_flush_required;
diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
index 4d81f693b1d3..05cf395407ef 100644
--- a/arch/x86/include/asm/mem_encrypt.h
+++ b/arch/x86/include/asm/mem_encrypt.h
@@ -21,11 +21,13 @@ struct boot_params;
 #ifdef CONFIG_X86_MEM_ENCRYPT
 void __init mem_encrypt_init(void);
 void __init mem_encrypt_setup_arch(void);
+void __init mem_encrypt_init_percpu(void);
 int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size);
 void __init early_set_page_decrypted(unsigned long addr, unsigned long alias);
 #else
 static inline void mem_encrypt_init(void) { }
 static inline void __init mem_encrypt_setup_arch(void) { }
+static inline void __init mem_encrypt_init_percpu(void) { }
 static inline int __init
 early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0; }
 #endif
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index e4131402c783..8d1597372eb6 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -76,10 +76,12 @@ struct x86_init_oem {
  *			Callback must call paging_init(). Called once after the
  *			direct mapping for phys memory is available.
  * @early_decrypt_page:	Share a direct-mapped page and its optional image alias
+ * @skip_percpu_decryption: Platform does not use early shared per-CPU data
  */
 struct x86_init_paging {
 	void (*pagetable_init)(void);
 	int (*early_decrypt_page)(unsigned long addr, unsigned long alias);
+	bool skip_percpu_decryption;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index 34b73573b108..b477cc027b18 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -366,7 +366,7 @@ static void __init vmware_paravirt_ops_setup(void)
 					      vmware_cpu_down_prepare) < 0)
 			pr_err("vmware_guest: Failed to install cpu hotplug callbacks\n");
 #else
-		vmware_guest_cpu_init();
+		x86_init.hyper.guest_late_init = vmware_guest_cpu_init;
 #endif
 	}
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 6b0a5861ccb8..acb3b7b18ebe 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -429,34 +429,6 @@ static u64 kvm_steal_clock(int cpu)
 	return steal;
 }
 
-static inline __init void __set_percpu_decrypted(void *ptr, unsigned long size)
-{
-	early_set_memory_decrypted((unsigned long) ptr, size);
-}
-
-/*
- * Iterate through all possible CPUs and map the memory region pointed
- * by apf_reason, steal_time and kvm_apic_eoi as decrypted at once.
- *
- * Note: we iterate through all possible CPUs to ensure that CPUs
- * hotplugged will have their per-cpu variable already mapped as
- * decrypted.
- */
-static void __init sev_map_percpu_data(void)
-{
-	int cpu;
-
-	if (cc_vendor != CC_VENDOR_AMD ||
-	    !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
-		return;
-
-	for_each_possible_cpu(cpu) {
-		__set_percpu_decrypted(&per_cpu(apf_reason, cpu), sizeof(apf_reason));
-		__set_percpu_decrypted(&per_cpu(steal_time, cpu), sizeof(steal_time));
-		__set_percpu_decrypted(&per_cpu(kvm_apic_eoi, cpu), sizeof(kvm_apic_eoi));
-	}
-}
-
 static void kvm_guest_cpu_offline(bool shutdown)
 {
 	kvm_disable_steal_time();
@@ -709,12 +681,6 @@ arch_initcall(kvm_alloc_cpumask);
 
 static void __init kvm_smp_prepare_boot_cpu(void)
 {
-	/*
-	 * Map the per-cpu variables as decrypted before kvm_guest_cpu_init()
-	 * shares the guest physical address with the hypervisor.
-	 */
-	sev_map_percpu_data();
-
 	kvm_guest_cpu_init();
 	native_smp_prepare_boot_cpu();
 	kvm_spinlock_init();
@@ -868,7 +834,6 @@ static void __init kvm_guest_init(void)
 				      kvm_cpu_online, kvm_cpu_down_prepare) < 0)
 		pr_err("failed to install cpu hotplug callbacks\n");
 #else
-	sev_map_percpu_data();
 	kvm_guest_cpu_init();
 #endif
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index cda6adb9f69c..8eebd85e59af 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1251,6 +1251,8 @@ void __init setup_arch(char **cmdline_p)
 
 	io_apic_init_mappings();
 
+	if (!IS_ENABLED(CONFIG_SMP))
+		mem_encrypt_init_percpu();
 	x86_init.hyper.guest_late_init();
 
 	e820__reserve_resources();
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index c83c61e0b20a..8526ad37a81b 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/init.h>
 #include <linux/memblock.h>
+#include <linux/mem_encrypt.h>
 #include <linux/percpu.h>
 #include <linux/kexec.h>
 #include <linux/crash_dump.h>
@@ -234,4 +235,5 @@ void __init setup_per_cpu_areas(void)
 	 * this call?
 	 */
 	sync_initial_page_table();
+	mem_encrypt_init_percpu();
 }
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index c3e239a47b66..d3224607170d 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -13,6 +13,7 @@
 #include <linux/cc_platform.h>
 #include <linux/mem_encrypt.h>
 #include <linux/pgalloc.h>
+#include <linux/percpu.h>
 #include <linux/virtio_anchor.h>
 #include <linux/iommu-dma.h>
 
@@ -24,6 +25,8 @@
 
 #include "mm_internal.h"
 
+extern char __percpu __start_percpu_decrypted[], __end_percpu_decrypted[];
+
 static pte_t * __init early_lookup_pte(unsigned long addr)
 {
 	unsigned long pfn, step;
@@ -134,6 +137,25 @@ int __init early_set_memory_decrypted(unsigned long vaddr, unsigned long size)
 	return 0;
 }
 
+void __init mem_encrypt_init_percpu(void)
+{
+	unsigned long size = __end_percpu_decrypted - __start_percpu_decrypted;
+	int cpu, ret;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) ||
+	    x86_init.paging.skip_percpu_decryption)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		unsigned long addr = (unsigned long)
+			per_cpu_ptr(__start_percpu_decrypted, cpu);
+
+		ret = early_set_memory_decrypted(addr, size);
+		if (ret)
+			panic("Cannot share CPU %d per-CPU data (err=%d)", cpu, ret);
+	}
+}
+
 /* Override for DMA direct allocation check - ARCH_HAS_FORCE_DMA_UNENCRYPTED */
 bool force_dma_unencrypted(struct device *dev)
 {

-- 
2.53.0

