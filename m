Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6FA2773D8;
	Thu, 30 Apr 2026 02:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516181; cv=none; b=dR8e/UswUIlQSiJFuMIydqGCFqOu1owmdBjOXpaj0jhBjlqdYU48o/CaAqv+7qKRt2nHf3W0uwxgKbQjsSrBUPMJ4MtndcEL1rf3udtQQjU2pYbGKTIHwnJWQRZH6yVcIWIGzzpL69t6qcm6qkfJA1xrMsTQYqTFsDxYCVULlTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516181; c=relaxed/simple;
	bh=bbWfa8ktIyR8AVNieMMnOtTrtLvrmA0X60Lp4CwNcu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUqSxJNSl8ZI5w3iK9RhGHF+jCeTN89JO5DaHVtKQNM7dA+rCE1Mqlxpmk0oYj6aozdBcseYwD9Om9T65w6Y1QhP34YzmeYrUOUGJ7Bv3cJO6B3gGlDttRpw7ahIYHTS8jkv7cXzcqx3tqnK35ubgNF8xvDKANJFFW98ZJsT3cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNyYAj9W; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNyYAj9W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777516180; x=1809052180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bbWfa8ktIyR8AVNieMMnOtTrtLvrmA0X60Lp4CwNcu8=;
  b=mNyYAj9Wwo+bMe7NWKzwRUeTEsmojNbvKLf4dUMHKRU8/uvDWEs4Knb+
   mJUKOdppeedz9oQ/84YH0Jszy14RcXwQx2ZhtqhhoHnKaNhW3bqXpToA4
   +9n+yRikSuD6vHLGYor2S6PtaEyWfHoErORZcy7uEN6/itqhhfZvVBZFr
   birNB8USAo0/awsPV0jCQSIj1H7ZK4Vg6+/NUY7ebCFSXoIsoxGOmNEcJ
   JK5KSNsis21RJbbTmeFkYRi37PC+pMphUG5/tHrXQi4fnUZgO8ui/s6Fy
   I2JEcqajrznkv3UhGlFU+BFfdetu06FtXpBUdipMabFLC64Htx4KS4d1y
   A==;
X-CSE-ConnectionGUID: LgrNEnLaRtybtxTJx48OYQ==
X-CSE-MsgGUID: MlQMNuVyToefC5xM8snKzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89552058"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="89552058"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:29:40 -0700
X-CSE-ConnectionGUID: ITFdVq73S16PdfQQfEXY8A==
X-CSE-MsgGUID: 6c39fWVORuKyHLBlob8PwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="239431455"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:29:35 -0700
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
Subject: [PATCH v2 2/4] x86/tdx: Use PFN directly for unmapping guest private memory
Date: Thu, 30 Apr 2026 09:49:48 +0800
Message-ID: <20260430014948.24226-1-yan.y.zhao@intel.com>
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

Remove struct page assumptions/constraints in APIs for unmapping guest
private memory and have them take physical address directly.

Having core TDX make assumptions that guest private memory must be backed
by struct page (and/or folio) will create subtle dependencies on how
KVM/guest_memfd allocates/manages memory (e.g., whether it uses memory
allocated from core MM, if the memory is refcounted, or if the folio is
split) that are easily avoided. [1].

KVM's MMUs work with PFNs. This is very much an intentional design choice.
It ensures that the KVM MMUs remain flexible and are not too tightly tied
to the regular CPU MMUs and the kernel code around them. Using
"struct page" for TDX guest memory is not a good fit anywhere near the KVM
MMU code [2].

Therefore, for unmapping guest private memory: export
tdx_quirk_reset_paddr() for direct KVM invocation, and convert the SEAMCALL
wrapper API tdh_phymem_page_wbinvd_hkid() to take PFN as input (thus
updating mk_keyed_paddr() and tdh_phymem_page_wbinvd_tdr()).

Intentionally have KVM pass PAGE_SIZE (rather than KVM_HPAGE_SIZE(level))
to tdx_quirk_reset_paddr() in tdx_sept_remove_private_spte() to avoid
mixing in huge page changes. The KVM_BUG_ON() check for !PG_LEVEL_4K in
tdx_sept_remove_private_spte() justifies using PAGE_SIZE.

Do not convert tdx_reclaim_page() to use PFN as input since it currently
does not remove guest private memory.

Use "kvm_pfn_t pfn" for type safety. Using this KVM type is appropriate
since APIs tdh_phymem_page_wbinvd_hkid() and tdx_quirk_reset_paddr() are
exported to KVM only.

[Yan: Use kvm_pfn_t,exclude tdx_reclaim_page(),use tdx_quirk_reset_paddr()]

Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
Link: https://lore.kernel.org/all/aWgyhmTJphGQqO0Y@google.com [1]
Link: https://lore.kernel.org/all/ac7V0g2q2hN3dU5u@google.com [2]
---
 arch/x86/include/asm/tdx.h  | 14 +++++---------
 arch/x86/kvm/vmx/tdx.c      |  6 +++---
 arch/x86/virt/vmx/tdx/tdx.c |  9 +++++----
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 619aed134c83..65f7d874fb5a 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -154,6 +154,7 @@ u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
 
 void tdx_quirk_reset_page(struct page *page);
+void tdx_quirk_reset_paddr(unsigned long base, unsigned long size);
 
 struct tdx_td {
 	/* TD root structure: */
@@ -177,15 +178,10 @@ struct tdx_vp {
 	struct page **tdcx_pages;
 };
 
-static inline u64 mk_keyed_paddr(u16 hkid, struct page *page)
+static inline u64 mk_keyed_paddr(u16 hkid, kvm_pfn_t pfn)
 {
-	u64 ret;
-
-	ret = page_to_phys(page);
-	/* KeyID bits are just above the physical address bits: */
-	ret |= (u64)hkid << boot_cpu_data.x86_phys_bits;
-
-	return ret;
+	/* KeyID bits are just above the physical address bits. */
+	return PFN_PHYS(pfn) | ((u64)hkid << boot_cpu_data.x86_phys_bits);
 }
 
 u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
@@ -218,7 +214,7 @@ u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, enum pg_level level,
 			u64 *ext_err1, u64 *ext_err2);
 u64 tdh_phymem_cache_wb(bool resume);
 u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
-u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page);
+u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn);
 #else
 static inline void tdx_init(void) { }
 static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 9b47dd257ff4..a2aadc6d0174 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1774,8 +1774,8 @@ static int tdx_sept_free_private_spt(struct kvm *kvm, gfn_t gfn,
 static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 					 enum pg_level level, u64 mirror_spte)
 {
-	struct page *page = pfn_to_page(spte_to_pfn(mirror_spte));
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
+	kvm_pfn_t pfn = spte_to_pfn(mirror_spte);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 err, entry, level_state;
 
@@ -1814,11 +1814,11 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
 		return;
 
-	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, page);
+	err = tdh_phymem_page_wbinvd_hkid((u16)kvm_tdx->hkid, pfn);
 	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
 		return;
 
-	tdx_quirk_reset_page(page);
+	tdx_quirk_reset_paddr(PFN_PHYS(pfn), PAGE_SIZE);
 }
 
 void tdx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index b24b81cea5ea..e5a37ea2d4a0 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -710,7 +710,7 @@ static __init int tdmrs_set_up_pamt_all(struct tdmr_info_list *tdmr_list,
  * to normal kernel memory. Systems with the X86_BUG_TDX_PW_MCE erratum need to
  * do the conversion explicitly via MOVDIR64B.
  */
-static void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
+void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
 {
 	const void *zero_page = (const void *)page_address(ZERO_PAGE(0));
 	unsigned long phys, end;
@@ -729,6 +729,7 @@ static void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
 	 */
 	mb();
 }
+EXPORT_SYMBOL_FOR_KVM(tdx_quirk_reset_paddr);
 
 void tdx_quirk_reset_page(struct page *page)
 {
@@ -1920,17 +1921,17 @@ u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td)
 {
 	struct tdx_module_args args = {};
 
-	args.rcx = mk_keyed_paddr(tdx_global_keyid, td->tdr_page);
+	args.rcx = mk_keyed_paddr(tdx_global_keyid, page_to_pfn(td->tdr_page));
 
 	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_tdr);
 
-u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
+u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, kvm_pfn_t pfn)
 {
 	struct tdx_module_args args = {};
 
-	args.rcx = mk_keyed_paddr(hkid, page);
+	args.rcx = mk_keyed_paddr(hkid, pfn);
 
 	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
 }
-- 
2.43.2

