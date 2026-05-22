Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5803655F9;
	Fri, 22 May 2026 04:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779422731; cv=none; b=qFejjhWjEAry1eb2mAzIwVfYYKHEZK2cligAZYV+G8n3vH+zlOOF/kCYO52/lKuX1vtIrAQdDo0YjdsfLVEcpR3wkxpl1sirgd5ooCBvQf0BLnQ1//XXMUjt9miD1W6lywVRgGwnzpIPR20by+LKdP2uljSQsSE2ifH2j605LDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779422731; c=relaxed/simple;
	bh=WNx+AL0hDrcRSvUppTWdWWvbp05wApktaPKriBOnmWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/Ci/hf57C33C99vVD2tiLN4Uum0F213wIxu/T7BMKd2Qmo9duW0rz0FLDkON/+cVB0JwL/qZvBPcEfk88obM9Go9soeWOwMHSoOPotU0BEcJ1+f46DxVokYmygx59umeFy036Q4WCAfxHBcNL0cZoWt4CJHVJy57dNTqfOGb6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i9XJHyNQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i9XJHyNQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779422731; x=1810958731;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WNx+AL0hDrcRSvUppTWdWWvbp05wApktaPKriBOnmWs=;
  b=i9XJHyNQzvJibiGzZZ8RcmcA9Z5LcsL+MGgfMrwurHRmz/99zOMFbJtZ
   q1cqNt4im+ybO+t/T4QhYH3vqzrgI5kzvdtJNzsF5otMimJPW5sZqAeBN
   BMwR5T1SBOL9GT8ntdaibLgUXS5UvXEmW/8rwHu9uH0e69InbNoSLhDVz
   xA0qBEri1g+/2W0LVtVDV4cWFIbXHsTMlPXeFOnI6/E5L/E8L0OcxJ5Vd
   Bsc0xSkpUerFjBVScNA96f+gHieqc5AcS0iPC3c04YCKonJbU9aPVvNOA
   2nnAcQzCqLQt5HLPGJeTkWmwBke2llsW6xAAoa1ZMXrNdUNVGPWl08Loh
   g==;
X-CSE-ConnectionGUID: e5x5sNJgRryXdkZH9QSNbA==
X-CSE-MsgGUID: 2ENhcDj+QAafyoqIJXhqAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80528873"
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="80528873"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 21:05:31 -0700
X-CSE-ConnectionGUID: R3E1qD/uSm231wN3WbjUBA==
X-CSE-MsgGUID: bUzbzfoBTwuqYK9a6ZeWwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,161,1774335600"; 
   d="scan'208";a="239757826"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 21 May 2026 21:05:26 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
To: kas@kernel.org,
	djbw@kernel.org,
	rick.p.edgecombe@intel.com,
	x86@kernel.org,
	peter.fang@intel.com
Cc: linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	sohil.mehta@intel.com,
	yilun.xu@intel.com,
	yilun.xu@linux.intel.com,
	baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com,
	xiaoyao.li@intel.com
Subject: [RFC PATCH 05/15] x86/virt/tdx: Move tdx_tdr_pa() up in the file
Date: Fri, 22 May 2026 11:41:18 +0800
Message-Id: <20260522034128.3144354-6-yilun.xu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
References: <20260522034128.3144354-1-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Fang <peter.fang@intel.com>

Move the tdx_tdr_pa() in preparation for upcoming changes to use them
during TDX bringup.

No functional change intended.

Signed-off-by: Peter Fang <peter.fang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index dad5ec642723..67758adefb4a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1200,6 +1200,11 @@ static __init u64 to_hpa_list_info(struct page *root, unsigned int nr_pages)
 	       FIELD_PREP(HPA_LIST_INFO_LAST_ENTRY, nr_pages - 1);
 }
 
+static inline u64 tdx_tdr_pa(struct tdx_td *td)
+{
+	return page_to_phys(td->tdr_page);
+}
+
 /* Initialize the TDX Module Extensions then Extension-SEAMCALLs can be used */
 static __init int tdx_ext_init(void)
 {
@@ -1725,11 +1730,6 @@ void tdx_guest_keyid_free(unsigned int keyid)
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

