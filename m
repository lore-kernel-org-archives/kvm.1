Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793971312;
	b=4a2H8jhJ79pxjJ1LmYPcQ6JJgTSRymYXpYvjDGdeuGfM0F1ppuqGktL8m3ePblH2UlfF
	 i6MePsHjXwxHvz6EwyrMxHKgnuzpskOm1Eih2XLcSNRUVKqdS14bCNr5TpCSBcmGpAbOc
	 d/SE1mZErqCj9zzLx7rhvVFsrwkfCYFoATRfpijSNktjTx5bH1hOIw4iGs48MicBXMawI
	 HuGB7emIltp2hDMr+J0adq11GFdVZ8Q9KwcD54tiUhLhyEV0Im5I7mFYyFWjhNMigYiPp
	 9rhugl7CIudykZBQ8i/pWQry57LqAVhIVgWAPkI3BT3EMQcQ9CyYYMu8o0FdribuRjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793971312;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qtsDUNEMgw7d2Zk5/OM8OnYI6bnyYCGwP6y8Lp1n9PU=;
	b=ZTtEs0qdH4fw9uMhQn2M+KpEX0Oo0Re+56pVDUxrvhckp6CP547sm/2iEVraUAsZASuk
	 8e8z5xevC4573Wk0eAwtXL2OoKrch4Czuy/drzLDq0WX/n4cDD/AdZuq5Tytyl7Q4gIw3
	 3W/Q98GdU9rILF8qkB63rydz6EelQbgXPTt6R2JOMGH9N1lHue8msICTBkgVWPGkPkH0d
	 TZgO9uYrarZdNbP8HO1E6e/jMgQJEd+uX4WCIEJ89A5dxvOIv/lBnpTFz7N20tXHwU14U
	 V9dS86osSEcnHp6W4m1OpGQoaHUIs9+skXPlLj6E4MVyLJQJfa0z1o1dj38bbxwFtPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Z//YRLaq";
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA9606A332;
	Fri,  6 Nov 2026 13:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0CA9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Z//YRLaq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793971310; x=1825507310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mUHK3H94RDUlCHRQYCvGju0s+BETkj/nIqvx9CShAJk=;
  b=Z//YRLaqiz9p2lFFd3OUClaK/VVmOKrjt2zk6JDB7sooHYcG1nfURObA
   LKh9R0qXiG6GA3oKOX7lDcOBq1fCv3SGudeYrC853IipBkanH3gDZLYQW
   2ZAK4QKCwWyabCVk7J5o2I+AmZEXZmf6TpMDYHn2MQZI/NBn+sczAAYAI
   PrpPKSk7bVR94vep5tAiSdMU8GNmDUJ2gvNt1/a6rnHgTN+Ng8cvGk1Iz
   mE9LQCoHYgmPnZavlvZXP7xBbsDjLdpgWD21XGvigY6W76yS0erQjvRdh
   aBwJi+hR1cSxBQC9sb1GeefkafMuEMq3gRdOQ3SPlVJC0ecpxxtrF60wn
   A==;
X-CSE-ConnectionGUID: Sn5OG9jHTa+llhvPSL2fww==
X-CSE-MsgGUID: dP8F/11ETteyVVroWgVN9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2786770"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2786770"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:21:49 -0800
X-CSE-ConnectionGUID: wKggPWIDRayGVJKSoyABDA==
X-CSE-MsgGUID: XSYystoMQGmjHQO1JsLG5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7397271"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:21:49 -0800
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@intel.com,
	arjan.van.de.ven@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [RFC PATCH v2 1/2] x86/virt/seamldr: Support large TDX module binaries
Date: Fri,  6 Nov 2026 05:21:55 -0800
Message-ID: <20261106132159.1551365-2-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261106132159.1551365-1-chao.gao@intel.com>
References: <20261106132159.1551365-1-chao.gao@intel.com>
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The module binary is handed to P-SEAMLDR as a list of page physical
addresses in 'struct seamldr_params'. The list has 496 entries, which
caps a module at 496 pages.

TDX modules are gaining features and are about to outgrow that limit.

The P-SEAMLDR ABI was extended to chain the list across 4KB pages. For
a module over 495 pages, the last of the 496 entries points to another
page of entries instead of to a module page. The last entry of that
page can point to yet another page, and so on, until every module page
is listed.

Grow module_pages_pa_list[] so that 'struct seamldr_params' spans
multiple pages (16 for now), and use the extra pages as the chained
pages. The last entry of each page then points to the entry right after
it, which starts the next page. These link entries do not hold module
pages, so leave them out of the maximum module page count.

The 16-page size is somewhat arbitrary. It fits modules of up to about
32MB, far above the roughly 2MB of current modules. It wastes 60KB for
today's modules, which is fine because the memory is freed right after
the update. Sizing module_pages_pa_list[] per module would mean either
moving the allocation after the image header is validated, or allocating
from an unvalidated page count. Either way it is more code churn.

Do not query P-SEAMLDR for chaining support. Userspace selects the update
image and is responsible for ensuring the module is compatible with
P-SEAMLDR.

Thanks to Yilun for the idea of allocating the chain pages together
with 'struct seamldr_params'.

AI was used under supervision to review code and workshop logs.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
v2:
 - Make 'struct seamldr_params' a fixed 16 pages instead of sizing it
   to each module, capping modules at about 32MB. [Rick]
 - Drop the patch that moved the allocation after image validation. [Rick]
---
 arch/x86/virt/vmx/tdx/seamldr.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index b1137ca6150d..087bdf10a9a7 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -24,7 +24,18 @@
 #define P_SEAMLDR_INFO			0x8000000000000000
 #define P_SEAMLDR_INSTALL		0x8000000000000001
 
-#define SEAMLDR_MAX_NR_MODULE_PAGES	496
+/*
+ * module_pages_pa_list[] spans multiple pages. The last entry of each
+ * page points to the next page and does not hold a module page, so the
+ * maximum number of module pages is the array size minus one entry per
+ * page.
+ *
+ * SEAMLDR_PARAMS_NR_PAGES is somewhat arbitrary. It allows modules of
+ * up to about 32MB. Increase it if modules outgrow that.
+ */
+#define SEAMLDR_PARAMS_NR_PAGES		16
+#define SEAMLDR_NR_MODULE_PA_ENTRIES	(496 + 512 * (SEAMLDR_PARAMS_NR_PAGES - 1))
+#define SEAMLDR_MAX_NR_MODULE_PAGES	(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES)
 #define SEAMLDR_MAX_NR_SIG_PAGES	1
 
 /*
@@ -48,10 +59,10 @@ struct seamldr_params {
 	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
 	u8	reserved[104];
 	u64	module_nr_pages;
-	u64	module_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
+	u64	module_pages_pa_list[SEAMLDR_NR_MODULE_PA_ENTRIES];
 } __packed;
 
-static_assert(sizeof(struct seamldr_params) == 4096);
+static_assert(sizeof(struct seamldr_params) == SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE);
 
 /*
  * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
@@ -129,17 +140,24 @@ struct tdx_image {
 /*
  * Given a vmalloc() allocation, write all of the backing physical
  * addresses to pa_list[]. Caller guarantees that the array is big
- * enough.
+ * enough. If pa_list[] spans multiple pages, point the last entry
+ * of each page to the next page.
  */
 static void populate_pa_list(u64 *pa_list, const u8 *vmalloc_addr, u32 vmalloc_len_pages)
 {
-	int i;
+	int i, j;
 
-	for (i = 0; i < vmalloc_len_pages; i++) {
+	for (i = 0, j = 0; i < vmalloc_len_pages; i++) {
 		unsigned long offset = i * PAGE_SIZE;
 		unsigned long pfn = vmalloc_to_pfn(&vmalloc_addr[offset]);
 
-		pa_list[i] = pfn << PAGE_SHIFT;
+		if (PAGE_ALIGNED(&pa_list[j + 1])) {
+			pa_list[j] = __pa(&pa_list[j + 1]);
+			j++;
+		}
+
+		pa_list[j] = pfn << PAGE_SHIFT;
+		j++;
 	}
 }
 
-- 
2.52.0

