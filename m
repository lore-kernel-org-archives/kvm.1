Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECCA14A4F0;
	Mon, 27 Apr 2026 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303804; cv=none; b=jYu612sSerwiTf34kmOlhGwtI7JH+oQMsNfZumZQiPxAhSp4drWsH3JmJ3ZxaqW71/eymLYCRXtRllfXVpgCXY3sigrf9IEJ7gCYHQ0j8XrKBUG2LYUR5i9+HAoTsfTV93enEcUPdrwSCiCuZawXoYZcLE88ZXn46z01gWswx7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303804; c=relaxed/simple;
	bh=bYjbc69A8zGruZ+zi8SjXIkHOPsqT90J/RUZegvsP2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anZVjNwOJUGkufIqjQpRM4bqz56qsNr5Q8HzKXrdN3bAP0WjsGvOKyFKOXgwCz+E67SPvZoN6EH3Ja18bGjUBx6b2c7iwmi4e+5FDjrkv3A38F/2LGOj1TqPD0VoeUxr1BqefN14q4w/MwowMyQsZTKggzsqx5v8vHsE17S1s0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MmhVo/8D; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MmhVo/8D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777303802; x=1808839802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYjbc69A8zGruZ+zi8SjXIkHOPsqT90J/RUZegvsP2o=;
  b=MmhVo/8DgruDiu0Kgxx1g5ijq4iy+/T8O4r0bOjIClLwxcMNNOv6x2rW
   GCn1royOMEutWq37juzmd7SBFwnFjzXAuqS4nxeFK9xMU10C07iHieoWc
   3EDNSfTsnJCqEX1qHDnuJhtP2KYe4qB2YwNzZXyP0MRwRf9hTlcZi6guf
   a+jJ/uwwNqDZVcFjvktuwByCh9C5kELjtOLDxzqarpLcLPIBEK/NIhxDS
   VSRFBP9mfQjSQQaUoQbSIinIgVGUjsb0LheQ/5TpWOVGVSujVjzZVC9a/
   qCFvQ5aXkMM++UEdJzUJyVRLF1PNU+C/KVyMcrzUEjSo8nF7zJcT8nSk1
   A==;
X-CSE-ConnectionGUID: 4v2TkQ+pSAqk2Mwa0B6tYA==
X-CSE-MsgGUID: O52dH+X/SY6LDa4TZ3i4Jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77900707"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77900707"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:29:59 -0700
X-CSE-ConnectionGUID: 4LQMalnkSRuA32tY42rbnw==
X-CSE-MsgGUID: cvgX8Q3YRgaa1Zf3Gt8EfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232673243"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 08:29:59 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
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
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v8 08/21] x86/virt/seamldr: Allocate and populate a module update request
Date: Mon, 27 Apr 2026 08:28:02 -0700
Message-ID: <20260427152854.101171-9-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260427152854.101171-1-chao.gao@intel.com>
References: <20260427152854.101171-1-chao.gao@intel.com>
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

Parse the tdx_blob format and populate a SEAMLDR_PARAMS structure. The
header is consumed solely by the kernel to extract the sigstruct and
module, so validate it before processing to protect the kernel ABI. The
sigstruct and module are passed to and validated by P-SEAMLDR, so don't
duplicate any validation in the kernel.

Note: the sigstruct_pa field in SEAMLDR_PARAMS has been extended to
a 4-element array. The updated "SEAM Loader (SEAMLDR) Interface
Specification" will be published separately.

Signed-off-by: Chao Gao <chao.gao@intel.com>
---
v8:
 - Consolidate all tdx_blob validation into a dedicated helper instead of
 scattering checks across two functions. [Rick]
 - Clarify which validations are performed by the kernel and which are
 intentionally left to P-SEAMLDR/userspace. [Rick]
 - Drop free_seamldr_params() helper [Rick]
 - Change params->version assignment to a single sig_size > 4K expression
 [Rick]
 - Don't preemptively handle "PAGE_SIZE != 4KB" [Dave]
---
 arch/x86/virt/vmx/tdx/seamldr.c | 155 ++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 650c0f097aac..f70be8e2a07b 100644
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
+#define SEAMLDR_MAX_NR_SIG_PAGES	4
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
+	u64	sigstruct_pa[SEAMLDR_MAX_NR_SIG_PAGES];
+	u8	reserved[80];
+	u64	num_module_pages;
+	u64	mod_pages_pa_list[SEAMLDR_MAX_NR_MODULE_PAGES];
+} __packed;
+
+static_assert(sizeof(struct seamldr_params) == 4096);
+
 /*
  * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
  * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
@@ -43,6 +71,128 @@ int seamldr_get_info(struct seamldr_info *seamldr_info)
 }
 EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
 
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
+/*
+ * Blob fields are processed by the kernel and the payloads
+ * are passed to the TDX module. Do normal user input type
+ * check for any fields that don't get passed to the TDX module.
+ */
+static const struct tdx_blob *get_and_check_blob(const u8 *data, u32 size)
+{
+	const struct tdx_blob *blob = (const void *)data;
+
+	/*
+	 * Ensure the size is valid otherwise reading any field from the
+	 * blob may overflow.
+	 */
+	if (size <= sizeof(struct tdx_blob))
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Don't care about user passing the wrong file, but protect
+	 * kernel ABI by preventing accepting garbage.
+	 */
+	if (memcmp(blob->signature, "TDX-BLOB", 8))
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * Ensure the offset of the module is within valid bounds and
+	 * page-aligned.
+	 */
+	if (blob->offset_of_module >= size || blob->offset_of_module <= sizeof(struct tdx_blob))
+		return ERR_PTR(-EINVAL);
+	if (!IS_ALIGNED(blob->offset_of_module, PAGE_SIZE))
+		return ERR_PTR(-EINVAL);
+
+	if (blob->version != TDX_BLOB_VERSION_1)
+		return ERR_PTR(-EINVAL);
+
+	if (blob->reserved0 || memchr_inv(blob->reserved1, 0, sizeof(blob->reserved1)))
+		return ERR_PTR(-EINVAL);
+
+	return blob;
+}
+
+static struct seamldr_params *alloc_seamldr_params(const struct tdx_blob *blob, unsigned int blob_size)
+{
+	struct seamldr_params *params;
+	int module_pg_cnt, sig_pg_cnt;
+	const u8 *sig, *module;
+	int i;
+
+	params = (struct seamldr_params *)get_zeroed_page(GFP_KERNEL);
+	if (!params)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Split the blob into a sigstruct and a module. Assume all
+	 * size/offsets are within bounds of blob_size due to prior checks.
+	 */
+	sig		= blob->data;
+	sig_pg_cnt	= (blob->offset_of_module - sizeof(struct tdx_blob)) >> PAGE_SHIFT;
+	module		= (const u8 *)blob + blob->offset_of_module;
+	module_pg_cnt	= (blob_size - blob->offset_of_module) >> PAGE_SHIFT;
+
+	/*
+	 * Only use version 1 when required (sigstruct > 4KB) for backward
+	 * compatibility with P-SEAMLDR that lacks version 1 support.
+	 */
+	params->version = sig_pg_cnt > 1;
+	params->scenario = SEAMLDR_SCENARIO_UPDATE;
+
+	for (i = 0; i < MIN(sig_pg_cnt, SEAMLDR_MAX_NR_SIG_PAGES); i++) {
+		params->sigstruct_pa[i] = vmalloc_to_pfn(sig) << PAGE_SHIFT;
+		sig += PAGE_SIZE;
+	}
+
+	params->num_module_pages = MIN(module_pg_cnt, SEAMLDR_MAX_NR_MODULE_PAGES);
+	for (i = 0; i < params->num_module_pages; i++) {
+		params->mod_pages_pa_list[i] = vmalloc_to_pfn(module) << PAGE_SHIFT;
+		module += PAGE_SIZE;
+	}
+
+	return params;
+}
+
+static struct seamldr_params *init_seamldr_params(const u8 *data, u32 size)
+{
+	const struct tdx_blob *blob;
+
+	blob = get_and_check_blob(data, size);
+	if (IS_ERR(blob))
+		return ERR_CAST(blob);
+
+	return alloc_seamldr_params(blob, size);
+}
+
+DEFINE_FREE(free_seamldr_params, struct seamldr_params *,
+	    if (!IS_ERR_OR_NULL(_T)) free_page((unsigned long)_T))
+
 /**
  * seamldr_install_module - Install a new TDX module.
  * @data: Pointer to the TDX module update blob.
@@ -52,6 +202,11 @@ EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
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
2.47.1

