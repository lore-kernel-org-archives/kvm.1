Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4C43B7749;
	Thu, 26 Mar 2026 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514740; cv=none; b=LTdoYqMaCoJgY1+xIgrDf7B1U/ucCvFZdmVLOKOLASr4B84HMqDUmm4SQo5yRqwDin1V/MbQqPfG6+MnZoCQLU/R8CAzhJWdDSmtjV8fPjMrvEH7LF2w4F/+39B7mkQ9ecGWR+1lI98lXzaNNl5OD72Ac+iEisUv6nwnY2SP7sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514740; c=relaxed/simple;
	bh=663YVeX0kyucwfVjuR4oO6yvlRcROgM77m2krnSsF9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzN7SyXBkKIhtDUjq7yQvXJ66lprLvaLtKAtV/Czzh3OTFVUSHvfrqlElTNoX8Sm9a9YAPrUVH1tKVkSEzAJ1WwT4Wi7iZszem9oIjDtxWccS7Uwde3WZ+yPPpfPy5vNn0kKVoQplZcFeC+0mB9FTUGnwA+Vm1vdSY+R/1ZV8es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2kOsk4k; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2kOsk4k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514738; x=1806050738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=663YVeX0kyucwfVjuR4oO6yvlRcROgM77m2krnSsF9M=;
  b=Y2kOsk4kBUd0c1MXkFNQEyy1sMrEasoaQvpSel9Xr8OK5Pj9uiEI0uUh
   wOSzHE/QZFyYED3BqFrXlg+jeoWBueedNvh5T7crBuSNKfA5DqI+sxjH4
   tTXYEEZJK1agznLTfXrNCHw1ODT76OKdU+gQfeCvS21iFyGzdKWq4A1hE
   NU4rMMDWsi/eDZrb+ZTUE5x+KPBbx5hKq9BqClgfHto/U0w5n8ZECJU+f
   Kd8BVY+ic1ouWSyLENoV865cvOnB2MYazZJ2mLJ9zT694PwWhGEwRKzBO
   kzDQxuc/SRby2vfGGQf8BVHArg9NOjtCXv3dyHqFmqowXXkDVPFY4x76T
   w==;
X-CSE-ConnectionGUID: wlycBYTnQCyuwI+MsQCdJw==
X-CSE-MsgGUID: qdfHyLX5Qhen8MTS8pgzEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644668"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644668"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:21 -0700
X-CSE-ConnectionGUID: +TYYb0C5SwGrylMUpl0xyA==
X-CSE-MsgGUID: wRNNYkUuS/24hsifG0UENg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967188"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:20 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: binbin.wu@linux.intel.com,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
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
Subject: [PATCH v6 08/22] x86/virt/seamldr: Allocate and populate a module update request
Date: Thu, 26 Mar 2026 01:43:59 -0700
Message-ID: <20260326084448.29947-9-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326084448.29947-1-chao.gao@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

P-SEAMLDR uses the SEAMLDR_PARAMS structure to describe TDX module
update requests. This structure contains physical addresses pointing to
the module binary and its signature file (or sigstruct), along with an
update scenario field.

TDX modules are distributed in the tdx_blob format defined in
blob_structure.txt from the "Intel TDX module Binaries Repository". A
tdx_blob contains a header, sigstruct, and module binary. This is also the
format supplied by the userspace to the kernel.

Parse the tdx_blob format and populate a SEAMLDR_PARAMS structure
accordingly. This structure will be passed to P-SEAMLDR to initiate the
update.

Note that the sigstruct_pa field in SEAMLDR_PARAMS has been extended to
a 4-element array. The updated "SEAM Loader (SEAMLDR) Interface
Specification" will be published separately. P-SEAMLDR compatibility
validation (such as 4KB vs 16KB sigstruct support) is left to userspace,
which must verify the P-SEAMLDR version meets the TDX module's minimum
requirements.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
---
v6:
 - clarify tdx_blob's @offset_of_module and @len fields [Kiryl]
 - clarify comment to explicitly call out the PAGE_SIZE != SZ_4K case
   [Kiryl]
v5:
 - use a macro for tdx_blob version (0x100) [Yan]
 - don't do alignment checking for the binary/sigstruct [Rick]
 - drop blob's sigstruct and validation checking
 - set seamldr_params.version to 1 when necessary
 - drop the link to blob_structure.txt which might be unstable [Kai]

v4:
 - Remove checksum verification as it is optional
 - Convert comments to is_vmalloc_addr() checks [Kai]
 - Explain size/alignment checks in alloc_seamldr_params() [Kai]

v3:
 - Print tdx_blob version in hex [Binbin]
 - Drop redundant sigstruct alignment check [Yilun]
 - Note buffers passed from firmware upload infrastructure are
   vmalloc()'d above alloc_seamldr_params()
---
 arch/x86/virt/vmx/tdx/seamldr.c | 146 ++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index e93a5d90a3ee..a0bd02a59086 100644
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
 
+#define SEAMLDR_MAX_NR_MODULE_4KB_PAGES	496
+#define SEAMLDR_MAX_NR_SIG_4KB_PAGES	4
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
+	u64	sigstruct_pa[SEAMLDR_MAX_NR_SIG_4KB_PAGES];
+	u8	reserved[80];
+	u64	num_module_pages;
+	u64	mod_pages_pa_list[SEAMLDR_MAX_NR_MODULE_4KB_PAGES];
+} __packed;
+
+static_assert(sizeof(struct seamldr_params) == 4096);
+
 /*
  * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
  * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
@@ -42,6 +70,119 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
 
+static void free_seamldr_params(struct seamldr_params *params)
+{
+	free_page((unsigned long)params);
+}
+
+static struct seamldr_params *alloc_seamldr_params(const void *module, unsigned int module_size,
+						   const void *sig, unsigned int sig_size)
+{
+	struct seamldr_params *params;
+	const u8 *ptr;
+	int i;
+
+	if (module_size > SEAMLDR_MAX_NR_MODULE_4KB_PAGES * SZ_4K)
+		return ERR_PTR(-EINVAL);
+
+	if (sig_size > SEAMLDR_MAX_NR_SIG_4KB_PAGES * SZ_4K)
+		return ERR_PTR(-EINVAL);
+
+	params = (struct seamldr_params *)get_zeroed_page(GFP_KERNEL);
+	if (!params)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Only use version 1 when required (sigstruct > 4KB) for backward
+	 * compatibility with P-SEAMLDR that lacks version 1 support.
+	 */
+	if (sig_size > SZ_4K)
+		params->version = 1;
+	else
+		params->version = 0;
+
+	params->scenario = SEAMLDR_SCENARIO_UPDATE;
+
+	ptr = sig;
+	for (i = 0; i < sig_size / SZ_4K; i++) {
+		/*
+		 * @sig is 4KB-aligned, but that does not imply PAGE_SIZE
+		 * alignment when PAGE_SIZE != SZ_4K. Always include the
+		 * in-page offset.
+		 */
+		params->sigstruct_pa[i] = (vmalloc_to_pfn(ptr) << PAGE_SHIFT) +
+					  ((unsigned long)ptr & ~PAGE_MASK);
+		ptr += SZ_4K;
+	}
+
+	params->num_module_pages = module_size / SZ_4K;
+
+	ptr = module;
+	for (i = 0; i < params->num_module_pages; i++) {
+		params->mod_pages_pa_list[i] = (vmalloc_to_pfn(ptr) << PAGE_SHIFT) +
+					       ((unsigned long)ptr & ~PAGE_MASK);
+		ptr += SZ_4K;
+	}
+
+	return params;
+}
+
+/*
+ * Intel TDX module blob. Its format is defined at:
+ * https://github.com/intel/tdx-module-binaries/blob/main/blob_structure.txt
+ *
+ * Note this structure differs from the reference above: the two variable-length
+ * fields "@sigstruct" and "@module" are represented as a single "@data" field
+ * here and split programmatically using the offset_of_module value.
+ *
+ * Note @offset_of_module is relative to the start of struct tdx_blob, not
+ * @data, and @length is the total length of the blob, not the length of
+ * @data.
+ */
+struct tdx_blob {
+	u16	version;
+	u16	checksum;
+	u32	offset_of_module;
+	u8	signature[8];
+	u32	length;
+	u32	reserved0;
+	u64	reserved1[509];
+	u8	data[];
+} __packed;
+
+/* Supported versions of the tdx_blob */
+#define TDX_BLOB_VERSION_1	0x100
+
+static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
+{
+	const struct tdx_blob *blob = (const void *)data;
+	int module_size, sig_size;
+	const void *sig, *module;
+
+	/* Ensure the size is valid otherwise reading any field from the blob may overflow. */
+	if (size <= sizeof(struct tdx_blob) || size <= blob->offset_of_module)
+		return ERR_PTR(-EINVAL);
+
+	if (blob->version != TDX_BLOB_VERSION_1) {
+		pr_err("unsupported blob version: %x\n", blob->version);
+		return ERR_PTR(-EINVAL);
+	}
+
+	/* Split the blob into a sigstruct and a module. */
+	sig		= blob->data;
+	sig_size	= blob->offset_of_module - sizeof(struct tdx_blob);
+	module		= data + blob->offset_of_module;
+	module_size	= size - blob->offset_of_module;
+
+	if (sig_size <= 0 || module_size <= 0 || blob->length != size)
+		return ERR_PTR(-EINVAL);
+
+	return alloc_seamldr_params(module, module_size, sig, sig_size);
+}
+
+DEFINE_FREE(free_seamldr_params, struct seamldr_params *,
+	    if (!IS_ERR_OR_NULL(_T)) free_seamldr_params(_T))
+
 /**
  * seamldr_install_module - Install a new TDX module.
  * @data: Pointer to the TDX module update blob.
@@ -51,6 +192,11 @@ EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
  */
 int seamldr_install_module(const u8 *data, u32 size)
 {
+	struct seamldr_params *params __free(free_seamldr_params) =
+						init_seamldr_params(data, size);
+	if (IS_ERR(params))
+		return PTR_ERR(params);
+
 	/* TODO: Update TDX module here */
 	return 0;
 }
-- 
2.47.3

