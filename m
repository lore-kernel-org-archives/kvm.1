Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD194DE706;
	Mon,  5 Oct 2026 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791222374; cv=none; b=paWey7aeoo0+4zEWryyOi02DBettCry7x7BlcjnXFtaokjoeYI0Nc4wTxkj9RMLRBCtokd5HL7Ioa0HENYD4MBqNLOanNw952JA6vy697J1pECM50kWqCUcaHfIxZTUcp7olq6tEqzvtCmnuHDhjG0pUYNrqj75p2fb3OdpCne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791222374; c=relaxed/simple;
	bh=8wuRTBjZg2VId8lF4Tpe7C8zexrFwUJaK3Lkfkk+4oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpXlvSHPBHkzTm/sypuWb1/v7k1v31ve3R5ioQIXA8CpBq/xC62wze0CzWiCu/3tFRyTKibI84IG/rxqPHMyt9pwKYPdsVuADf1yZJj3OB4UwRL3+ezRL4GlIMBSPP6pUO/cU0zNhbdd1fgOUv+aBhWTdR8AZ8sBCxJw4QXnweg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0CZt3Na; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0CZt3Na"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791222372; x=1822758372;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=8wuRTBjZg2VId8lF4Tpe7C8zexrFwUJaK3Lkfkk+4oU=;
  b=O0CZt3NaPTJDOU4OVUaXo6PC8s01iIKZan01qLWRbKRN9DnBifJ7W2EM
   qmvLjNk/aiOi9qAsiOJ+eAAzaHjARqEsFw+0ECTQ7yVfpTBD2/sEURc46
   OV6x0EsPIosNUwYcRABc7YgjKTz0GErT/5paYwzTdC6YxAcue1zG2x8Xh
   xPc81Z+QN1F1cHZxr0rYL3Nm0JvPsSOtgtNJV4Vqg6jUjZ7o43Pk2it3/
   QRG1eEYMExIJ+1LVh1e7u+Wz/z44//O64CjBO9PtdeooysdKjiKFPdRSK
   2u3FFdxcoR1B5Ow7/7musF3ZAHzQAW4IvlTCrz4vbYpQzZddNJ62LK42x
   w==;
X-CSE-ConnectionGUID: UaLkBDGbQuq89hWyJJPm6A==
X-CSE-MsgGUID: Qx0ncRP9SKWXRX7mmRQ/dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="102419845"
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="102419845"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 10:46:12 -0700
X-CSE-ConnectionGUID: IIARi963TN2+vK6jjnZjQw==
X-CSE-MsgGUID: yxtzGfKeR3SEdCBv80lOlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,142,1787036400"; 
   d="scan'208";a="276002504"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by orviesa008.jf.intel.com with ESMTP; 05 Oct 2026 10:46:08 -0700
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Tue, 06 Oct 2026 01:41:50 +0800
Subject: [PATCH v3 6/6] x86/virt/tdx: Support DPAMT when adding memory for
 the extensions
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-tdx-module-ext-v3-6-db52cb05b918@linux.intel.com>
References: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
In-Reply-To: <20261006-tdx-module-ext-v3-0-db52cb05b918@linux.intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1776;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=8wuRTBjZg2VId8lF4Tpe7C8zexrFwUJaK3Lkfkk+4oU=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWQdfjhntpjEH9Zp5ewVJ1tZ2v+KGd7T3v9gVwjr4nvmT
 M0X3mtxdHSyMIhxMBiKKbIs8JjlNKV9FtPWTzuvwcxhZQIZIixTmZlTmqdXUeqQmVeSmqOXnJ/L
 wMUpAFMVsYWR4e2MSXfm3rRlNlQxfbhx2jazLt4HxsqXviR+488vlmadw8DwPycwvOp+50GrWwc
 kp3zJctx8o0RW8Nm6t/enl+3XX6y0lgUA
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

The TDX module uses Physical Address Metadata Table (PAMT) to track some
state for each page of physical memory that it might use. 3 levels of
PAMTs are used to track pages of different sizes - 1GB, 2MB and 4KB.
Dynamic PAMT (DPAMT) allows saving memory by allocating 4KB PAMT
dynamically, while the 1GB and 2MB levels remain allocated on TDX module
initialization. The kernel has helpers to install 4K DPAMT.

Although the memory for the extensions is tens of megabytes and the host
allocates it in a large chunk, the TDX module accepts it at 4K
granularity. Thus the host has to install 4K DPAMT for each page of it.

Call tdx_pamt_get() for each page before adding it to TDX module.
Normally, these operations should not fail, and if they do,
intentionally keep the error handling as simple as before - leak all
pages, including the installed 4K DPAMT metadata.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
---
v3:
 - New patch
---
 arch/x86/virt/vmx/tdx/tdx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 5d5f9da1ab02..27a7039ee443 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1330,8 +1330,15 @@ static __init int tdx_ext_mem_setup(void)
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

