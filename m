Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E44B8DFE;
	Wed, 13 May 2026 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685111; cv=none; b=KtuUuUN092fraMWw9rklImYpjNtRj5s/7Pm2+L6jd3lpOEf+wlw1MGHFMY5via2fLcD94XbTTUnjZdNPWT5NLkTW7QsdIrxZy3hyYtfOblTaFEQM64AxSp3S5Arr6qVt84Xa2zR+Ybab774mmOf2BA3nbUhjMtVg1ls0P/tdhlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685111; c=relaxed/simple;
	bh=LURwXxL3ZES66KefMxpDI/LyPCZOYuRnZoQInq//gkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwX5mTWcTRCmCcF23uV2ik6ZbJw4ihX6z75nPWPmLVAcy/gfKUorQExvCqUjXLmsxEbcPgBih/XyOUJm8ohAoutvqeuCAU4eQ5c6ANmfuzjd8qv/6viGpsgYAVnCma1iuGPCWAIBR7K5XfjVs2uwnTfemK7/Nq1C/qs38hHBquA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dV6egZ3Q; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dV6egZ3Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685109; x=1810221109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LURwXxL3ZES66KefMxpDI/LyPCZOYuRnZoQInq//gkk=;
  b=dV6egZ3QXZbYGLr/tKum2Os69Vf7tBXjuJ6inHSSuJmOe3M7R97dGOb4
   GT7xfKAz4Mn7q7TQ7WfkN8vpqGf9I85ZnIMwCgTYFsdScUgmHrBfR4lFU
   qk9HJq4MuUZS+Upd47vH9bW8rCR/y5uL+jH5ikdFi5dXANzUQDTv5nl3h
   m0wnw4m3MwnbOR3GbKZZo+f3cY2WEEZakDTmw9mpf2tNNTkgyw016uvBK
   PlTjnFUGflQYpg7sYCm3MszPSd9O/uwuQER5wU9Q/cL47Tpz0XxMoUQGY
   vAQKvs5HGPS0o25+IP/Ff3W2OiSWT7JQ/UTEftqHnhea0P/qI7kwDFMZ6
   Q==;
X-CSE-ConnectionGUID: oGEPKBQ+S26YnliykcO25Q==
X-CSE-MsgGUID: oQM+2mM/SSqMvlyT8rCTug==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921698"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921698"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:49 -0700
X-CSE-ConnectionGUID: YXnmXjqRSMiD80Dv8jQ8Rw==
X-CSE-MsgGUID: oyJ1H6rFQYmsHbJDr8dLbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716827"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:48 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dave.hansen@linux.intel.com,
	djbw@kernel.org,
	ira.weiny@intel.com,
	kai.huang@intel.com,
	kas@kernel.org,
	nik.borisov@suse.com,
	paulmck@kernel.org,
	pbonzini@redhat.com,
	reinette.chatre@intel.com,
	rick.p.edgecombe@intel.com,
	sagis@google.com,
	seanjc@google.com,
	tony.lindgren@linux.intel.com,
	vannapurve@google.com,
	vishal.l.verma@intel.com,
	yilun.xu@linux.intel.com,
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v9 11/23] x86/virt/seamldr: Allocate and populate a module update request
Date: Wed, 13 May 2026 08:09:54 -0700
Message-ID: <20260513151045.1420990-12-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513151045.1420990-1-chao.gao@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two important ABIs here:

'struct tdx_image'	- The on-disk and in-memory format for a TDX
			  module update image.
'struct seamldr_params'	- The in-memory ABI passed to the TDX module
			  loader. Points to a single 'struct tdx_image'

Userspace supplies the update image in struct tdx_image format. The image
consists of a header followed by a sigstruct and the module binary.

P-SEAMLDR, however, consumes struct seamldr_params rather than the image
directly. Parse the struct tdx_image provided by userspace and populate a
matching struct seamldr_params.

Validate the struct tdx_image header before using it, because the header is
consumed solely by the kernel to locate the sigstruct and module within
the image. Do not validate the payload itself. The sigstruct and module
pages are passed through to P-SEAMLDR, which validates them as part of the
update flow.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
sigstruct_pages_pa_list currently has only one entry, but it will grow to
four pages in the future. Keep it as an array for symmetry with
module_pages_pa_list and for extensibility.

v9:
 - define a new format, basically don't use offset_of_module but use
   sigstruct/module_nr_pages if the offset should be paged-aligned. this
   saves alignment checks and bound checks.
 - add a tdx_image_header struct to avoid using sizeof() for a struct with
   variable array.
 - rewrite the changelog to call out that this patch is to convert an ABI from
   what userspace provides to an ABI the P-SEAMLDR consums.
 - minimize casts and shifts and weird math
---
 arch/x86/virt/vmx/tdx/seamldr.c | 126 +++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 7b345000d7c3..929203ec96f2 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -7,6 +7,7 @@
 #define pr_fmt(fmt)	"seamldr: " fmt
 
 #include <linux/mm.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 
 #include <asm/seamldr.h>
@@ -16,6 +17,33 @@
 /* P-SEAMLDR SEAMCALL leaf function */
 #define P_SEAMLDR_INFO			0x8000000000000000
 
+#define SEAMLDR_MAX_NR_MODULE_PAGES	496
+#define SEAMLDR_MAX_NR_SIG_PAGES	1
+
+/*
+ * The seamldr_params "scenario" field specifies the operation mode:
+ * 0: Install TDX module from scratch (not used by kernel)
+ * 1: Update existing TDX module to a compatible version
+ */
+#define SEAMLDR_SCENARIO_UPDATE		1
+
+/*
+ * This is called the "SEAMLDR_PARAMS" data structure and is defined
+ * in "SEAM Loader (SEAMLDR) Interface Specification".
+ *
+ * It describes the TDX module that will be installed.
+ */
+struct seamldr_params {
+	u32	version;
+	u32	scenario;
+	u64	sigstruct_pages_pa_list[SEAMLDR_MAX_NR_SIG_PAGES];
+	u8	reserved[104];
+	u64	module_nr_pages;
+	u64	module_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
+} __packed;
+
+static_assert(sizeof(struct seamldr_params) == 4096);
+
 /*
  * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
  * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
@@ -43,6 +71,89 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
 
+#define TDX_IMAGE_VERSION_2		0x200
+
+struct tdx_image_header {
+	u16	version; // This ABI is always 0x200
+	u16	checksum;
+	u8	signature[8];
+	u32	sigstruct_nr_pages;
+	u32	module_nr_pages;
+	u8	reserved[4076];
+} __packed;
+
+#define HEADER_SIZE sizeof(struct tdx_image_header)
+static_assert(HEADER_SIZE == 4096);
+
+/* Intel TDX module update ABI structure. aka. "TDX module blob". */
+struct tdx_image {
+	struct tdx_image_header header;
+	u8 payload[]; // Contains sigstruct pages followed by module pages
+};
+
+static void populate_pa_list(u64 *pa_list, u32 max_entries, const u8 *start, u32 nr_pages)
+{
+	int i;
+
+	nr_pages = MIN(nr_pages, max_entries);
+	for (i = 0; i < nr_pages; i++) {
+		pa_list[i] = vmalloc_to_pfn(start) << PAGE_SHIFT;
+		start += PAGE_SIZE;
+	}
+}
+
+static void populate_seamldr_params(struct seamldr_params *params,
+				    const u8 *sig, u32 sig_nr_pages,
+				    const u8 *mod, u32 mod_nr_pages)
+{
+	params->version			= 0;
+	params->scenario		= SEAMLDR_SCENARIO_UPDATE;
+	params->module_nr_pages		= mod_nr_pages;
+
+	populate_pa_list(params->sigstruct_pages_pa_list, SEAMLDR_MAX_NR_SIG_PAGES,
+			 sig, sig_nr_pages);
+	populate_pa_list(params->module_pages_pa_list, SEAMLDR_MAX_NR_MODULE_PAGES,
+			 mod, mod_nr_pages);
+}
+
+static int init_seamldr_params(struct seamldr_params *params, const u8 *data, u32 size)
+{
+	const struct tdx_image *image		= (const void *)data;
+	const struct tdx_image_header *header	= &image->header;
+
+	u32 sigstruct_len	= header->sigstruct_nr_pages * PAGE_SIZE;
+	u32 module_len		= header->module_nr_pages * PAGE_SIZE;
+
+	u8 *header_start	= (u8 *)header;
+	u8 *header_end		= header_start + HEADER_SIZE;
+
+	u8 *sigstruct_start	= header_end;
+	u8 *sigstruct_end	= sigstruct_start + sigstruct_len;
+
+	u8 *module_start	= sigstruct_end;
+
+	/* Check the calculated payload size against the data size. */
+	if (HEADER_SIZE + sigstruct_len + module_len != size)
+		return -EINVAL;
+
+	/*
+	 * Don't care about user passing the wrong file, but protect
+	 * kernel ABI by preventing accepting garbage.
+	 */
+	if (header->version != TDX_IMAGE_VERSION_2)
+		return -EINVAL;
+
+	if (memcmp(header->signature, "TDX-BLOB", sizeof(header->signature)))
+		return -EINVAL;
+
+	if (memchr_inv(header->reserved, 0, sizeof(header->reserved)))
+		return -EINVAL;
+
+	populate_seamldr_params(params, sigstruct_start, header->sigstruct_nr_pages,
+				module_start, header->module_nr_pages);
+	return 0;
+}
+
 /**
  * seamldr_install_module - Install a new TDX module.
  * @data: Pointer to the TDX module image.
@@ -52,7 +163,20 @@ EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
  */
 int seamldr_install_module(const u8 *data, u32 size)
 {
+	struct seamldr_params *params;
+	int ret;
+
+	params = kzalloc_obj(*params);
+	if (!params)
+		return -ENOMEM;
+
+	ret = init_seamldr_params(params, data, size);
+	if (ret)
+		goto out;
+
 	/* TODO: Update TDX module here */
-	return 0;
+out:
+	kfree(params);
+	return ret;
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_install_module, "tdx-host");
-- 
2.52.0

