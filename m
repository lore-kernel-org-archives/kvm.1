Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190A7391846;
	Fri, 27 Mar 2026 20:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642469; cv=none; b=Pqxru7mzapQuS+DS2+wGnaCSWM6ZO1G5L6VFsZRMv4Tg0AnrC6hKdEtJ3KiAGVcklG6XzVUP0taoEDITuz5Ujp/IG3RtXzO9rmmLHbxQl/FMOhw/dVFTTzEKg7jAOtUnLaGXEXistz08s+WnLwrGjWQ6/IboaWFdz291iB6k36s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642469; c=relaxed/simple;
	bh=LHUZQ0C68NCKk4sQ2cqrZIJBg5G6QZSyv4anzWHlrH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tir/Cn14KyKGCq61hsPcAOpYLcs0yJptPvImeVPGMzwsEN8Yd5Mds/0NEu9t12qLRUkakuv+Sm2/a75q+13ZBkuVMejrki4Vr6HDvDzKP+DqQBSDRORKP7Yxko/gYUpz0ASDrBrkbuG93mQJGquoYuSqZc0qAe8kEkqEbeM3cdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BbxUnPIq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BbxUnPIq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774642468; x=1806178468;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LHUZQ0C68NCKk4sQ2cqrZIJBg5G6QZSyv4anzWHlrH0=;
  b=BbxUnPIqttpr2QcCp821ptvOnY/bmtV7Oxfx3ipjx/M/LUHG886dgmod
   rdEvXJT2460vrE35tKFLKFLQ7svQCcboKeY0A/NCIhDvbREcw4Appwkf8
   +mx4sUu400D932Z1nYEV30hlss3kn8wEh+HTdLUfyGinwVcyqjjJ0meEq
   BnPx/C3gmCsxABpZMirnbJrZAx9c1FVLvCa4R0F2h9uwJbPI0JVPBAJB1
   5wohWGvwPeR1x8E8tBEf/96bKVSLyQKzbyP3fLtaPBtDS4vZgmVGySmhj
   Ws15uBboFY2iSWM3HOTpGca7SEc7fHChxWyMP4n4WkmZfvX9ssmO1L5YU
   Q==;
X-CSE-ConnectionGUID: CkyQtUOZT8maT7T0a52qAA==
X-CSE-MsgGUID: CRR9BnT4QBuRM99xwDHyPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="101182705"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="101182705"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:27 -0700
X-CSE-ConnectionGUID: Qw0RE6w2TrqqcCmEU2vh5Q==
X-CSE-MsgGUID: UJ4m9BzHQ9Odteo2sZDc7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="255922889"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 13:14:26 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: seanjc@google.com,
	pbonzini@redhat.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	kvm@vger.kernel.org,
	kas@kernel.org
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	dave.hansen@intel.com,
	rick.p.edgecombe@intel.com
Subject: [PATCH 01/17] x86/tdx: Use pg_level in TDX APIs, not the TDX-Module's 0-based level
Date: Fri, 27 Mar 2026 13:14:05 -0700
Message-ID: <20260327201421.2824383-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
References: <20260327201421.2824383-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Christopherson <seanjc@google.com>

Rework the TDX APIs to take the kernel's 1-based pg_level enum, not the
TDX-Module's 0-based level.  The APIs are _kernel_ APIs, not TDX-Module
APIs, and the kernel (and KVM) uses "enum pg_level" literally everywhere.

Using "enum pg_level" eliminates ambiguity when looking at the APIs (it's
NOT clear that "int level" refers to the TDX-Module's level), and will
allow for using existing helpers like page_level_size() when support for
hugepages is added to the S-EPT APIs.

No functional change intended.

Cc: Kai Huang <kai.huang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>
Cc: Vishal Annapurve <vannapurve@google.com>
Cc: Ackerley Tng <ackerleytng@google.com>
Acked-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/tdx.h  | 14 ++++----------
 arch/x86/kvm/vmx/tdx.c      | 11 ++++-------
 arch/x86/virt/vmx/tdx/tdx.c | 26 ++++++++++++++++++--------
 3 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index a149740b24e8..c140ddde59ff 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -187,19 +187,13 @@ static inline u64 mk_keyed_paddr(u16 hkid, struct page *page)
 	return ret;
 }
 
-static inline int pg_level_to_tdx_sept_level(enum pg_level level)
-{
-        WARN_ON_ONCE(level == PG_LEVEL_NONE);
-        return level - 1;
-}
-
 u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
 u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page);
 u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, struct page *source, u64 *ext_err1, u64 *ext_err2);
-u64 tdh_mem_sept_add(struct tdx_td *td, u64 gpa, int level, struct page *page, u64 *ext_err1, u64 *ext_err2);
+u64 tdh_mem_sept_add(struct tdx_td *td, u64 gpa, enum pg_level level, struct page *page, u64 *ext_err1, u64 *ext_err2);
 u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page);
-u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, struct page *page, u64 *ext_err1, u64 *ext_err2);
-u64 tdh_mem_range_block(struct tdx_td *td, u64 gpa, int level, u64 *ext_err1, u64 *ext_err2);
+u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, enum pg_level level, struct page *page, u64 *ext_err1, u64 *ext_err2);
+u64 tdh_mem_range_block(struct tdx_td *td, u64 gpa, enum pg_level level, u64 *ext_err1, u64 *ext_err2);
 u64 tdh_mng_key_config(struct tdx_td *td);
 u64 tdh_mng_create(struct tdx_td *td, u16 hkid);
 u64 tdh_vp_create(struct tdx_td *td, struct tdx_vp *vp);
@@ -215,7 +209,7 @@ u64 tdh_vp_rd(struct tdx_vp *vp, u64 field, u64 *data);
 u64 tdh_vp_wr(struct tdx_vp *vp, u64 field, u64 data, u64 mask);
 u64 tdh_phymem_page_reclaim(struct page *page, u64 *tdx_pt, u64 *tdx_owner, u64 *tdx_size);
 u64 tdh_mem_track(struct tdx_td *tdr);
-u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, u64 level, u64 *ext_err1, u64 *ext_err2);
+u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, enum pg_level level, u64 *ext_err1, u64 *ext_err2);
 u64 tdh_phymem_cache_wb(bool resume);
 u64 tdh_phymem_page_wbinvd_tdr(struct tdx_td *td);
 u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page);
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 1e47c194af53..38e7b6fa8664 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -1638,14 +1638,13 @@ static int tdx_mem_page_add(struct kvm *kvm, gfn_t gfn, enum pg_level level,
 static int tdx_mem_page_aug(struct kvm *kvm, gfn_t gfn,
 			    enum pg_level level, kvm_pfn_t pfn)
 {
-	int tdx_level = pg_level_to_tdx_sept_level(level);
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	struct page *page = pfn_to_page(pfn);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 entry, level_state;
 	u64 err;
 
-	err = tdh_mem_page_aug(&kvm_tdx->td, gpa, tdx_level, page, &entry, &level_state);
+	err = tdh_mem_page_aug(&kvm_tdx->td, gpa, level, page, &entry, &level_state);
 	if (unlikely(tdx_operand_busy(err)))
 		return -EBUSY;
 
@@ -1689,12 +1688,11 @@ static int tdx_sept_set_private_spte(struct kvm *kvm, gfn_t gfn,
 static int tdx_sept_link_private_spt(struct kvm *kvm, gfn_t gfn,
 				     enum pg_level level, void *private_spt)
 {
-	int tdx_level = pg_level_to_tdx_sept_level(level);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	struct page *page = virt_to_page(private_spt);
 	u64 err, entry, level_state;
 
-	err = tdh_mem_sept_add(&to_kvm_tdx(kvm)->td, gpa, tdx_level, page, &entry,
+	err = tdh_mem_sept_add(&to_kvm_tdx(kvm)->td, gpa, level, page, &entry,
 			       &level_state);
 	if (unlikely(tdx_operand_busy(err)))
 		return -EBUSY;
@@ -1778,7 +1776,6 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 					 enum pg_level level, u64 mirror_spte)
 {
 	struct page *page = pfn_to_page(spte_to_pfn(mirror_spte));
-	int tdx_level = pg_level_to_tdx_sept_level(level);
 	struct kvm_tdx *kvm_tdx = to_kvm_tdx(kvm);
 	gpa_t gpa = gfn_to_gpa(gfn);
 	u64 err, entry, level_state;
@@ -1798,7 +1795,7 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 		return;
 
 	err = tdh_do_no_vcpus(tdh_mem_range_block, kvm, &kvm_tdx->td, gpa,
-			      tdx_level, &entry, &level_state);
+			      level, &entry, &level_state);
 	if (TDX_BUG_ON_2(err, TDH_MEM_RANGE_BLOCK, entry, level_state, kvm))
 		return;
 
@@ -1814,7 +1811,7 @@ static void tdx_sept_remove_private_spte(struct kvm *kvm, gfn_t gfn,
 	 * Race with TDH.VP.ENTER due to (0-step mitigation) and Guest TDCALLs.
 	 */
 	err = tdh_do_no_vcpus(tdh_mem_page_remove, kvm, &kvm_tdx->td, gpa,
-			      tdx_level, &entry, &level_state);
+			      level, &entry, &level_state);
 	if (TDX_BUG_ON_2(err, TDH_MEM_PAGE_REMOVE, entry, level_state, kvm))
 		return;
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index cb9b3210ab71..a6e77afafa79 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1568,6 +1568,12 @@ static void tdx_clflush_page(struct page *page)
 	clflush_cache_range(page_to_virt(page), PAGE_SIZE);
 }
 
+static int pg_level_to_tdx_sept_level(enum pg_level level)
+{
+	WARN_ON_ONCE(level == PG_LEVEL_NONE);
+	return level - 1;
+}
+
 noinstr u64 tdh_vp_enter(struct tdx_vp *td, struct tdx_module_args *args)
 {
 	args->rcx = td->tdvpr_pa;
@@ -1608,10 +1614,11 @@ u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, struct page
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_add);
 
-u64 tdh_mem_sept_add(struct tdx_td *td, u64 gpa, int level, struct page *page, u64 *ext_err1, u64 *ext_err2)
+u64 tdh_mem_sept_add(struct tdx_td *td, u64 gpa, enum pg_level level,
+		     struct page *page, u64 *ext_err1, u64 *ext_err2)
 {
 	struct tdx_module_args args = {
-		.rcx = gpa | level,
+		.rcx = gpa | pg_level_to_tdx_sept_level(level),
 		.rdx = tdx_tdr_pa(td),
 		.r8 = page_to_phys(page),
 	};
@@ -1639,10 +1646,11 @@ u64 tdh_vp_addcx(struct tdx_vp *vp, struct page *tdcx_page)
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_vp_addcx);
 
-u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, struct page *page, u64 *ext_err1, u64 *ext_err2)
+u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, enum pg_level level,
+		     struct page *page, u64 *ext_err1, u64 *ext_err2)
 {
 	struct tdx_module_args args = {
-		.rcx = gpa | level,
+		.rcx = gpa | pg_level_to_tdx_sept_level(level),
 		.rdx = tdx_tdr_pa(td),
 		.r8 = page_to_phys(page),
 	};
@@ -1658,10 +1666,11 @@ u64 tdh_mem_page_aug(struct tdx_td *td, u64 gpa, int level, struct page *page, u
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_mem_page_aug);
 
-u64 tdh_mem_range_block(struct tdx_td *td, u64 gpa, int level, u64 *ext_err1, u64 *ext_err2)
+u64 tdh_mem_range_block(struct tdx_td *td, u64 gpa, enum pg_level level,
+			u64 *ext_err1, u64 *ext_err2)
 {
 	struct tdx_module_args args = {
-		.rcx = gpa | level,
+		.rcx = gpa | pg_level_to_tdx_sept_level(level),
 		.rdx = tdx_tdr_pa(td),
 	};
 	u64 ret;
@@ -1874,10 +1883,11 @@ u64 tdh_mem_track(struct tdx_td *td)
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_mem_track);
 
-u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, u64 level, u64 *ext_err1, u64 *ext_err2)
+u64 tdh_mem_page_remove(struct tdx_td *td, u64 gpa, enum pg_level level,
+			u64 *ext_err1, u64 *ext_err2)
 {
 	struct tdx_module_args args = {
-		.rcx = gpa | level,
+		.rcx = gpa | pg_level_to_tdx_sept_level(level),
 		.rdx = tdx_tdr_pa(td),
 	};
 	u64 ret;
-- 
2.53.0

