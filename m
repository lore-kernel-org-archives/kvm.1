Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E6633D505;
	Tue,  4 Aug 2026 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843070; cv=none; b=X9jkhKCbGl7cKjF6uwA424MVD8z3Cm928rVeoYzZX9Vv9tYNPF0FhBgAzzWxJZURLB26wPSsw7hX6aWBvWcB/yJWN9oSSNfamcamP/EtrnLG1RPF8S59/GuVJxnRcAYUM/oguu0ZpIU1ytk1fiEqMVqhGuv+vRTZ+QkHqcQgwvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843070; c=relaxed/simple;
	bh=4tIWKSUatttvcOASc90QvXOofpl3r/2ODnAEdzoKkQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gejRpaS94751fwWhgj9SHytbkJtEJI4tuZ8PZc+8PBX1p7nvS9oNAgBMXkovSkzTxcC0jpDxN64IncQl31sCeBcB2SwVqDWlKmBWZ+Ilw5zQqcoaYMAiL5gKxTxWEhWlXpksF9ICslSwMpuXv/3O5kRqYAA6KRPOIeAaUTfnqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a97hLO0s; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a97hLO0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785843069; x=1817379069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4tIWKSUatttvcOASc90QvXOofpl3r/2ODnAEdzoKkQE=;
  b=a97hLO0s+QyEHdr2lV7UdAFAo9NDA0LzdJg7UT8Ajts3qZAxyLZDd9zh
   6HV7Gx+tcdccCN23mveWjNrDSfvqGstcqxDJFsMcKnXCrKe25Oe5SUuhi
   taChGqBqIwJk7FIq0S+7KSeGP2yz6hBVmyJQQpZ/n+0JDS1ztujmLgOuy
   B3zhGh3RD2o0deLN0ya+Lk5MMwImLTJwQ24gpHN+lRz6qonl+gZH51DGb
   hcgukev+6aRpVmNl3ade30WZeNfjTMaYe/Zlbe8+u2gEEaK7eZ3hJTi70
   BlaS1Yy1cm6B5HeiazWqNHGLjTp93GF1+AEKhOSnNz5ToznD4k0s7ltq1
   Q==;
X-CSE-ConnectionGUID: rNTGQ6sBSQCw47e0kPlqVQ==
X-CSE-MsgGUID: 13Rm3f1CQOSjjbSb1Cnnbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86244238"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86244238"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:07 -0700
X-CSE-ConnectionGUID: AJVEuxWtTYGP0KkcDpEa6g==
X-CSE-MsgGUID: 6HrtbajUTEabBjP7bDUXGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265323099"
Received: from jf.jf.intel.com (HELO 984fee019967.jf.intel.com) ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:07 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	kas@kernel.org,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com
Subject: [PATCH v1 2/8] x86/virt/tdx: Name the TDX module global metadata field IDs
Date: Tue,  4 Aug 2026 04:29:30 -0700
Message-ID: <20260804112941.19894-3-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260804112941.19894-1-chao.gao@intel.com>
References: <20260804112941.19894-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Hansen <dave@sr71.net>

tdx_global_metadata.c currently identifies each field by a bare 64-bit hex
literal, extracted from the JSON file by an out-of-tree script:

	if (!ret && !(ret = read_sys_metadata_field(0x9100000100000008, &val)))
		sysinfo_tdmr->max_tdmrs = val;

That is unreviewable on its own. Verifying any one line requires the
reviewer to cross-reference the JSON file.

Add MD_FIELD_ID_<NAME> constants for every global metadata field the kernel
currently reads (Version, Features, etc), grouped by class. This follows
how the kernel handles ABI-defined literals elsewhere. The IDs can then be
checked against the spec in one pass, and the read sites become readable
without the JSON file.

The hex literals in tdx_global_metadata.c are left alone because that file
will be replaced by a table-driven reader in the following patches.

No functional change intended.

Assisted-by: Claude:claude-opus-5
Not-yet-signed-off-by: Dave Hansen <dave@sr71.net>
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.h | 51 +++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index bdfd0e1e337a..5f567cb6c07a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -58,6 +58,57 @@
  */
 #define TDX_VERSION_SHIFT		16
 
+/*
+ * Global Scope Metadata field IDs.
+ *
+ * See "Global-Scope (TDX Module) Metadata" in the Intel TDX Module ABI
+ * spec.
+ *
+ * A field ID is a 64-bit value that encodes the metadata "Class"
+ * (which Linux mirrors in 'struct tdx_sys_info' sub-structures),
+ * the element size, and a per-class field index. Each ID below
+ * is paired with the C member that holds its value.
+ */
+
+/* Class "TDX Module Version" */
+#define MD_FIELD_ID_MINOR_VERSION		0x0800000100000003ULL
+#define MD_FIELD_ID_MAJOR_VERSION		0x0800000100000004ULL
+#define MD_FIELD_ID_UPDATE_VERSION		0x0800000100000005ULL
+
+/* Class "TDX Features" */
+#define MD_FIELD_ID_TDX_FEATURES0		0x0A00000300000008ULL
+
+/* Class "TDMR Info" */
+#define MD_FIELD_ID_MAX_TDMRS			0x9100000100000008ULL
+#define MD_FIELD_ID_MAX_RESERVED_PER_TDMR	0x9100000100000009ULL
+#define MD_FIELD_ID_PAMT_4K_ENTRY_SIZE		0x9100000100000010ULL
+#define MD_FIELD_ID_PAMT_2M_ENTRY_SIZE		0x9100000100000011ULL
+#define MD_FIELD_ID_PAMT_1G_ENTRY_SIZE		0x9100000100000012ULL
+
+/* Class "TD Control Structures" */
+#define MD_FIELD_ID_TDR_BASE_SIZE		0x9800000100000000ULL
+#define MD_FIELD_ID_TDCS_BASE_SIZE		0x9800000100000100ULL
+#define MD_FIELD_ID_TDVPS_BASE_SIZE		0x9800000100000200ULL
+
+/* Class "TD Configuration" */
+#define MD_FIELD_ID_ATTRIBUTES_FIXED0		0x1900000300000000ULL
+#define MD_FIELD_ID_ATTRIBUTES_FIXED1		0x1900000300000001ULL
+#define MD_FIELD_ID_XFAM_FIXED0			0x1900000300000002ULL
+#define MD_FIELD_ID_XFAM_FIXED1			0x1900000300000003ULL
+#define MD_FIELD_ID_NUM_CPUID_CONFIG		0x9900000100000004ULL
+#define MD_FIELD_ID_MAX_VCPUS_PER_TD		0x9900000100000008ULL
+
+/* Class "TDX Module Handoff" */
+#define MD_FIELD_ID_MODULE_HV			0x8900000100000000ULL
+
+/*
+ * Base IDs for the configurable-CPUID arrays.  The field ID of leaf
+ * index @i is BASE + i; for the values array, sub-entry @j of index
+ * @i is BASE + i*2 + j.
+ */
+#define MD_FIELD_ID_CPUID_CONFIG_LEAVES		0x9900000300000400ULL
+#define MD_FIELD_ID_CPUID_CONFIG_VALUES		0x9900000300000500ULL
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
-- 
2.52.0

