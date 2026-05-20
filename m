Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2907F3E5ED7;
	Wed, 20 May 2026 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284424; cv=none; b=IY5FQcUT24soeos+/l+WOMECYUYGOMQEevsS5JCiZxH3fpYGO9dY1ezk2Pq+P+mFhcZNSdqGweK1PPYZb80qfc707EL6jnpgwYRdpRGR0Sj2uKhsGNiC3B9H6Zc5RZqaobf/iR0QZt4CxulcjpL8thGj4qZRA2jmw9IwOlVMKTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284424; c=relaxed/simple;
	bh=2uRkB7s6oabhaBTOUeY7fNLUBuDLjjsV/PBO02yCpxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmUQ6JsD9hCqDDYYa2O2IPHYy0XO56XvOvi4z1InsqdEZf20wEnjDah7DCx/royFpzh2OvgAjO11CT67KJVRDL+MGgm0dmHbcBJwaN+rUKZ2chrlRBqtncTOEnBAxOAtxC9oGuzQ2jjcTlCrtcgFiKe4EGXHuU4eQWu24aza6QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GFD8vxBX; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GFD8vxBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284422; x=1810820422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2uRkB7s6oabhaBTOUeY7fNLUBuDLjjsV/PBO02yCpxQ=;
  b=GFD8vxBXabHQnqkemPGzYjUSillZf0xWL/XMCADJ/rYJWJp5JIVoFjZI
   ub1b8MRn6ye+G9ZiG59KJ/adKQ6Gu5fVTaekWC3TWG3o6C1HkolB2QARp
   3S2R52gS15kgHWuDWoWkJGgjb/sTgEqrEzpXX6HCb6YzFkGLqaLYOI073
   o6CY+/NH9YUVYGoWwA8LjwbBtIkgkoH3nFG/9hemr22r2nFZ5OgSKSIqX
   9eEI2vIUrOrSkalNCoZgXF27HaGUc6BTX/9F2m66dn4uNk6PYB9j60yPD
   KMp/vWVy1JO22xhnR1dfz2kTlgZFHl5OJ9y/uJG0ydQQ6LGSiZRWKUB2n
   Q==;
X-CSE-ConnectionGUID: PmW/byrWSH6P+1mvl6/mDw==
X-CSE-MsgGUID: YxraRti8TMiEw1U7ww8weQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146514"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146514"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:18 -0700
X-CSE-ConnectionGUID: K6R2RWyXSASJL9BuzPd1cg==
X-CSE-MsgGUID: BdGEX0EESlWAunUzgeQMHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923873"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:17 -0700
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
Subject: [PATCH v10 13/25] x86/virt/seamldr: Allocate and populate a module update request
Date: Wed, 20 May 2026 06:38:16 -0700
Message-ID: <20260520133909.409394-14-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133909.409394-1-chao.gao@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
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
			  broken up into 4k pages.

Userspace supplies the update image in struct tdx_image format. The
image consists of a header followed by a sigstruct and the module
binary. P-SEAMLDR, however, consumes struct seamldr_params rather than
the image directly.

Parse the struct tdx_image provided by userspace and populate a matching
struct seamldr_params.

The 'tdx_image' ABI is versioned. Two public versions exist today: 0x100
and 0x200. This kernel only accepts 0x200. The older 0x100 format is being
deprecated and is intentionally not supported here. Future versions of the
module might be able to use the same ABIs (user/kernel and kernel/SEAMLDR)
but they will not be able to use this kernel code.

Reject module images without that specific version. This ensures that the
kernel is able to understand the passed-in format.

Validate the struct tdx_image header before using it, because the header is
consumed solely by the kernel to locate the sigstruct and module within
the image. Do not validate the payload itself. The sigstruct and module
pages are passed through to P-SEAMLDR, which validates them as part of the
update flow.

sigstruct_pages_pa_list currently has only one entry, but it will grow to
four pages in the future. Keep it as an array for symmetry with
module_pages_pa_list and for extensibility.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
v10:
 - Add comments for init_seamldr_params() and its call site [Dave]
 - Use data_len/image_len rather than size [Dave]
 - Do bounds check rather than implicitly truncat the update image [Dave]
 - Explain why the header version is checked in changelog [Dave]
 - make init_seamldr_params() accept a tdx_image pointer [Dave]
 - vertical alignment for code has a pattern [Dave]
---
 arch/x86/virt/vmx/tdx/seamldr.c | 145 +++++++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index d3880b0f93aa..11bd28e8370c 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -6,6 +6,8 @@
  */
 #define pr_fmt(fmt)	"seamldr: " fmt
 
+#include <linux/mm.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 
 #include <asm/seamldr.h>
@@ -15,6 +17,35 @@
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
+ * This is the "SEAMLDR_PARAMS" data structure defined in the
+ * "SEAM Loader (SEAMLDR) Interface Specification".
+ *
+ * It is the in-memory ABI that the kernel passes to the P-SEAMLDR
+ * to update the TDX module. It breaks the TDX module image up in
+ * page-size pieces.
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
@@ -42,6 +73,98 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
 
+#define TDX_IMAGE_VERSION_2		0x200
+
+struct tdx_image_header {
+	u16	version;
+	u16	checksum;
+	u8	signature[8];
+	u32	sigstruct_nr_pages;
+	u32	module_nr_pages;
+	u8	reserved[4076];
+} __packed;
+
+#define TDX_IMAGE_HEADER_SIZE sizeof(struct tdx_image_header)
+static_assert(TDX_IMAGE_HEADER_SIZE == 4096);
+
+/*
+ * Intel TDX module update ABI structure. aka. "TDX module blob".
+ *
+ * @payload contains sigstruct pages followed by module pages.
+ */
+struct tdx_image {
+	struct tdx_image_header header;
+	u8 payload[];
+};
+
+static void populate_pa_list(u64 *pa_list, const u8 *vmalloc_addr, u32 vmalloc_len_pages)
+{
+	int i;
+
+	for (i = 0; i < vmalloc_len_pages; i++) {
+		unsigned long offset = i * PAGE_SIZE;
+		unsigned long pfn = vmalloc_to_pfn(&vmalloc_addr[offset]);
+
+		pa_list[i] = pfn << PAGE_SHIFT;
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
+	populate_pa_list(params->sigstruct_pages_pa_list, sig, sig_nr_pages);
+	populate_pa_list(params->module_pages_pa_list, mod, mod_nr_pages);
+}
+
+/*
+ * @image points to a vmalloc()'d 'struct tdx_image'. Transform
+ * it into @params which is the P-SEAMLDR ABI format.
+ */
+static int init_seamldr_params(struct seamldr_params *params,
+			       const struct tdx_image *image,
+			       u32 image_len)
+{
+	const struct tdx_image_header *header	= &image->header;
+
+	u32 sigstruct_len	= header->sigstruct_nr_pages * PAGE_SIZE;
+	u32 module_len		= header->module_nr_pages * PAGE_SIZE;
+
+	u8 *header_start	= (u8 *)header;
+	u8 *header_end		= header_start + TDX_IMAGE_HEADER_SIZE;
+
+	u8 *sigstruct_start	= header_end;
+	u8 *sigstruct_end	= sigstruct_start + sigstruct_len;
+
+	u8 *module_start	= sigstruct_end;
+
+	/* Check the calculated payload size against the image size. */
+	if (TDX_IMAGE_HEADER_SIZE + sigstruct_len + module_len != image_len)
+		return -EINVAL;
+
+	/* Reject unsupported tdx_image ABI versions. */
+	if (header->version != TDX_IMAGE_VERSION_2)
+		return -EINVAL;
+
+	if (header->sigstruct_nr_pages > SEAMLDR_MAX_NR_SIG_PAGES ||
+	    header->module_nr_pages > SEAMLDR_MAX_NR_MODULE_PAGES)
+		return -EINVAL;
+
+	if (memcmp(header->signature, "TDX-BLOB", sizeof(header->signature)))
+		return -EINVAL;
+
+	if (memchr_inv(header->reserved, 0, sizeof(header->reserved)))
+		return -EINVAL;
+
+	populate_seamldr_params(params, sigstruct_start, header->sigstruct_nr_pages,
+					module_start,    header->module_nr_pages);
+	return 0;
+}
+
 /**
  * seamldr_install_module - Install a new TDX module.
  * @data: Pointer to the TDX module image.
@@ -51,7 +174,27 @@ EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
  */
 int seamldr_install_module(const u8 *data, u32 data_len)
 {
+	struct seamldr_params *params;
+	const struct tdx_image *image;
+	int ret;
+
+	if (data_len < TDX_IMAGE_HEADER_SIZE)
+		return -EINVAL;
+
+	image = (const struct tdx_image *)data;
+
+	params = kzalloc_obj(*params);
+	if (!params)
+		return -ENOMEM;
+
+	/* Populate 'params' from 'image'. */
+	ret = init_seamldr_params(params, image, data_len);
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

