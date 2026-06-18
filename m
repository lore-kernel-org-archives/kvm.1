Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586D3B71DF;
	Thu, 18 Jun 2026 08:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771990; cv=none; b=JPasy8GajlGZj4Oo9ypgOwo7LNm+S4tS2C9gxeiFewruGiWpgAxxctfspABMVcKyqit9riB6D9vpIkVjmFRPm46lUUqN+Z2bvV5y2W4608WNmUf015L+7H4unIuwfYJqgJ9no70zkifRIVimQnyB9oK9ZrGJSkJq+cPtbqOClpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771990; c=relaxed/simple;
	bh=3+nT59Inevi+Wy6wG8kIEX591XLYmou7GOU/f0UPrj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AUx5EOvQ/M2KZf+U0daaFSKwuxyxuO16TLxVc1P3VnmKKwkVyPnwP3LFEJdq21aBQotybtJo5V9lBkDVwR/hQxi+sL0DV+yd2d5zXoRQhCH+gCpJc5iRyM4BPpcrTNdRJ3GrTiw1jL2G0wGKEpl6u9T71NGE6NNCHd0aof6eDro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aT3AeGGj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aT3AeGGj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781771988; x=1813307988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3+nT59Inevi+Wy6wG8kIEX591XLYmou7GOU/f0UPrj8=;
  b=aT3AeGGjhtpSWYEnQZLcN9KZpj6FRxjdRhkQon8xECFxzJn4Qu82MKaT
   QyDZSeq2Ok6yrHvHrhAl8SMN7jSfwUZWGZAw4AGxq1SbVkh9ZTpvbSxbJ
   ECIwCBZ7CbOwDbmck2FP6P/3Skpv8+kF6wVavFiTZJLMfv7WtOqDOr9+O
   +DKuKOnudNB3ngBiRfnXeHX9sOThBPpwNJFRwjME9I3T7FB0fbYHWuWpN
   o9WX9X4aMNuYBGdRvd6igA227oBhLtfupdP/Wj9C2WQIzh4X6Tdf2O/HO
   DdwvIlj0PIvalOUe3/f5JXqW7D4bDXEZDN04+eRsRAQ7AYM0cEPArPWQC
   g==;
X-CSE-ConnectionGUID: bD08MzQoQzG3/6FJ3M5A2w==
X-CSE-MsgGUID: 4H8hHyWeTVykDS8LoeQhxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81584777"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="81584777"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:39:48 -0700
X-CSE-ConnectionGUID: 3VSpUa3MSYiLyA0xUf8agw==
X-CSE-MsgGUID: wbO/orBrQI2tbk28wqK+6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248392346"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 01:39:43 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: x86@kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: djbw@kernel.org,
	kas@kernel.org,
	rick.p.edgecombe@intel.com,
	yilun.xu@linux.intel.com,
	yilun.xu@intel.com,
	xiaoyao.li@intel.com,
	sohil.mehta@intel.com,
	adrian.hunter@intel.com,
	kishen.maloor@intel.com,
	tony.lindgren@linux.intel.com,
	peter.fang@intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	seanjc@google.com
Subject: [PATCH v2 10/17] x86/virt/tdx: Move tdx_tdr_pa() up in the file
Date: Thu, 18 Jun 2026 16:13:48 +0800
Message-Id: <20260618081355.3253581-11-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
References: <20260618081355.3253581-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Fang <peter.fang@intel.com>

Move tdx_tdr_pa() earlier in the file to prepare for upcoming changes
that add a new Extension-SEAMCALL.

No functional change intended.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index da55c1aeeeb8..1e2c7a33c7a9 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1186,6 +1186,11 @@ static __init int init_tdmrs(struct tdmr_info_list *tdmr_list)
 	return 0;
 }
 
+static inline u64 tdx_tdr_pa(struct tdx_td *td)
+{
+	return page_to_phys(td->tdr_page);
+}
+
 static inline phys_addr_t tdx_vmalloc_to_pa(const void *addr)
 {
 	unsigned long pfn = vmalloc_to_pfn(addr);
@@ -1966,11 +1971,6 @@ void tdx_guest_keyid_free(unsigned int keyid)
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_guest_keyid_free);
 
-static inline u64 tdx_tdr_pa(struct tdx_td *td)
-{
-	return page_to_phys(td->tdr_page);
-}
-
 /*
  * The TDX module exposes a CLFLUSH_BEFORE_ALLOC bit to specify whether
  * a CLFLUSH of pages is required before handing them to the TDX module.
-- 
2.25.1

