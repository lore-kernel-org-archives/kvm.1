Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795074489;
	b=nX/iANwT5cBDLVyExgWn/AuR2uu/LLznPg/qfh6OoCVY8FaKfYPYzijpLVNE1GvlF3qx
	 Nbc4evkJtt4pjsvkDqAYjb4d8x1IMtOyDE/2Kc/cXKarVEjEu5Y/yJhvDxfTtTwDmgzEy
	 omLagN7j2nSNuY6LQ4hfMrUFbBjqb0VVhRCsCz1iTPjVunTgTBkritBVmJTZ+UStTbYbC
	 tQkQTXhNc5IpnJubM8CdTCAq696lvc8TN3CkRsBf0j337mt362DaCxKGzgExtzyjY62CJ
	 x5DjJMZk0pFlBqKKBna1Sj4eJcoxarUs+9XQs2ts2CwgFZeABP3P4auvBTXYUFYA+Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795074489;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=odTF74iaUOT3nx9OAimr/B99ueABAU/gIzV62QEOTEk=;
	b=B4jsRkBEMBna6AxbGT5Xe/mC+u7jGz5fQl+gnURyfJWasijifHdY4kAWSzVmJEaRSGMO
	 wwrDkDkhHzm6JQgVtg08C4ExkLY9LCAEAzY5LBqNCThMy8RmmKDZaeiHySL3kyiVsVTVI
	 ug4FwIEzNfjVFSOFUlVPoigVYAzSHbhfBVqSSUfgaOfIRfrIHipU53wMYQXyKbbxx3mqb
	 R/MG8gamjJju9vKeK94h6VAIlsYelL+4drrOSY9QTE32ndUo1v6YQmUlOHzNUC69T97xe
	 0mSblxq1sWwuHwmiH+T51KMJAWXuzXLmngNxH0o1uVKKHEunLI/xM7A/jhqPv9wnvmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bFoipNOa;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA06606A330;
	Thu, 19 Nov 2026 07:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DA06606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bFoipNOa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795074489; x=1826610489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ISGPe530T3f+212xZKUxY3rej3e4QBV7A9q4kvGKqdI=;
  b=bFoipNOaUGs06q4BzFS6wrME+P22/7JgoM0QrvMU8KifrFBb1t6v+NzI
   LQF/dNpDsxcMAkWh9J7LCZyXophmzw5Fyw9DFlh7lrH60mRk1UBGmV1zs
   VTG+lwYJ4QbvRD8eF08TK/mnP288NFc9LB3JEkWDEjT4hJxRfrwfA23I8
   M/0pcEpvCFsZN8QAKhzwZ+c5aLiU/1T7CZN047khfx7TzTcwpvEvG9xtl
   sbbKK6j6PzJTJvOe8jZ9i499N0Iw5TqadDL4zpK+U6L8oZNVToePQqD3t
   tH8O/qs+UWaRmmtVz02KfV0mHRSlZ4AUOT1IDvKXApEdy0OrQBdwyOOav
   Q==;
X-CSE-ConnectionGUID: 2pdCtQ4sSwGCtW/GYcMAMw==
X-CSE-MsgGUID: at30QHrlS+io+KEgbetS2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3941747"
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="3941747"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:48:07 -0800
X-CSE-ConnectionGUID: NyxYmSI3TcWvw0TH7FR8SQ==
X-CSE-MsgGUID: dfTagRagStK2DFk7ogqqrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,220,1787036400"; 
   d="scan'208";a="10725810"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 23:48:08 -0800
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: yilun.xu@intel.com,
	arjan.van.de.ven@intel.com,
	binbin.wu@linux.intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v3 1/2] x86/virt/seamldr: Support large TDX module binaries
Date: Wed, 18 Nov 2026 23:49:21 -0800
Message-ID: <20261119074925.3933804-2-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119074925.3933804-1-chao.gao@intel.com>
References: <20261119074925.3933804-1-chao.gao@intel.com>
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

TDX module binaries are limited to just under 2MB. The binary is handed
to P-SEAMLDR as a list of page physical addresses in
'struct seamldr_params', and the list must fit in a single 4KB page
along with a few other fields.

TDX modules are gaining features and are about to outgrow that limit.

The P-SEAMLDR ABI was extended to let the list continue onto more 4KB
pages. The last u64 of each page holds the physical address of the next
page, chaining the pages together.

Grow module_pages_pa_list[] so that 'struct seamldr_params' spans 16
pages, and chain the pages together in populate_pa_list().

Each page uses its last entry for chaining, so the maximum module page
count is the array size minus one entry per page. The user-supplied
image is checked against this count.

The 16-page size is somewhat arbitrary. It fits modules of up to about
32MB, far above the roughly 2MB of current modules. It wastes 60KB for
today's modules, which is fine because the memory is freed right after
the update.

Do not query P-SEAMLDR for chaining support. Userspace selects the
update image and is responsible for ensuring the module is compatible
with P-SEAMLDR.

A 496-page module (the old maximum) used to fit in a single page. Now
the last entry of that page is used for chaining, so the final address
moves to a second page and the module requires chaining support. Do not
special-case this size to make it work with a P-SEAMLDR without
chaining support. No released module has exactly 496 pages, so nothing
breaks. Leave it to userspace to ensure any future 496-page module is
paired with a P-SEAMLDR that supports chaining, as with larger modules.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
Alternative (tried in v1, dropped in v2):

Sizing module_pages_pa_list[] per module needs the page count from the
image header. The allocation would have to either move after the header
is validated, as v1 did, or use an unvalidated count. Either way it is
more code churn than a fixed 16 pages.

v3:
 - Explain the math of the max module page count [Rick/Yilun]
 - Call out the 496-page behavior change [Binbin]
 - Drop the exact numbers (496/495) from the ABI description [Yilun]
 - Drop the boilerplate AI usage note [Dave]
 - Note that sigstruct_pages_pa_list[] is never chained [Yilun]
 - Comment the PAGE_ALIGNED() check in populate_pa_list() [Rick]

v2:
 - Make 'struct seamldr_params' a fixed 16 pages instead of sizing it
   to each module, capping modules at about 32MB. [Rick]
 - Drop the patch that moved the allocation after image validation. [Rick]
---
 arch/x86/virt/vmx/tdx/seamldr.c | 37 +++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index b1137ca6150d..6b9657a28129 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -24,7 +24,20 @@
 #define P_SEAMLDR_INFO			0x8000000000000000
 #define P_SEAMLDR_INSTALL		0x8000000000000001
 
-#define SEAMLDR_MAX_NR_MODULE_PAGES	496
+/*
+ * 'struct seamldr_params' spans this many pages. The number is somewhat
+ * arbitrary and fits modules of up to about 32MB. Increase it if modules
+ * outgrow that.
+ */
+#define SEAMLDR_PARAMS_NR_PAGES		16
+
+/*
+ * module_pages_pa_list[] fills the rest of 'struct seamldr_params' after
+ * its first 128 bytes. The last entry of each page is reserved to point
+ * to the next page. The last entry of the final page is never used.
+ */
+#define SEAMLDR_NR_MODULE_PA_ENTRIES	((SEAMLDR_PARAMS_NR_PAGES * PAGE_SIZE - 128) / sizeof(u64))
+#define SEAMLDR_MAX_NR_MODULE_PAGES	(SEAMLDR_NR_MODULE_PA_ENTRIES - SEAMLDR_PARAMS_NR_PAGES)
 #define SEAMLDR_MAX_NR_SIG_PAGES	1
 
 /*
@@ -48,10 +61,10 @@ struct seamldr_params {
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
@@ -130,16 +143,28 @@ struct tdx_image {
  * Given a vmalloc() allocation, write all of the backing physical
  * addresses to pa_list[]. Caller guarantees that the array is big
  * enough.
+ *
+ * If pa_list[] spans multiple pages, chain them by pointing the last
+ * entry of each page to the next page. Note that a pa_list[] that
+ * does not cross a page boundary, such as sigstruct_pages_pa_list[],
+ * is never chained.
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
+		/* Point the last entry of a page to the next page. */
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

