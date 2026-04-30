Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE371A9FA0;
	Thu, 30 Apr 2026 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516165; cv=none; b=sjNDYpt90eNY7BmVFKxI2dgo+aBVkwoim4v9RiAjbM+fde1A5tSB6S7SWZkEcUs38/Np18jfwiu0JhjQaAFbr3IteLNYwZv94T13A2z/I0TSSftK6isizPNShQ6CqatCJlZ3Gh1r6WCneOiLfvIbKIOMDjkBAo/OIS76Qr+1z44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516165; c=relaxed/simple;
	bh=arRq54L4GiWQawZ+vUAa80USXaJi3Ci9hnWU16ndG+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu+kFQ4EFwBJ7wYctmQPacjJaHx5Kr5vYaeqmgRcEDDx8BTfiwQyziYJBY5nfJdqT+baccdbuzIcls/Y4vT2YY+bl7fHP4viP8gsBNzKVieoIsJlvBYGLTASuDERrDRlQMuyxbh96cololcdNM3BJzD6iFQYAGW5DZkIixymujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EaOdqiwn; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EaOdqiwn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777516163; x=1809052163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=arRq54L4GiWQawZ+vUAa80USXaJi3Ci9hnWU16ndG+s=;
  b=EaOdqiwnvl5uA3Ia6wYecgcSy/AnLp0ItH+NbwH9Z6GP3l3XAdJIem6k
   lAyy9kvQO6bBFYHMsX/soJqdLuYut5cLW5hnc45Hf1w2kFKiPzPDpEEPN
   XxQcpMsNRJMbDJOxHvt6IcYdmVwtbPW5OsPkCc7dDFIxFmlWAu3Q9442m
   xiSPOhrp4mCAD5jRWeGnbwG91qbMADssbHxBYVGa6xcA+tR3hXn2XNBUq
   ewCjkpoQHN/m5wrss5GJHwENqNukFVr0fhY6WRpK6ihlq0BgXAXcmkWxV
   JS1dsLBC/Vgm9j9uQD6hUEYMTS3ZMxl235YiHKCiZrcj0Nj58uA2UKvnQ
   w==;
X-CSE-ConnectionGUID: RsoIsTLeT4yF3SxO+Fb55w==
X-CSE-MsgGUID: jcFIIwKYRj2sNIFckY5eNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89552042"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="89552042"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:29:23 -0700
X-CSE-ConnectionGUID: Z/h8TnxLT8Ora/bFPDmxAw==
X-CSE-MsgGUID: H2Xs7x1HSfiP1ujpqwTdog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="239431413"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:29:18 -0700
From: Yan Zhao <yan.y.zhao@intel.com>
To: dave.hansen@linux.intel.com,
	pbonzini@redhat.com,
	seanjc@google.com
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
Subject: [PATCH v2 1/4] x86/tdx: Use PFN directly for mapping guest private memory
Date: Thu, 30 Apr 2026 09:49:29 +0800
Message-ID: <20260430014929.24210-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260430014852.24183-1-yan.y.zhao@intel.com>
References: <20260430014852.24183-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Remove struct page assumptions/constraints in the SEAMCALL wrapper APIs for
mapping guest private memory and have them take PFN directly.

Having core TDX make assumptions that guest private memory must be backed
by struct page (and/or folio) will create subtle dependencies on how
KVM/guest_memfd allocates/manages memory (e.g., whether it uses memory
allocated from core MM, if the memory is refcounted, or if the folio is
split) that are easily avoided. [1].

KVM's MMUs work with PFNs. This is very much an intentional design choice.
It ensures that the KVM MMUs remain flexible and are not too tied to the
regular CPU MMUs and the kernel code around them. Using 'struct page' for
TDX guest memory is not a good fit anywhere near the KVM MMU code [2].

Use "kvm_pfn_t pfn" for type safety. Using this KVM type is appropriate
since APIs tdh_mem_page_add() and tdh_mem_page_aug() are exported to KVM
only.

[ Yan: Replace "u64 pfn" with "kvm_pfn_t pfn" ]

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/all/aWgyhmTJphGQqO0Y@google.com [1]
Link: https://lore.kernel.org/all/ac7V0g2q2hN3dU5u@google.com [2]
---
 arch/x86/include/asm/tdx.h  |  6 ++++--
 arch/x86/kvm/vmx/tdx.c      |  7 +++----
 arch/x86/virt/vmx/tdx/tdx.c | 19 ++++++++++++-------
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 0cb77ed4adc5..619aed134c83 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/bits.h>
 #include <linux/mmzone.h>
+#include <linux/kvm_types.h>
 
 #include <asm/errno.h>
 #include <asm/ptrace.h>
@@ -189,11 +190,12 @@ static inline u64 mk_keyed_paddr(u16 hkid, struct page *page)
 
 u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
 u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page);
-u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, struct page *source, u64 *ext_err1, u64 *ext_err2);
+u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, kvm_pfn_t pfn, struct page *source,
+		     u64 *ext_err1, u64 *ext_err2);
 u64 tdh_mem_sept_add(struct tdx_td *td, u64 gpa, enum pg_level level, struct page *page,
 		     u64 *ext_err1, u64 *ext_err2);
 u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page);
-u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, enum pg_level level, struct page *page,
+u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, enum pg_level level, kvm_pfn_t pfn,
 		     u64 *ext_err1, u64 *ext_err2);
 u64 tdh_mem_range_block(struct tdx_td *td, u64 gpa, enum pg_level level, u64 *ext_err1,
 			u64 *ext_err2);
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 77aea8920a4a..9b47dd257ff4 100644
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
 
@@ -1639,12 +1639,11 @@ static int tdx_mem_page_aug(struct kvm *kvm, gfn_t gfn,
 			    enum pg_level level, kvm_pfn_t pfn)
 {
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
-	struct page *page = pfn_to_page(pfn);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 entry, level_state;
 	u64 err;
 
-	err = tdh_mem_page_aug(&kvm_tdx->td, gpa, level, page, &entry, &level_state);
+	err = tdh_mem_page_aug(&kvm_tdx->td, gpa, level, pfn, &entry, &level_state);
 	if (unlikely(tdx_operand_busy(err)))
 		return -EBUSY;
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index a6e77afafa79..b24b81cea5ea 100644
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
 static int pg_level_to_tdx_sept_level(enum pg_level level)
 {
 	WARN_ON_ONCE(level == PG_LEVEL_NONE);
@@ -1594,17 +1598,18 @@ u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page)
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
@@ -1647,16 +1652,16 @@ u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page)
 EXPORT_SYMBOL_FOR_KVM(tdh_vp_addcx);
 
 u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, enum pg_level level,
-		     struct page *page, u64 *ext_err1, u64 *ext_err2)
+		     kvm_pfn_t pfn, u64 *ext_err1, u64 *ext_err2)
 {
 	struct tdx_module_args args = {
 		.rcx = gpa | pg_level_to_tdx_sept_level(level),
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

