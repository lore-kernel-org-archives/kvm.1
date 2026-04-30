Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46F1286419;
	Thu, 30 Apr 2026 02:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516198; cv=none; b=HM+L4WagZnTmj1nxeMubdnkq5YRGtDf75OtnnAOqvviacL+VYAjLyiohDKK9LXAtvpgQFFKsyuAE3TVOvE+r14cfrj7qCKDlj0cfrUh0fQHwbnZ0rhAKTUMPn7+QZZBuPAZK7+WJ+ABHxkrvPRHF4LlurU7dASeSFOM/l0Gpku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516198; c=relaxed/simple;
	bh=7g2f6LCTv8f/LvX4WFfquF4gdXy5ZEpwx3NFWtieX7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uin+kYhqNw1YVhEmWy70Ah9o/e4+o1mVsGwrsa+7e3XN15Kneib5aJ88dapTCa9lhxl2hZvRSnPMOT1b5JzvzxQO0JqnW2DTa/cogQtGeLlGHJ15Gtok4RnugUP0Dk/6+j5BKb2lbs9RflAXMIH6YS9YT6PzVe0c46ghtyN2q98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=duEdYARn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="duEdYARn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777516198; x=1809052198;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7g2f6LCTv8f/LvX4WFfquF4gdXy5ZEpwx3NFWtieX7A=;
  b=duEdYARnnGSCPCR2s1lSlzo8CsMx0ROmOPevXamBGqEZMEokIS8/9Fvi
   N9Ijfmosn4UMrrj1KxyxgY5z+2otqGDYVJWiyXBH6sKDfSH/tM0Fk1lmL
   VhPep32P2YhmYjAd1FI61GFbk0XgTbbMcngvJFodOSiVT84tOChHujd1Q
   Wk0P0ZahCmfMTo7PM2b/9/dA5wG/HuWb7ZCNZpVIXNFxZql7xmHE37FmM
   L8nq1Aabl2fWGpEA2sAxSE9S2VrFFuhAv+bETTkBVEs6qwLb2LLWeLMWi
   X1vNWOW+hARQ7uhbIACryBRfDx3NgPRAPRLQBMCFaje9471qyGR86l9ta
   Q==;
X-CSE-ConnectionGUID: 6WpPIblFRueyc/2+rGRY7A==
X-CSE-MsgGUID: 1TT3xb5lSISXXX6u7VwyKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88770192"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="88770192"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:29:53 -0700
X-CSE-ConnectionGUID: am+iOdmfTfCE/+xNRkyzxA==
X-CSE-MsgGUID: bjtP4w3/TzCdiy5M9m0YHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="230090172"
Received: from yzhao56-desk.sh.intel.com ([10.239.47.19])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 19:29:48 -0700
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
Subject: [PATCH v2 3/4] x86/tdx: Drop exported function tdx_quirk_reset_page()
Date: Thu, 30 Apr 2026 09:50:01 +0800
Message-ID: <20260430015001.24242-1-yan.y.zhao@intel.com>
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

KVM invokes tdx_quirk_reset_page() to reset TDX control pages (including
S-EPT pages, TDR page, etc.), as all those pages are allocated by KVM TDX
and thus always have struct page.

However, it's also reasonable for KVM to reset those TDX control pages via
tdx_quirk_reset_paddr() directly, eliminating the need to export two
parallel APIs. Keeping tdx_quirk_reset_page() as a one-line helper in the
header file is also unnecessary.

No functional change intended.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
---
 arch/x86/include/asm/tdx.h  | 1 -
 arch/x86/kvm/vmx/tdx.c      | 4 ++--
 arch/x86/virt/vmx/tdx/tdx.c | 6 ------
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 65f7d874fb5a..9c63deaa0e8f 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -153,7 +153,6 @@ int tdx_guest_keyid_alloc(void);
 u32 tdx_get_nr_guest_keyids(void);
 void tdx_guest_keyid_free(unsigned int keyid);
 
-void tdx_quirk_reset_page(struct page *page);
 void tdx_quirk_reset_paddr(unsigned long base, unsigned long size);
 
 struct tdx_td {
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index a2aadc6d0174..9bd4fd748e2a 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -343,7 +343,7 @@ static int tdx_reclaim_page(struct page *page)
 
 	r = __tdx_reclaim_page(page);
 	if (!r)
-		tdx_quirk_reset_page(page);
+		tdx_quirk_reset_paddr(page_to_phys(page), PAGE_SIZE);
 	return r;
 }
 
@@ -597,7 +597,7 @@ static void tdx_reclaim_td_control_pages(struct kvm *kvm)
 	if (TDX_BUG_ON(err, TDH_PHYMEM_PAGE_WBINVD, kvm))
 		return;
 
-	tdx_quirk_reset_page(kvm_tdx->td.tdr_page);
+	tdx_quirk_reset_paddr(page_to_phys(kvm_tdx->td.tdr_page), PAGE_SIZE);
 
 	__free_page(kvm_tdx->td.tdr_page);
 	kvm_tdx->td.tdr_page = NULL;
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index e5a37ea2d4a0..deb67e68f85f 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -731,12 +731,6 @@ void tdx_quirk_reset_paddr(unsigned long base, unsigned long size)
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_quirk_reset_paddr);
 
-void tdx_quirk_reset_page(struct page *page)
-{
-	tdx_quirk_reset_paddr(page_to_phys(page), PAGE_SIZE);
-}
-EXPORT_SYMBOL_FOR_KVM(tdx_quirk_reset_page);
-
 static __init void tdmr_quirk_reset_pamt(struct tdmr_info *tdmr)
 
 {
-- 
2.43.2

