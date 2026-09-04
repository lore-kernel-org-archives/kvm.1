Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3079521221;
	Fri,  4 Sep 2026 21:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559203; cv=none; b=Kt0gtIX9Loa9eTqauwsW2Wygy04VlSG+AuM1Cu2UIMvAUl1xAzseWFVysWQnSsh2qqZnK7G53cs0w672CFN0T3zvAfwivUJncv350U0yWHDqH9INH5RCu1aEoQxBiIYUiQ9xV5wI8NifzefY4nucJ+LqcJNf/xPhu8lEzKkzYxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559203; c=relaxed/simple;
	bh=La5TSnve7LEhFz6cfbRU27H/X/gt9pcVEVuJ+3YN1X4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fdVJmrsAZGfSyiUnHcCP/XmUYzLtD1qx+TPgylI3FU0AIRwVWBuut94EwtQUOgMMohfojSCkxAAeLTZsC0hEJXvTuU4M19JIDyeGLltgqbMd+4LzJV/OxBxwcSwf5o1YXaDwnuVprfY5Qs/APb/Zv9PNRExIf9S5OREqmqURQTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=awaCV00b; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="awaCV00b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788559187; x=1820095187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=La5TSnve7LEhFz6cfbRU27H/X/gt9pcVEVuJ+3YN1X4=;
  b=awaCV00bUOa9HPalD52Igh7r+6TmOgl8ga1hdHRA07wd0BmQfBzQI5AD
   iczUoL6DQ8X2I9zEvqsIFOt2n/PW2JX/qqa7SI8E0Vd75ts9Jyohv1x9z
   JlDl2nFuzg7nVnE1DGjijayCZRcwapiPwz/i+vAdETmC9KHTAPYQMAa7h
   VbVQPu5OydPWByOcaXwS5NSjx8ofO+OWu1CMIQWSUdLtrxHR1PeFJSv7j
   tYyP9fZBAWecgEIC2Y2wvDYlYwzMlP36gt71SFX3YPsom6v1bO+fTDm8c
   lv+Bs2fwBUbjrPXwhqEJq2DciqDOoAU7d2jXr6hN/AleZ20LnGJ0zw6oT
   A==;
X-CSE-ConnectionGUID: 6TIJEcc5RIqgqtZEs0EAbw==
X-CSE-MsgGUID: w13kG/KRTWO90P+CBZ0yYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="100224842"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="100224842"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:24 -0700
X-CSE-ConnectionGUID: MXd1UodcTbqjufScAqouLQ==
X-CSE-MsgGUID: ds2Y/CSbTqKf/aM8cXoznw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; 
   d="scan'208";a="270675040"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2026 14:59:23 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: bp@alien8.de,
	dave.hansen@intel.com,
	hpa@zytor.com,
	kas@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com,
	seanjc@google.com,
	tglx@kernel.org,
	vannapurve@google.com,
	x86@kernel.org,
	chao.gao@intel.com,
	yan.y.zhao@intel.com,
	kai.huang@intel.com,
	tony.lindgren@linux.intel.com,
	binbin.wu@intel.com,
	sohil.mehta@intel.com
Cc: rick.p.edgecombe@intel.com,
	Hongyu Ning <hongyu.ning@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v11 06/11] KVM: TDX: Allocate PAMT memory for TD and vCPU control structures
Date: Fri,  4 Sep 2026 14:58:36 -0700
Message-ID: <20260904215841.303070-7-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
References: <20260904215841.303070-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Use control page helpers for allocating and freeing TD control structures,
such that these operations can work for Dynamic PAMT.

The TDX module tracks some state for each page of physical memory that it
might use. It calls this state the PAMT. It includes separate state for
each page size a physical page could be utilized at within the TDX module
(1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
allocated dynamically. So the kernel must ensure PAMT backing is installed
for any 4KB page being gifted to the TDX module, and must tear down the
backing when all associated gifted pages are reclaimed.

TD scoped control pages (TDR, TDCS) and vCPU scoped control pages (TDVPR,
TDCX) are all handed to the TDX module at 4KB page size and are therefore
subject to this requirement. Replace the raw alloc_page()/__free_page()
calls for these pages with tdx_alloc/free_control_page().

Switching between special Dynamic PAMT operations or normal page
alloc/free operations is handled internally in
tdx_alloc/free_control_page(). So don't check for Dynamic PAMT around these
calls. Just call them unconditionally. Similarly, drop the NULL checks
before freeing, as tdx_free_control_page() handles NULL internally.

No functional change intended when DPAMT is not in use.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
[sean: handle alloc+free+reclaim in one patch]
Signed-off-by: Sean Christopherson <seanjc@google.com>
[rick: enhance log, reviewing, rebase, with help from AI tooling]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Vishal Annapurve <vannapurve@google.com>
Acked-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Sean Christopherson <seanjc@google.com>
---
v7:
 - Fixup tags (Sean)
 - Missing word in log (Binbin)
 - Log smoothness (Yan)
---
 arch/x86/kvm/vmx/tdx.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index b272c20586a74..3592596b5649a 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -362,7 +362,7 @@ static void tdx_reclaim_control_page(struct page *ctrl_page)
 	if (tdx_reclaim_page(ctrl_page))
 		return;
 
-	__free_page(ctrl_page);
+	tdx_free_control_page(ctrl_page);
 }
 
 struct tdx_flush_vp_arg {
@@ -589,7 +589,7 @@ static void tdx_reclaim_td_control_pages(struct kvm *kvm)
 
 	tdx_quirk_reset_paddr(page_to_phys(kvm_tdx->td.tdr_page), PAGE_SIZE);
 
-	__free_page(kvm_tdx->td.tdr_page);
+	tdx_free_control_page(kvm_tdx->td.tdr_page);
 	kvm_tdx->td.tdr_page = NULL;
 }
 
@@ -2456,7 +2456,7 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 
 	ret = -ENOMEM;
 
-	tdr_page = alloc_page(GFP_KERNEL_ACCOUNT);
+	tdr_page = tdx_alloc_control_page();
 	if (!tdr_page)
 		goto free_hkid;
 
@@ -2469,7 +2469,7 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 		goto free_tdr;
 
 	for (i = 0; i < kvm_tdx->td.tdcs_nr_pages; i++) {
-		tdcs_pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
+		tdcs_pages[i] = tdx_alloc_control_page();
 		if (!tdcs_pages[i])
 			goto free_tdcs;
 	}
@@ -2587,10 +2587,8 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 teardown:
 	/* Only free pages not yet added, so start at 'i' */
 	for (; i < kvm_tdx->td.tdcs_nr_pages; i++) {
-		if (tdcs_pages[i]) {
-			__free_page(tdcs_pages[i]);
-			tdcs_pages[i] = NULL;
-		}
+		tdx_free_control_page(tdcs_pages[i]);
+		tdcs_pages[i] = NULL;
 	}
 	if (!kvm_tdx->td.tdcs_pages)
 		kfree(tdcs_pages);
@@ -2605,16 +2603,13 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 	free_cpumask_var(packages);
 
 free_tdcs:
-	for (i = 0; i < kvm_tdx->td.tdcs_nr_pages; i++) {
-		if (tdcs_pages[i])
-			__free_page(tdcs_pages[i]);
-	}
+	for (i = 0; i < kvm_tdx->td.tdcs_nr_pages; i++)
+		tdx_free_control_page(tdcs_pages[i]);
 	kfree(tdcs_pages);
 	kvm_tdx->td.tdcs_pages = NULL;
 
 free_tdr:
-	if (tdr_page)
-		__free_page(tdr_page);
+	tdx_free_control_page(tdr_page);
 	kvm_tdx->td.tdr_page = NULL;
 
 free_hkid:
@@ -2948,7 +2943,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	int ret, i;
 	u64 err;
 
-	page = alloc_page(GFP_KERNEL_ACCOUNT);
+	page = tdx_alloc_control_page();
 	if (!page)
 		return -ENOMEM;
 	tdx->vp.tdvpr_page = page;
@@ -2968,7 +2963,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	}
 
 	for (i = 0; i < kvm_tdx->td.tdcx_nr_pages; i++) {
-		page = alloc_page(GFP_KERNEL_ACCOUNT);
+		page = tdx_alloc_control_page();
 		if (!page) {
 			ret = -ENOMEM;
 			goto free_tdcx;
@@ -2990,7 +2985,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 			 * method, but the rest are freed here.
 			 */
 			for (; i < kvm_tdx->td.tdcx_nr_pages; i++) {
-				__free_page(tdx->vp.tdcx_pages[i]);
+				tdx_free_control_page(tdx->vp.tdcx_pages[i]);
 				tdx->vp.tdcx_pages[i] = NULL;
 			}
 			return -EIO;
@@ -3018,16 +3013,14 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 
 free_tdcx:
 	for (i = 0; i < kvm_tdx->td.tdcx_nr_pages; i++) {
-		if (tdx->vp.tdcx_pages[i])
-			__free_page(tdx->vp.tdcx_pages[i]);
+		tdx_free_control_page(tdx->vp.tdcx_pages[i]);
 		tdx->vp.tdcx_pages[i] = NULL;
 	}
 	kfree(tdx->vp.tdcx_pages);
 	tdx->vp.tdcx_pages = NULL;
 
 free_tdvpr:
-	if (tdx->vp.tdvpr_page)
-		__free_page(tdx->vp.tdvpr_page);
+	tdx_free_control_page(tdx->vp.tdvpr_page);
 	tdx->vp.tdvpr_page = NULL;
 	tdx->vp.tdvpr_pa = 0;
 
-- 
2.55.0

