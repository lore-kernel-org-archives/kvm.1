Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C6455408C;
	Tue, 13 Oct 2026 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905630; cv=none; b=n76vfzPi1Vzu+cWckcBVGV630cN23IWXjCCjGkAv8155Ne0GnRGaHEYA3nqo0qUfO/yMVV7xrSc8VgInmy2WRq6k7RqdQIyoIKvFqdnam6wDjZxirkoiTb00YuQww/iIDkIOaspCXguMj1V5OosieUY2Lry3bI4Vw5Aty1tbc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905630; c=relaxed/simple;
	bh=6okskzGhF7IyZQu2Pt86CN9DoCnmyFlO861rq0PjROo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kn5ejvYRbn0UqmBbyMgZIwvbkxfdDbJZXFArvOnoAL25ZWi25/nm1iGeOfYz9OfhtVnCcip63ocyZp2c89ZaAwQ45F4QMOvw2G6SAQCN/I5qX0Fl+L2CAHclza34T4LgvmY1jyJNW1/ZucJayS4CN4cOPEKfQyTC3qMcZDcw8Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQB3aCve; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQB3aCve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791905628; x=1823441628;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6okskzGhF7IyZQu2Pt86CN9DoCnmyFlO861rq0PjROo=;
  b=NQB3aCve6Ctfzfp2WywbWQcbgyHoXmTvHfcl+yDWSZ9/TfcQGbDOgTmB
   HQjnV55RMRBXYcgID71s+CmS0wxSr5yWrHV3mcIj5lcF6V24o8/O0NaJg
   T36f3c0IuRy0k4Aubt1vmDJY5bDGndMJ70IvMbkCjxpKMOKNhH7Vv6O3g
   yGISXhFsIHqf7mKb8jaEeZkKmS2MXNBbYc90rc73xM+cDLRSpkbPPCp9s
   qEg1WxW3TfWdAHnGnPIbDYLS9zo1XOZNrSoEIzsp7qUypCFjM/ZyGbJr8
   v8ZvTB+HS4hZ2725hFHnG6nAqc/X0KbibcQgaoAVT7tyjV7m8OJkb6Ixf
   g==;
X-CSE-ConnectionGUID: 35gmo+AXRtS0sOxSKPQsxg==
X-CSE-MsgGUID: uG39fzU5TC+HAYRk/JdSZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="643421"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="643421"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 08:33:47 -0700
X-CSE-ConnectionGUID: n12THBhyTkGandqCCOfv4Q==
X-CSE-MsgGUID: 5cvVgctfRmuOMdTGwVa2xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1388225"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by fmviesa001.fm.intel.com with ESMTP; 13 Oct 2026 08:33:43 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Tue, 13 Oct 2026 23:28:54 +0800
Subject: [PATCH v4 4/6] x86/virt/tdx: Support DPAMT when adding memory for
 the extensions
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-tdx-module-ext-v4-4-de5ffac65470@linux.intel.com>
References: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
In-Reply-To: <20261013-tdx-module-ext-v4-0-de5ffac65470@linux.intel.com>
To: x86@kernel.org, linux-coco@lists.linux.dev, 
 linux-kernel@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, dave.hansen@intel.com, 
 kvm@vger.kernel.org, yilun.xu@intel.com, yilun.xu@linux.intel.com, 
 xiaoyao.li@intel.com, sohil.mehta@intel.com, adrian.hunter@intel.com, 
 kishen.maloor@intel.com, tony.lindgren@linux.intel.com, 
 peter.fang@intel.com, baolu.lu@linux.intel.com, zhenzhong.duan@intel.com, 
 chao.gao@intel.com, artem.bityutskiy@linux.intel.com, nik.borisov@suse.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=6okskzGhF7IyZQu2Pt86CN9DoCnmyFlO861rq0PjROo=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWSd84tw6IsvthV7k+Xx5vOOzP+L2JRLrxRcVZDtzzfe6
 LrB+s6tjk4WBjEOBkMxRZYFHrOcprTPYtr6aec1mDmsTCBDhGUqM3NK8/QqSh0y80pSc/SS83MZ
 uDgFYKp42Bn+B/G+S+w+Lyjewi5r8r97hv0PD5dvTJw6WTKKap3cp16yMPzPLX+lHs3Od1SNxXj
 j9ZOphUsLJz3Zb7f975l1/I0lPPFsAA==
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

The TDX module uses Physical Address Metadata Table (PAMT) to track some
state for each page of physical memory that it might use. 3 levels of
PAMTs are used to track pages of different sizes - 1GB, 2MB and 4KB.
The Dynamic PAMT (DPAMT) feature allows saving memory by allocating
4KB-level PAMT dynamically, while the 1GB and 2MB levels remain
allocated on TDX module initialization.

A previous kernel change [1] enabled the DPAMT feature by default so
that the kernel must install DPAMT before adding any 4KB pages to the
TDX module.

Although the memory for the extensions is tens of megabytes and the
kernel allocates it in a large chunk, the TDX module accepts it at 4K
granularity. Thus the kernel has to install DPAMT for each page of it,
otherwise TDH.EXT.MEM.ADD would fail to execute.

The kernel has helpers to install DPAMT for a 4K page. Call
tdx_pamt_get() for each extension page before adding it to the TDX
module. Normally, these operations should not fail, and if they do,
intentionally keep the error handling as simple as before - leak all
pages, including the installed DPAMT.

AI was used under supervision to review code and workshop logs.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Link: https://lore.kernel.org/all/20260904215841.303070-1-rick.p.edgecombe@intel.com/ # [1]
---
v4:
 - Explain in changelog that TDH.EXT.MEM.ADD won't work without this
   patch when DPAMT is on by default. (Tony)
 - Move this patch right after the one that implements TDH.EXT.MEM.ADD
 - Collect Reviewed-by tags

v3:
 - New patch
---
 arch/x86/virt/vmx/tdx/tdx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 744ef95e448f..4908add631fa 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1328,8 +1328,15 @@ static __init int tdx_ext_mem_setup(void)
 		struct page *chunk = page + added_pages;
 		unsigned int i;
 
-		for (i = 0; i < chunk_pages; i++)
+		for (i = 0; i < chunk_pages; i++) {
+			ret = tdx_pamt_get(page_to_pfn(chunk + i), NULL);
+			if (ret) {
+				WARN(1, "DPAMT setup error for extensions, stranded all pages\n");
+				goto out_free_hpa_list;
+			}
+
 			hpa_list->phys[i] = page_to_phys(chunk + i);
+		}
 
 		ret = tdx_ext_mem_add(hpa_list, chunk_pages);
 		if (ret) {

-- 
2.25.1

