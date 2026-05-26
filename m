Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3F130E83F;
	Tue, 26 May 2026 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762937; cv=none; b=AKRw3fDHLR61d236K8Fpf1d5FPSkZnaszaM5kgMHIs6wzeXtO3busolGS0fKHrtTpHnV5jmoxUxJtRej3eAJQGG2H1D4R/tY6ul/U+4nY6MN0LhQ8ShN48pHGxgvOIMpGKXMUsvngvLGJd0uYMt56s7X0Yy9HT6ZLDvDWKzX3rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762937; c=relaxed/simple;
	bh=6OPqLGzID/8yWm6UrSRl+4VbyudTj8S0aIJtkM1Jl78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKe4/nnRFuwjvgS0QV1jJCUcULuP9TIRJ7u0PzBNroiLBE5cjQkgq7h9ES70O6ZEjgH59jfyBXpvZdFIbXYeVJXeYndv285kQpoTE7m9fC7tolXTkS2yHGZ0fc4cm60i58dKX7X6MBETTxUOnDWxv6OPCaZHnbMkPu3dg5rWELE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+9gfAAt; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+9gfAAt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779762936; x=1811298936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6OPqLGzID/8yWm6UrSRl+4VbyudTj8S0aIJtkM1Jl78=;
  b=n+9gfAAtuFNeAEHXjvZHUmiZDRt95J61GqrUYQkFEYsLo8WPp3JiLkZj
   u0r1A+0AU6qZ1Euuh+m9LB9hdlcgFNWQb3KyJT59zvJRLeEcLWH/1HXD9
   xh1OH0SBjKNq3VMNc/i2KxY8ZbN1E3qS7bcmvz9JvqP2DMfLBBTFnambN
   4+QLY8vvx9upvlNtmw4JQlKg2Tj6q2M6CQHdOC/trxvoMAncbUnmM1Jm8
   hLcsJMq1/5QcfqwFk7lpemP1RscWP443bvQKhBBYQ+WHEsRQOn5NNlzyA
   XCXSCiolKwrz2e6V92cOwv8XRzPPSWARSlr2p1HYoQiL7ZzsYTlKsssx2
   Q==;
X-CSE-ConnectionGUID: FZ6gjSCbQy6K1i6wLd1wpg==
X-CSE-MsgGUID: YY3XCIaGS9OmRKE61yfwmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="91677829"
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="91677829"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:24 -0700
X-CSE-ConnectionGUID: n2GKC6uIShyxAra1m/l7jQ==
X-CSE-MsgGUID: oV/Ws18ZSHi1aErTacyYIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,168,1774335600"; 
   d="scan'208";a="279878313"
Received: from rpedgeco-desk.jf.intel.com ([10.88.27.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2026 19:35:24 -0700
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
	kai.huang@intel.com
Cc: rick.p.edgecombe@intel.com,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v6 07/11] KVM: TDX: Allocate PAMT memory for TD and vCPU control structures
Date: Mon, 25 May 2026 19:35:11 -0700
Message-ID: <20260526023515.288829-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
References: <20260526023515.288829-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

Use control page helpers for allocating and freeing TD control structures,
such these operations can work for Dynamic PAMT.

The TDX module tracks some state for each page of physical memory that it
might use. It calls this state the PAMT. It includes separate state for
each page size a physical page could be utilized at within the TDX module
(1GB, 2MB, 4KB). In Dynamic PAMT, only the 4KB page size state is
allocated dynamically. So the kernel must install PAMT backing for each 4KB
page before gifting it to the TDX module, and tear it down after the page
is reclaimed.

TD-scoped control pages (TDR, TDCS) and vCPU-scoped control pages (TDVPR,
TDCX) are all handed to the TDX module at 4KB page size and are therefore
subject to this requirement. Replace the raw alloc_page()/__free_page()
calls for these pages with tdx_alloc/free_control_page().

Switching between special Dynamic PAMT operations or normal page
alloc/free operations is handled internally in
tdx_alloc/free_control_page(). So don't check for Dynamic PAMT around these
calls. Just call them unconditionally. Similarly, drop the NULL checks
before freeing, as tdx_free_control_page() handles NULL internally.

No functional change intended when Dynamic PAMT is not in use.

Assisted-by: GitHub Copilot:claude-opus-4-6 Claude:claude-opus-4-7
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
[sean: handle alloc+free+reclaim in one patch]
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
[Rick: enhance log]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kvm/vmx/tdx.c | 35 ++++++++++++++---------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 2539107e0ad3d..3e67e2471ffe3 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -362,7 +362,7 @@ static void tdx_reclaim_control_page(struct page *ctrl_page)
 	if (tdx_reclaim_page(ctrl_page))
 		return;
 
-	__free_page(ctrl_page);
+	tdx_free_control_page(ctrl_page);
 }
 
 struct tdx_flush_vp_arg {
@@ -599,7 +599,7 @@ static void tdx_reclaim_td_control_pages(struct kvm *kvm)
 
 	tdx_quirk_reset_paddr(page_to_phys(kvm_tdx->td.tdr_page), PAGE_SIZE);
 
-	__free_page(kvm_tdx->td.tdr_page);
+	tdx_free_control_page(kvm_tdx->td.tdr_page);
 	kvm_tdx->td.tdr_page = NULL;
 }
 
@@ -2444,7 +2444,7 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 
 	ret = -ENOMEM;
 
-	tdr_page = alloc_page(GFP_KERNEL_ACCOUNT);
+	tdr_page = tdx_alloc_control_page();
 	if (!tdr_page)
 		goto free_hkid;
 
@@ -2458,7 +2458,7 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
 		goto free_tdr;
 
 	for (i = 0; i < kvm_tdx->td.tdcs_nr_pages; i++) {
-		tdcs_pages[i] = alloc_page(GFP_KERNEL_ACCOUNT);
+		tdcs_pages[i] = tdx_alloc_control_page();
 		if (!tdcs_pages[i])
 			goto free_tdcs;
 	}
@@ -2576,10 +2576,8 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
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
@@ -2594,16 +2592,13 @@ static int __tdx_td_init(struct kvm *kvm, struct td_params *td_params,
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
@@ -2933,7 +2928,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	int ret, i;
 	u64 err;
 
-	page = alloc_page(GFP_KERNEL_ACCOUNT);
+	page = tdx_alloc_control_page();
 	if (!page)
 		return -ENOMEM;
 	tdx->vp.tdvpr_page = page;
@@ -2953,7 +2948,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 	}
 
 	for (i = 0; i < kvm_tdx->td.tdcx_nr_pages; i++) {
-		page = alloc_page(GFP_KERNEL_ACCOUNT);
+		page = tdx_alloc_control_page();
 		if (!page) {
 			ret = -ENOMEM;
 			goto free_tdcx;
@@ -2975,7 +2970,7 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 			 * method, but the rest are freed here.
 			 */
 			for (; i < kvm_tdx->td.tdcx_nr_pages; i++) {
-				__free_page(tdx->vp.tdcx_pages[i]);
+				tdx_free_control_page(tdx->vp.tdcx_pages[i]);
 				tdx->vp.tdcx_pages[i] = NULL;
 			}
 			return -EIO;
@@ -3003,16 +2998,14 @@ static int tdx_td_vcpu_init(struct kvm_vcpu *vcpu, u64 vcpu_rcx)
 
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

