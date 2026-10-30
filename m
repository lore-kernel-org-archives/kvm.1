Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350419;
	b=Ys3ZgNFOHGBYDzC1/Ipb26Tk8wdzRZ8KT1jRLz0UHGXH/N0Ms7FVCAp6ANkvkv5S2aWp
	 n1TI6UcUBLMRYQaPsvb7uFnrg+jUjVsXjyTlOgGvsP9JU91iDMuuPopmhRMQUZZeiV9hD
	 2FTKT/PzU1nPfi2Hck2FFDKkfQ1go8U7w3y3qUClRvPPMyLgWh8e9WnOCw0j6GY8sTuYw
	 zUmx/YLU7+9DAloU1nXf23jQlOh2A/MsIiINz0admZeUSfpTd49fe6GEilEHIwvl3mGkh
	 UfGsZEAjtVoHcG7LibgWVqOQk8BgMPtDbN1i6L8h74tLrVkzWcntm9OzCBtyWWxHyYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350419;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=B7A3OgK6n+2Dz+gI/th2NnO1FjHFU7DuxHNPlGazmTI=;
	b=xKs9cAOPyMLLT50ATRDBm3VAB1q9gUiW06xpjgNYtlr3mOuhAVC2XnhpvuD8pzBCD0vX
	 A93QTCl1kd+6Uf2HkOk1U+3bu+zN8VaiQdirbRRGE5KwT6gJ9uhPEPw9j0lkMoFdoO7ty
	 IaqQ9I7t69Rad40Ef3LjV+FfHI5B72SKn1llcwoDq0cO+mpxoB+ZHjsVhAtxDxYFcB2g/
	 hK/UbdiPwvX98JGDIrvgMAOijwz7HT7QBlP6pS/2elAsukSBYsZ/FmfN7OfiZSTR+YDLz
	 xwGgl+vIX4GhWV6+BXXGuPBf1jTfFq3u2HxgWDBUBUWQ7TNCAgLEcOIoyyhVJqX7dMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nYoe3dLk;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722F2606A32A;
	Fri, 30 Oct 2026 08:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 722F2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nYoe3dLk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793350417; x=1824886417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v8drpePYYfqiebi4OdLp7skDl2OAf2Dth9sfu+D5eNc=;
  b=nYoe3dLkOpFaKlZX7oarr7C0xF7L6pgEsMdd8+gB4jr1SfcvQ/43TuFo
   +7C38z+oXySKawiKRCAFqGyXfVWLsMJSvBl0uhHZMhU0oDN9m84cuZpjy
   rSdx1zMRA7e2LYftMbJbMz9JWN4QyPi7G34WAOi8UayFPGNoo1XXPk16f
   JHWv5Sx3mY06JuiVTfZ6ehdOUgbXM5gZ7eba3rdyFgrF1BK4tuPZk3lVn
   FFqgTtO7L4BRD6dGif18ZJvRWIalBljMm8IMe49Lfxi5FC8pIA+efQonK
   jm7WvwS+qaWR3PsVqoW4RlSdljI1ThB1UYRFLQd8r/viqXEy+za44OGU9
   w==;
X-CSE-ConnectionGUID: 3WQSyIA9TiSq//UrmAbwTw==
X-CSE-MsgGUID: SnEzTJZOSXaj4ey7+h6/1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2122574"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2122574"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 01:53:37 -0700
X-CSE-ConnectionGUID: K+zdQPIfSyywR3XfVem02A==
X-CSE-MsgGUID: ttjr+6XSSNyt/wUUmkulLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="7199520"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 01:53:37 -0700
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
Subject: [RFC PATCH v1 2/3] x86/virt/seamldr: Support large TDX module binaries
Date: Fri, 30 Oct 2026 01:52:59 -0700
Message-ID: <20261030085304.3886520-3-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261030085304.3886520-1-chao.gao@intel.com>
References: <20261030085304.3886520-1-chao.gao@intel.com>
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

The P-SEAMLDR ABI was extended for this. An upcoming revision of the
SEAMLDR specification adds the following to the description of the
module page address list in 'struct seamldr_params'.

  For TDX module image with larger than 495 pages, the last entry will
  point to a new 4 KB page that contains up to 511 additional HPAs. Each
  page will use its last HPA to reference another page if required. This
  chain continues until all module pages are referenced.

Allocate the needed chain pages together with 'struct seamldr_params',
as a flexible array at its end. Link them up at allocation time. Then
fill in the module page addresses as before, but skip the link entries.
A single allocation leaves nothing to unwind on failure and keeps the
existing kfree() as the only cleanup.

Do not query P-SEAMLDR for chaining support. Userspace selects the update
image and is responsible for ensuring the module is compatible with
P-SEAMLDR.

Chaining removes the 496 page cap, but the module page count still needs
a bound. Without one, a crafted header can overflow the u32 module length
('module_nr_pages * PAGE_SIZE') and pass the image size check. It can
also make the chain page allocation exceed KMALLOC_MAX_SIZE, which warns
in the page allocator.

Raise SEAMLDR_MAX_NR_MODULE_PAGES to a 1GB software limit to rule out
both problems. 1GB is far above the few MB of current modules.

The size of module_pages_pa_list[] no longer reflects the maximum module
page count. Define a new SEAMLDR_NR_MODULE_PA_ENTRIES for it.

Thanks to Yilun for the idea of allocating the chain pages together
with 'struct seamldr_params'.

AI was used under supervision to review code and workshop logs. It
spotted both problems that the software limit addresses.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/seamldr.c | 95 +++++++++++++++++++++++++++++++--
 1 file changed, 90 insertions(+), 5 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 3513fd28536a..09c8f6e30e9f 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -24,7 +24,14 @@
 #define P_SEAMLDR_INFO			0x8000000000000000
 #define P_SEAMLDR_INSTALL		0x8000000000000001
 
-#define SEAMLDR_MAX_NR_MODULE_PAGES	496
+/*
+ * Arbitrary software limit, far above the few MB of current modules.
+ * It keeps the module length within a u32, and 'struct seamldr_params'
+ * plus its chain pages within KMALLOC_MAX_SIZE.
+ */
+#define SEAMLDR_MAX_NR_MODULE_PAGES	(SZ_1G / PAGE_SIZE)
+
+#define SEAMLDR_NR_MODULE_PA_ENTRIES	496
 #define SEAMLDR_MAX_NR_SIG_PAGES	1
 
 /*
@@ -34,6 +41,19 @@
  */
 #define SEAMLDR_SCENARIO_UPDATE		1
 
+#define SEAMLDR_NR_CHAIN_PA_ENTRIES	(PAGE_SIZE / sizeof(u64) - 1)
+/*
+ * A 4KB page holding the physical addresses of the module pages that do
+ * not fit in module_pages_pa_list[]. @next_page_pa points to the next
+ * page, forming a singly linked list.
+ */
+struct chain_page {
+	u64	pa[SEAMLDR_NR_CHAIN_PA_ENTRIES];
+	u64	next_page_pa;
+} __packed;
+
+static_assert(sizeof(struct chain_page) == 4096);
+
 /*
  * This is the "SEAMLDR_PARAMS" data structure defined in the
  * "SEAM Loader (SEAMLDR) Interface Specification".
@@ -48,10 +68,13 @@ struct seamldr_params {
 	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
 	u8	reserved[104];
 	u64	module_nr_pages;
-	u64	module_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
+	u64	module_pages_pa_list[SEAMLDR_NR_MODULE_PA_ENTRIES];
+
+	/* Hold module pages that cannot fit in module_pages_pa_list[]. */
+	struct chain_page	chain_pages[];
 } __packed;
 
-static_assert(sizeof(struct seamldr_params) == 4096);
+static_assert(offsetof(struct seamldr_params, chain_pages) == 4096);
 
 /*
  * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
@@ -143,6 +166,68 @@ static void populate_pa_list(u64 *pa_list, const u8 *vmalloc_addr, u32 vmalloc_l
 	}
 }
 
+/*
+ * Like populate_pa_list(), but skip entries pointing to the next page.
+ */
+static void populate_module_pa_list(struct seamldr_params *params,
+				    const u8 *vmalloc_addr, u32 vmalloc_len_pages)
+{
+	u64 *pa_list = params->module_pages_pa_list;
+	int i, j;
+
+	for (i = 0, j = 0; i < vmalloc_len_pages; i++, j++) {
+		unsigned long offset = i * PAGE_SIZE;
+		unsigned long pfn = vmalloc_to_pfn(&vmalloc_addr[offset]);
+
+		/*
+		 * Skip non-zero entries. They point to the next page and
+		 * are populated during allocation.
+		 */
+		if (pa_list[j])
+			j++;
+
+		pa_list[j] = pfn << PAGE_SHIFT;
+	}
+}
+
+static struct seamldr_params *alloc_seamldr_params(u32 nr_module_pages)
+{
+	struct seamldr_params *params;
+	u32 nr_chain_pages;
+	u32 nr_direct;
+	u64 *link;
+
+	/*
+	 * Number of module pages that fit directly in
+	 * module_pages_pa_list[]. Minus one as the last entry is
+	 * reserved to point to the first chain page.
+	 */
+	nr_direct = SEAMLDR_NR_MODULE_PA_ENTRIES - 1;
+
+	/* Calculate the number of extra chain pages needed. */
+	nr_chain_pages = 0;
+	if (nr_module_pages > nr_direct) {
+		u32 nr_left = nr_module_pages - nr_direct;
+
+		nr_chain_pages = DIV_ROUND_UP(nr_left, SEAMLDR_NR_CHAIN_PA_ENTRIES);
+	}
+
+	params = kzalloc_flex(*params, chain_pages, nr_chain_pages);
+	if (!params)
+		return NULL;
+
+	/* Link all the chain pages. */
+	link = &params->module_pages_pa_list[nr_direct];
+	for (int i = 0; i < nr_chain_pages; i++) {
+		struct chain_page *page = &params->chain_pages[i];
+
+		*link = __pa(page);
+		link = &page->next_page_pa;
+	}
+
+	return params;
+}
+
 static void populate_seamldr_params(struct seamldr_params *params,
 				    const u8 *sig, u32 sig_nr_pages,
 				    const u8 *mod, u32 mod_nr_pages)
@@ -152,7 +237,7 @@ static void populate_seamldr_params(struct seamldr_params *params,
 	params->module_nr_pages	= mod_nr_pages;
 
 	populate_pa_list(params->sigstruct_pages_pa_list, sig, sig_nr_pages);
-	populate_pa_list(params->module_pages_pa_list,	  mod, mod_nr_pages);
+	populate_module_pa_list(params, mod, mod_nr_pages);
 }
 
 /*
@@ -195,7 +280,7 @@ static struct seamldr_params *build_seamldr_params(const struct tdx_image *image
 	if (memchr_inv(header->reserved, 0, sizeof(header->reserved)))
 		return ERR_PTR(-EINVAL);
 
-	params = kzalloc_obj(*params);
+	params = alloc_seamldr_params(header->module_nr_pages);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.52.0

