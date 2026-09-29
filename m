Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238719A288
	for <kvm@vger.kernel.org>; Tue, 29 Sep 2026 04:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654605; cv=none; b=ADZnOtOnlVVxs+GNVFi/5B6uu1ms5dmPgUrYcOKSfQgAzMFhs4bdCT28itrMXnUD02PXwG6scsAwQ42FFoUUCHiGYjUWmOEqRgM+x4svqDId8eE0WqDpIcqOKem76aqoAS6fvCu8MGMr9mdyvU59Y7A+4PjjgutN7pyJiLgdgN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654605; c=relaxed/simple;
	bh=cAPVcgsAJorVkgcgjx8qJ2Cz7pTUEIJBuCCMwyGBvoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvmZNjKANf0tF2APTY6CWEIraKm8VLDtnDQhykqssHyRuIhxC/Bhy+/LGbnBoddjEDzF0EghY0n+mBKf/QGw+5C7P0/C/YaX8ROjW9NJ/MFUaMCoFCKn12GuE/xoUb+gYoSj/N3LDG7ap+gCJjpMS4RNUTPdMBLomy7PXaP/4+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=S5hD9btE; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S5hD9btE"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2e2c837fa12so715735ad.1
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 21:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790654603; x=1791259403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p1CKCrpax+qcHAbV5I37hg3uq7X1UIkb9ImgfW4E7N8=;
        b=PlPPiKpfb3FDQUgSCvVV3UB7jLQjzaZo/eo5sl0nQQTO+0+zVFyRocB4g/jnJaonco
         LKKrrA6/9TZiJJvr5rx9efBjuJYGd3qpmGsUyStS2O0nzKxf7Gl7ivmoY5VmQ+M20iQu
         e3KoU/M7ZiBZGtRGASrdX7lojRWWSN94MTeTWqZO9RsIPtMR0EyrViXYhACzyloo1hoa
         ZOeb1egWdKmcgrarwzvRt9PItwSkgK7OmFBGpG4Gy+k2YQWxxtM64PndJtiSA51jUJDA
         UZfsvmEX9JQh32Vmv4AjCIJ5G6Fd67uFT+z9p/3p9xD8HHIG6FojA5mSoIsOmJTrRpSO
         82hw==
X-Forwarded-Encrypted: i=1; AKwUvByuhxr9wsebcGhxNDcvSo0DAuhFhnRJDvsgPcDVfCOyUD8cYe3TSj1KokmCL2OREQX3W84=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSY2jgwpjZGo13rzxVU2adAfDnn9IA4j9qRpCeU53tI8NcHBEo
	O958Nal21RhD3/YvZWArnZ6hgT8SbBHliVdIlexA8uPsL8/Du/ntZJt8TSYbpZ/9NHnmLCuZckJ
	YHUlUzURLhGeVToYSPxHzmCIhbtVDya14l6GAMlY9Ifg5XzA/JTqCgaZQl7eLC9sCCVeT+Ri8Qn
	a5jUvCtconKk1A7/L5gMlc96tDI2O+dLy9U0JbLjqmnpi91Wm2c1GtqADMXSEKnBKZdbn/JHnjn
	J9m
X-Gm-Gg: AYBFou3IXcMfaqwl8FW64Zc1auZx+hKQOwHm420L0d9/hN5UUD7KE60Xv3KJMtG9WNo
	enSXFnXrey0SMWIlChYrOinQEcDXSkQDVWJro90FS5bA2NxeVo+fxkB2MZ9vij033HgRIvyCODO
	FelAM6txKygsTmqR9FlTfrLf9CNLRuaVDWcR8EBs6/IBY61I5dkLMbVW+TjM5LSt2oL1IHda6Fl
	GTqDHrqsdQjAsw6dNBPIMzyIE8O0Gdt34R+v37TYV6V7eUgQ9xINuPFC4rQVms2luQKl/QIrRcU
	QKYjvwtXgtr1hpxz5pUd4fjeUSaL5vU3L0pkY8g+9SkkoT2GyrS8DVlWbUjKHX14eKKHARqvbWX
	dIDNxexgCZOgtRRU431eVSXdwjBxgUnDYVptbHn6Bhi7Sz6SuMppRTEh2SlApxj7oEYRRLxwWRZ
	6Bj1LmDH+cxVhj9jlqHCV3o2Y4kg3ss2/F
X-Received: by 2002:a17:90b:390d:b0:3a0:c717:2db with SMTP id 98e67ed59e1d1-3a0c7170934mr6606637a91.27.1790654603435;
        Mon, 28 Sep 2026 21:03:23 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a497e9ab17sm1002106a91.3.2026.09.28.21.03.22
        for <kvm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Sep 2026 21:03:23 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-33713e5e6daso5804016eec.0
        for <kvm@vger.kernel.org>; Mon, 28 Sep 2026 21:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790654601; x=1791259401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p1CKCrpax+qcHAbV5I37hg3uq7X1UIkb9ImgfW4E7N8=;
        b=S5hD9btEeeCasujz5w9QZDPjqqKKIrEHlJMVqOqhX8KtIl+hs1yg3FyozSXIHCQDtD
         9u57WciCTYugRIfLEGeT5e2xFFu67Xc8zbGGVunTFXU+nSERWicaZLT2ywSoRAPCSJWn
         5zgf3Rs94gkb08ZDMg2/ffnuONLXuLnDyT+jE=
X-Forwarded-Encrypted: i=1; AKwUvByaqWaAvRA+9Sik07CIBKyud5p6eQDnVLYh/YTtPcYDJoG/aboYYny/OV6kTEq9fbDbO1Q=@vger.kernel.org
X-Received: by 2002:a05:693c:4099:b0:34b:401a:4648 with SMTP id 5a478bee46e88-34b40298aa6mr875187eec.20.1790654601402;
        Mon, 28 Sep 2026 21:03:21 -0700 (PDT)
X-Received: by 2002:a05:693c:4099:b0:34b:401a:4648 with SMTP id 5a478bee46e88-34b40298aa6mr875122eec.20.1790654600700;
        Mon, 28 Sep 2026 21:03:20 -0700 (PDT)
Received: from vertex.localdomain ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-347323f5a7esm10952571eec.15.2026.09.28.21.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 21:03:18 -0700 (PDT)
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
Subject: [PATCH v2 3/6] x86/percpu: Require embedded allocation in encrypted guests
Date: Tue, 29 Sep 2026 00:02:52 -0400
Message-ID: <20260929040256.543767-4-zack.rusin@broadcom.com>
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

Early sharing needs direct-mapped per-CPU storage. In TDX, a private
direct-map alias of a shared page can terminate the guest, including
through load_unaligned_zeropad(). Require embed rather than adding early
vmalloc conversion and alias synchronization.

Warn when overriding percpu_alloc=page and let embed failures reach the
existing panic. Restrict this policy to encrypted guests, leaving host
SME allocation unchanged.

Suggested-by: Kiryl Shutsemau <kas@kernel.org>
Link: https://lore.kernel.org/r/aqvxQoIoYhJTZpAC@thinkstation
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  3 +++
 arch/x86/kernel/setup_percpu.c                  | 12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 33cd30996e47..8ba881af3520 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5347,6 +5347,9 @@ Kernel parameters
 			See comments in mm/percpu.c for details on each
 			allocator.  This parameter is primarily	for debugging
 			and performance comparison.
+			On x86 encrypted guests, only "embed" is supported;
+			"page" is ignored with a warning. An embed allocation
+			failure is fatal instead of falling back to "page".
 
 	pirq=		[SMP,APIC] Manual mp-table setup
 			See Documentation/arch/x86/i386/IO-APIC.rst.
diff --git a/arch/x86/kernel/setup_percpu.c b/arch/x86/kernel/setup_percpu.c
index bfa48e7a32a2..c83c61e0b20a 100644
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -8,6 +8,7 @@
 #include <linux/percpu.h>
 #include <linux/kexec.h>
 #include <linux/crash_dump.h>
+#include <linux/cc_platform.h>
 #include <linux/smp.h>
 #include <linux/topology.h>
 #include <linux/pfn.h>
@@ -112,6 +113,7 @@ void __init setup_per_cpu_areas(void)
 {
 	unsigned int cpu;
 	unsigned long delta;
+	bool encrypted = cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
 	int rc;
 
 	pr_info("NR_CPUS:%d nr_cpumask_bits:%d nr_cpu_ids:%u nr_node_ids:%u\n",
@@ -127,6 +129,12 @@ void __init setup_per_cpu_areas(void)
 	if (pcpu_chosen_fc == PCPU_FC_AUTO && pcpu_need_numa())
 		pcpu_chosen_fc = PCPU_FC_PAGE;
 #endif
+	if (encrypted) {
+		if (pcpu_chosen_fc == PCPU_FC_PAGE)
+			pr_warn("Ignoring percpu_alloc=page in an encrypted guest\n");
+		pcpu_chosen_fc = PCPU_FC_EMBED;
+	}
+
 	rc = -EINVAL;
 	if (pcpu_chosen_fc != PCPU_FC_PAGE) {
 		const size_t dyn_size = PERCPU_MODULE_RESERVE +
@@ -149,11 +157,11 @@ void __init setup_per_cpu_areas(void)
 					    dyn_size, atom_size,
 					    pcpu_cpu_distance,
 					    pcpu_cpu_to_node);
-		if (rc < 0)
+		if (rc < 0 && !encrypted)
 			pr_warn("%s allocator failed (%d), falling back to page size\n",
 				pcpu_fc_names[pcpu_chosen_fc], rc);
 	}
-	if (rc < 0)
+	if (rc < 0 && !encrypted)
 		rc = pcpu_page_first_chunk(PERCPU_FIRST_CHUNK_RESERVE,
 					   pcpu_cpu_to_node);
 	if (rc < 0)
-- 
2.53.0

