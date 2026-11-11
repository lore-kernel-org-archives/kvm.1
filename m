Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794369436;
	b=kNcUeKjKKn4lRiybvs+kYZ42MsWa4HldXygTY+XLHaoIf3O3cYcGhlEDP67N/JBJ+Fwy
	 tycFIodJkRRpwtGvLhQEfFlehOF+mJelI8YCo6uOIkwvPWfnn6DqQOOt4B5pK/Zl4cOWx
	 xCUaB4oiTuIZgfZ2enWgpjTpRCuzoindnm00pG2KtTtL+F+mPyH41RpD3ByvJYsI651ey
	 i8xk4S7fTh+6Qw47ZERe6kBvPGaAkHH2vENDvM6WRm0+fUTbkre1RN3y4sC5XpvJom5e7
	 zxos2bYKUBZkonBwaOdy3PXBmocnKIK5WCnzZTVp7ovQGo/fDP8M8Vx5rZ2P5JzHsWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369436;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=7MvVAMDXjWprOoMaeDSufi45I2IYcPXv9qZ9yhWbMgY=;
	b=EOT8Bu2DLlOsa2YaaM2rtcVnl3aDWuy8gRjv5oVV2sMzdVLBeDVva/KDGDkpZO3zUMqn
	 JI4VyIJj4Yfu5etY6w1Gjh46rWHh9NDImSp08vbbxh1wDareB2TPPxp0re3Ht6K7UHPOX
	 aqZs7KLO0BliE/gP7hE7gqQxMmKEyOhapK9V9o+gPridywSMajhkFQlhYA29j/swxxxBz
	 3WqFQuheKxlC9xkNZxJrPGvm8JMfPHqvggAY4YPgoFO+88vzN62bimDDyA+AZhOGtOIY0
	 GFtVEyblnWvak3iJVIiRddSguGLaJPgeQPYknC145MVXTXYj0npYu/7eu7XqVP7ca+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UX5NyaWH;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49597606A327;
	Wed, 11 Nov 2026 03:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49597606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UX5NyaWH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794369436; x=1825905436;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=q1BHDHU/0pUZdsMwgo31e76yqiOl0ElefJdhMfsUuq0=;
  b=UX5NyaWHzoIY8CRKb7oyhHDtQqiKi3M+1WV/Gv45p4akbRZWoDxVQQzn
   Vsr87uagduFRTLnjaSTeuBV6tALxMNow9AkvMDEVtcVotTO6cLmcXO9vq
   Pjce8x+Itkb2bHotk4ZXwuEXsBCpYe37k8Ogzc1zp7lTxvLwcOZXru2z9
   FK19UG5HV2DW0yyfq+buJqb29viAVFjBPAbciBDFRTS746qi6pDI03Y4N
   tqlPusyL6PNLiXNuoV5IJ4u9b251ys/vD+zjvldivXNlKutjLPZ8mekLi
   FJagyTJcGWHsxUPbd+Yw5Kx98TyZs/1YzagddLnSlU32JifpCmHtneBbp
   A==;
X-CSE-ConnectionGUID: dvbmrv8eSM+yctIsjycbpA==
X-CSE-MsgGUID: RTFwes0QR9W3tYAlnLvHKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3220294"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3220294"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 19:57:16 -0800
X-CSE-ConnectionGUID: PlO4BXijSmyIqoW3Zbmcqw==
X-CSE-MsgGUID: YISC4jpESuSNmpiDSHelWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="10199256"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO [127.0.1.1]) ([10.239.47.46])
  by fmviesa013.fm.intel.com with ESMTP; 10 Nov 2026 19:57:12 -0800
From: Xu Yilun <yilun.xu@linux.intel.com>
Date: Wed, 11 Nov 2026 11:48:45 +0800
Subject: [PATCH v5 4/6] x86/virt/tdx: Support DPAMT when adding memory for
 the extensions
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-tdx-module-ext-v5-4-c74f764abc3d@linux.intel.com>
References: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
In-Reply-To: <20261111-tdx-module-ext-v5-0-c74f764abc3d@linux.intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2719;
 i=yilun.xu@linux.intel.com; h=from:subject:message-id;
 bh=q1BHDHU/0pUZdsMwgo31e76yqiOl0ElefJdhMfsUuq0=;
 b=owGbwMvMwCH2Zztz45IFPbcYT6slMWR9frpCauGmJmW34k9XrzHPZ7bVyXjyN0vKsfTT3PXiC
 yfNNSiR7OhkYRDjYDAUU2RZ4DHLaUr7LKatn3Zeg5nDygQyRFimMjOnNE+votQhM68kNUcvOT+X
 gYtTAKbqhAUjw6mJhYLnKlYxF2/c9X/zY91/sXfvZq1/cfveZN+lH96KXUpj+Ke6hb9WO9tQ4rb
 mA64N70wiFwZOXf3HLket+PJF8xyOal4A
X-Developer-Key: i=yilun.xu@linux.intel.com; a=openpgp;
 fpr=A612D44FA98BA699FECC642BE2C8D72186AC3949

The TDX module uses PAMT to track some state for private pages. The
memory for the extensions needs PAMT backing cause the TDX module
transitions it to private pages when accepting it.

The Dynamic PAMT (DPAMT) feature allows saving memory by allocating
4KB-level PAMT dynamically. The kernel must install DPAMT before adding
any 4KB pages to the TDX module. Although the memory for the extensions
is tens of megabytes and the kernel allocates it in a large chunk, the
TDX module accepts it in the form of an HPA array, which specifies each
page at 4KB granularity. Thus the kernel still needs to install DPAMT
for this memory, otherwise TDH.EXT.MEM.ADD would fail to execute.

That said, don't worry about bisectability cause the extensions can't be
enabled yet without a feature that uses them.

The kernel has helpers to install DPAMT for a 4KB page. Call
tdx_pamt_get() for each extension page before adding it to the TDX
module. Normally, these operations should not fail, and if they do,
intentionally keep the error handling as simple as before - leak all
pages, including the installed DPAMT.

The original changelog was written by hand. AI was used to help correct
grammatical errors and polish individual sentences for better
readability.

Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
---
v5:
 - Clarify that the bisectability won't be hurt
 - Refactor the first 2 paragraphs.
 - Collect Reviewed-by tags
 - Better clarify the AI usage

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
index 865d8089d343..3440f1878978 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1318,8 +1318,15 @@ static __init int tdx_ext_mem_setup(void)
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

