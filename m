Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6A631195B;
	Thu, 19 Mar 2026 01:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773884199; cv=none; b=rvINZvlTzA/uWafr9dbAz9BMypwHbkU9sBm0LLoiZQkRAVwSq5HNq34htfYkkLLPET8PN6rx6kdNtoo0J8ajDiPXVTldxqTe0IHA2Q4PCUm2McQJ2ICptSAowfSAENmO4Bs5F/qmCQLrV6u2LWGJWIM752H8epwYrHQvUihAJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773884199; c=relaxed/simple;
	bh=haZ0Kg7/SN1L0eQyMS8aG15Leypc29fv/ZzmH4/AZbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VYletouyKxaEQbeTxarqZAA3xh3gxNMVTI3wO4LcFvEi5bqYrF9DqaHerHvya6D1rHqk5CpkbEiqspC9hPaY4edivanzZKdZi1ZT2n2PY0cOF+Zxyv1GEmD1W/Od9EULg0KtZrKS6Nm1oHMYAvhBP6dYcZ4ResdrdnXk+IAiv2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2g+AU39; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2g+AU39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773884192; x=1805420192;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=haZ0Kg7/SN1L0eQyMS8aG15Leypc29fv/ZzmH4/AZbQ=;
  b=i2g+AU392aSsgJY5Aoebrn4biusR174F7U76Oh2uld7ImNuO94x64dW/
   ltDnvLJJL+eqN+0lcnnquSxoJwjAxiFmpGmRJh2B8sBkDS9I+BPBihEgt
   IrmTFDlxFGoHwa3te6L87LlMqQtD4DKe7cbC1yEKLNE0neieFiSXCgI8r
   JzzDd08D5qJ60z7hXlRx3c5VAY3nauaj+5lEv7HbQjWgQgR0Khxe7ZinW
   cpi7z8WJPly1ZcS5O4vqDegr9CVTEFprZ5kpeveOi1qOyFfio1gGr2PQp
   YKhhNDOevAcmI72YXT9GG0P1eV4J5aFGyKil+CYN+SEn5SQxeVSmOpKy3
   A==;
X-CSE-ConnectionGUID: r2tvcMMVRvi1uJlGvINKLg==
X-CSE-MsgGUID: zbZ2m2TvQmaGfl2lVLuqEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11733"; a="97563729"
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="97563729"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 18:36:31 -0700
X-CSE-ConnectionGUID: b6cASDauSHWAnagsMSo00w==
X-CSE-MsgGUID: FOwraE6UT86wfhAxrMCF+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,128,1770624000"; 
   d="scan'208";a="227292102"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 18:36:26 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	dave.hansen@linux.intel.com
Cc: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	kas@kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kai.huang@intel.com,
	rick.p.edgecombe@intel.com,
	yan.y.zhao@intel.com,
	yilun.xu@linux.intel.com,
	vannapurve@google.com,
	ackerleytng@google.com,
	sagis@google.com,
	binbin.wu@linux.intel.com,
	xiaoyao.li@intel.com,
	isaku.yamahata@intel.com
Subject: [PATCH 1/2] x86/virt/tdx: Use PFN directly for mapping guest private memory
Date: Thu, 19 Mar 2026 08:57:03 +0800
Message-ID: <20260319005703.8983-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260319005605.8965-1-yan.y.zhao@intel.com>
References: <20260319005605.8965-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Remove the completely unnecessary assumption that memory mapped into a TDX
guest is backed by refcounted struct page memory. From KVM's point of view,
TDH_MEM_PAGE_ADD and TDH_MEM_PAGE_AUG are glorified writes to PTEs, so they
have no business placing requirements on how KVM and guest_memfd manage
memory.

Rip out the misguided struct page assumptions/constraints and instead have
the two SEAMCALL wrapper APIs take PFN directly. This ensures that for
future huge page support in S-EPT, the kernel doesn't pick up even worse
assumptions like "a hugepage must be contained in a single folio".

Use "kvm_pfn_t pfn" for type safety. Using this KVM type is appropriate
since APIs tdh_mem_page_add() and tdh_mem_page_aug() are exported to KVM
only.

[ Yan: Replace "u64 pfn" with "kvm_pfn_t pfn" ]

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/include/asm/tdx.h  |  5 +++--
 arch/x86/kvm/vmx/tdx.c      |  7 +++----
 arch/x86/virt/vmx/tdx/tdx.c | 20 +++++++++++++-------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index a149740b24e8..f3f0b1872176 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/bits.h>
 #include <linux/mmzone.h>
+#include <linux/kvm_types.h>
 
 #include <asm/errno.h>
 #include <asm/ptrace.h>
@@ -195,10 +196,10 @@ static inline int pg_level_to_tdx_sept_level(enum pg_level level)
 
 u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
 u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page);
-u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, struct page *source, u64 *ext_err1, u64 *ext_err2);
+u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *source, u64 *ext_err1, u64 *ext_err2);
 u64 tdh_mem_sept_add(struct tdx_td *td, u64 gpa, int level, struct page *page, u64 *ext_err1, u64 *ext_err2);
 u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page);
-u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, struct page *page, u64 *ext_err1, u64 *ext_err2);
+u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, kvm_pfn_t pfn, u64 *ext_err1, u64 *ext_err2);
 u64 tdh_mem_range_block(struct tdx_td *td, u64 gpa, int level, u64 *ext_err1, u64 *ext_err2);
 u64 tdh_mng_key_config(struct tdx_td *td);
 u64 tdh_mng_create(struct tdx_td *td, u16 hkid);
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1e47c194af53..1f1abc5b5655 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1624,8 +1624,8 @@ static int tdx_mem_page_add(struct kvm *kvm, gfn_t gfn, enum pg_level level,
 	    KVM_BUG_ON(!kvm_tdx->page_add_src, kvm))
 		return -EIO;
 
-	err = tdh_mem_page_add(&kvm_tdx->td, gpa, pfn_to_page(pfn),
-			       kvm_tdx->page_add_src, &entry, &level_state);
+	err = tdh_mem_page_add(&kvm_tdx->td, gpa, pfn, kvm_tdx->page_add_src,
+			       &entry, &level_state);
 	if (unlikely(tdx_operand_busy(err)))
 		return -EBUSY;
 
@@ -1640,12 +1640,11 @@ static int tdx_mem_page_aug(struct kvm *kvm, gfn_t gfn,
 {
 	int tdx_level = pg_level_to_tdx_sept_level(level);
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-	struct page *page = pfn_to_page(pfn);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 entry, level_state;
 	u64 err;
 
-	err = tdh_mem_page_aug(&kvm_tdx->td, gpa, tdx_level, page, &entry, &level_state);
+	err = tdh_mem_page_aug(&kvm_tdx->td, gpa, tdx_level, pfn, &entry, &level_state);
 	if (unlikely(tdx_operand_busy(err)))
 		return -EBUSY;
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index cb9b3210ab71..a9dd75190c67 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -30,7 +30,6 @@
 #include <linux/suspend.h>
 #include <linux/syscore_ops.h>
 #include <linux/idr.h>
-#include <linux/kvm_types.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
@@ -1568,6 +1567,11 @@ static void tdx_clflush_page(struct page *page)
 	clflush_cache_range(page_to_virt(page), PAGE_SIZE);
 }
 
+static void tdx_clflush_pfn(kvm_pfn_t pfn)
+{
+	clflush_cache_range(__va(PFN_PHYS(pfn)), PAGE_SIZE);
+}
+
 noinstr u64 tdh_vp_enter(struct tdx_vp *td, struct tdx_module_args *args)
 {
 	args->rcx = td->tdvpr_pa;
@@ -1588,17 +1592,18 @@ u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page)
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_mng_addcx);
 
-u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, struct page *source, u64 *ext_err1, u64 *ext_err2)
+u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *source,
+		     u64 *ext_err1, u64 *ext_err2)
 {
 	struct tdx_module_args args = {
 		.rcx = gpa,
 		.rdx = tdx_tdr_pa(td),
-		.r8 = page_to_phys(page),
+		.r8 = PFN_PHYS(pfn),
 		.r9 = page_to_phys(source),
 	};
 	u64 ret;
 
-	tdx_clflush_page(page);
+	tdx_clflush_pfn(pfn);
 	ret = seamcall_ret(TDH_MEM_PAGE_ADD, &args);
 
 	*ext_err1 = args.rcx;
@@ -1639,16 +1644,17 @@ u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page)
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_vp_addcx);
 
-u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, struct page *page, u64 *ext_err1, u64 *ext_err2)
+u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, kvm_pfn_t pfn,
+		     u64 *ext_err1, u64 *ext_err2)
 {
 	struct tdx_module_args args = {
 		.rcx = gpa | level,
 		.rdx = tdx_tdr_pa(td),
-		.r8 = page_to_phys(page),
+		.r8 = PFN_PHYS(pfn),
 	};
 	u64 ret;
 
-	tdx_clflush_page(page);
+	tdx_clflush_pfn(pfn);
 	ret = seamcall_ret(TDH_MEM_PAGE_AUG, &args);
 
 	*ext_err1 = args.rcx;
-- 
2.43.2

