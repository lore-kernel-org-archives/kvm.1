Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153830E838;
	Sat, 25 Jul 2026 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784939008; cv=none; b=CTnaL5KTwTAEf5NHPCg030Tynn0jvCF8FURuQ8m3BKvojmgBTB4KflRxJCL33CqQvqlHxGBGtPll8MzLIqQ4yt3PujASG5HT3cH3lePo+IvEXiSLVbOmn8Lf+FZ35ycvpMEI6mOgFBkUf9mgUQHUm+uRwunjQercnEh51aJzpqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784939008; c=relaxed/simple;
	bh=fBTE4o0H+5y1dQJ1IRJDFzRZJVqzVEktm8pvAFRj3Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m0J5h1+BD892T1gLTqfEdH4V3wBSj+ZCeQU37wAx9x8fdr9GJkldaYDHKEMOyRynAszXjSehcPDKyZWdJttODnwnmcSU3RCw1FpIb5cjGH23s6u8C9g6fdSt7YqA3QDp0wbg3x6ZmbGL4jCXHRkbMas/iYlHD4OFxXhxV1/4vfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyXds5Ew; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyXds5Ew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784938995; x=1816474995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fBTE4o0H+5y1dQJ1IRJDFzRZJVqzVEktm8pvAFRj3Yo=;
  b=LyXds5EwawPA5o0JNlsJ4o8GUNWH1nfQJSaOw3opyQAQnWdWRG5geToD
   mXfJ0QL9OqS2hFWEBh+CHiqJpsPczRtNrraaS4sU0sPWotq2c/4QloYzv
   QVQO6N4ZNGbuEYgK7+P7eoXgCE+bv6Wz+FLOvDxQboYWeNwf7N/9ymWJO
   v7IZ99QAxZeFdWqVxGppsNodQkguVImU8V1T/PV82SiBt9zadVzMSCi0b
   tj52X3nADfI6CofJb2HISejefsRhN3giCmlEbitLT4gMLWZxtJUfDOhVT
   AwRAsyDtRT7IkEIBKnNrlA6EeiwjONHKsog1CFNafOxdCpCjn5rMAIj8G
   g==;
X-CSE-ConnectionGUID: KLPWEX5ZS3Cft0mHd/MJfw==
X-CSE-MsgGUID: E/T8Of+kSCqBFVLai5ToNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="85726155"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="85726155"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:11 -0700
X-CSE-ConnectionGUID: 3VeeEaLoRLC81rHGDYcQsw==
X-CSE-MsgGUID: 5piTDlfUTNuNRHuMrGpbqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="262359265"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.135])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 17:23:11 -0700
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
	Binbin Wu <binbin.wu@linux.intel.com>
Subject: [PATCH v8 06/11] KVM: TDX: Allocate PAMT memory for TD and vCPU control structures
Date: Fri, 24 Jul 2026 17:22:56 -0700
Message-ID: <20260725002302.3337017-7-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
References: <20260725002302.3337017-1-rick.p.edgecombe@intel.com>
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

No functional change intended when Dynamic PAMT is not in use.

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
index 545b03d9d10b8..957078e8656ef 100644
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
 
@@ -2459,7 +2459,7 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 
 	ret = -ENOMEM;
 
-	tdr_page = alloc_page(GFP_KERNEL_ACCOUNT);
+	tdr_page = tdx_alloc_control_page();
 	if (!tdr_page)
 		goto free_hkid;
 
@@ -2472,7 +2472,7 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 		goto free_tdr;
 
 	for (i = 0; i < kvm_tdx->td.tdcs_nr_pages; i++) {
-		tdcs_pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
+		tdcs_pages[i] = tdx_alloc_control_page();
 		if (!tdcs_pages[i])
 			goto free_tdcs;
 	}
@@ -2590,10 +2590,8 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
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
@@ -2608,16 +2606,13 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
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
@@ -2951,7 +2946,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	int ret, i;
 	u64 err;
 
-	page = alloc_page(GFP_KERNEL_ACCOUNT);
+	page = tdx_alloc_control_page();
 	if (!page)
 		return -ENOMEM;
 	tdx->vp.tdvpr_page = page;
@@ -2971,7 +2966,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	}
 
 	for (i = 0; i < kvm_tdx->td.tdcx_nr_pages; i++) {
-		page = alloc_page(GFP_KERNEL_ACCOUNT);
+		page = tdx_alloc_control_page();
 		if (!page) {
 			ret = -ENOMEM;
 			goto free_tdcx;
@@ -2993,7 +2988,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 			 * method, but the rest are freed here.
 			 */
 			for (; i < kvm_tdx->td.tdcx_nr_pages; i++) {
-				__free_page(tdx->vp.tdcx_pages[i]);
+				tdx_free_control_page(tdx->vp.tdcx_pages[i]);
 				tdx->vp.tdcx_pages[i] = NULL;
 			}
 			return -EIO;
@@ -3021,16 +3016,14 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 
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
2.54.0

