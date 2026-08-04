Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE70340A46;
	Tue,  4 Aug 2026 11:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843070; cv=none; b=RkorAdWRjvEQlPTiAeVckaIFB+vycwCii8DucN9z3Je1NZ2+Gv+BP1Ce6CQ8dcSuYAn9fG60kh837yZHJ3dw0moVuBkQtH4KNy8J9/FKOQeuHIbBvr6IAZE/ZvQew4BN5YXftI3UzrtgP32ycTeXwK31mDkBQX4BHfyp0zW3W98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843070; c=relaxed/simple;
	bh=5RnmrpWOMDV86PTzf5eDaOGgp0G0DtsVia13f/Ss7q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPvD0aaGiL0I9XHY1LBGXRpTaQErVjXX5rAFr8jVm6KTRn+w3dUADiENbVYiTCLwrA2OR/Ms9xTqS6Wl5VbF1HqNYH1GJyjqDaWJvhd2KbpH4GQ6oNFImf2/gZV0FSSM0fEXLKmQKn2NM+JsuM6FiM1rM3TIokEqQJdoKVDBmLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctniOjC5; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctniOjC5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785843070; x=1817379070;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5RnmrpWOMDV86PTzf5eDaOGgp0G0DtsVia13f/Ss7q4=;
  b=ctniOjC5ZEAWCFZWprJRNil5sF+WshFVq4ikdj504UP0d7pzWEo9fweV
   6RDNbOx06d9ufehWd5ngQKpvaWh4V6lcttpnyVQqKq0zRDfl2R5/7xjuU
   AzGQ/F/ifa/psWdA+EVRM+zKJVN7Xu8nkjzieeHxK3gjk+VulO7bFQx5G
   x1Hqwr4rr1+6rD6nGbZhKDP5x5jQiltrZqRPQ44UpPw2BvP4vzZUMMYcV
   mod35T4EY/EVPVNc/5Du5LWLUr7M0y1LrFTUqfyKHG2cz1Q5zMTidTb0x
   CajS517/M4ChOAPjyEVdpenn7NLjXkvr1vBp0KNPjbsiZfVZEBqVaczm7
   w==;
X-CSE-ConnectionGUID: c/wsYDyiR9q2IYinL6alNw==
X-CSE-MsgGUID: cQuTRRnzQGCN29/JD8UQQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86244241"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86244241"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:07 -0700
X-CSE-ConnectionGUID: DUTxa6/lRKO+eoBhyc0o9Q==
X-CSE-MsgGUID: 7HJ9DfupSzuPOgYN5nmEhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265323103"
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
Subject: [PATCH v1 3/8] x86/virt/tdx: Add a table-driven TDX global metadata reader
Date: Tue,  4 Aug 2026 04:29:31 -0700
Message-ID: <20260804112941.19894-4-chao.gao@intel.com>
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

The auto-generated tdx_global_metadata.c populates each member of
'struct tdx_sys_info' with a chain like

	if (!ret && !(ret = read_sys_metadata_field(0x..., &val)))
		sysinfo_xxx->member = val;

repeated once per field, with a bare hex literal for the field ID and an
implicit narrowing assignment.  Reading it requires the JSON file, and
reviewing any change to it requires the out-of-tree script.

Replace it with a small table-driven reader. Each table entry pairs
a named MD_FIELD_ID_* with the C member that holds its value:

	#define MAP_FEATURES(_field_id, _member)	\
		TD_SYSINFO_MAP(_field_id, tdx_sys_info_features, _member)

	static const struct tdx_sys_field features_fields[] __initconst = {
		MAP_FEATURES(TDX_FEATURES0,	tdx_features0),
	};

TD_SYSINFO_MAP() derives the destination offset and width from the
struct via offsetof()/sizeof_field().

Add read_sys_metadata_table() to walk such a table, reading each field
and populating the C struct.

Three things fall out of this table-driven reader, all of which matter now
that the code is hand-maintained rather than auto-generated:

  - The field-to-member pairing becomes data rather than code embedded
    in control flow.
  - The read logic exists once instead of once per field.
  - The width is recorded explicitly instead of being implied by a
    narrowing assignment.

Convert the 'features' class only, as an example. The remaining classes
follow in later patches.

Assisted-by: Claude:claude-opus-5
Not-yet-signed-off-by: Dave Hansen <dave@sr71.net>
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c                 | 60 +++++++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx_global_metadata.c | 11 ----
 2 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 42df8ea464c4..fb21433e7851 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -347,6 +347,66 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
 	return 0;
 }
 
+/*
+ * Mapping between a TDX global metadata field and the C member that
+ * holds its value. Use TD_SYSINFO_MAP() to populate entries.
+ */
+struct tdx_sys_field {
+	u64 field_id;
+	u16 offset;
+	u8  size;
+};
+
+#define TD_SYSINFO_MAP(_field_id, _struct, _member)				\
+	{									\
+		.field_id = MD_FIELD_ID_##_field_id,				\
+		.offset   = offsetof(struct _struct, _member),			\
+		.size     = sizeof_field(struct _struct, _member),		\
+	}
+
+/*
+ * Walk a table of TDX global metadata fields, read each via TDH.SYS.RD,
+ * and store the result into the matching C member of *@base.
+ */
+static int read_sys_metadata_table(const struct tdx_sys_field *fields,
+				   int nr_fields, void *base)
+{
+	int i, ret;
+	u64 val;
+
+	for (i = 0; i < nr_fields; i++) {
+		const struct tdx_sys_field *f = &fields[i];
+
+		ret = read_sys_metadata_field(f->field_id, &val);
+		if (ret)
+			return ret;
+
+		switch (f->size) {
+		case 1: *(u8  *)(base + f->offset) = val; break;
+		case 2: *(u16 *)(base + f->offset) = val; break;
+		case 4: *(u32 *)(base + f->offset) = val; break;
+		case 8: *(u64 *)(base + f->offset) = val; break;
+		default:
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+#define MAP_FEATURES(_field_id, _member)	\
+	TD_SYSINFO_MAP(_field_id, tdx_sys_info_features, _member)
+
+static const struct tdx_sys_field features_fields[] __initconst = {
+	MAP_FEATURES(TDX_FEATURES0,	tdx_features0),
+};
+
+static __init int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinfo_features)
+{
+	return read_sys_metadata_table(features_fields,
+				       ARRAY_SIZE(features_fields),
+				       sysinfo_features);
+}
+
 #include "tdx_global_metadata.c"
 
 static __init int check_features(struct tdx_sys_info *sysinfo)
diff --git a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
index e49c300f23d4..e69c655a91a0 100644
--- a/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
+++ b/arch/x86/virt/vmx/tdx/tdx_global_metadata.c
@@ -22,17 +22,6 @@ static int get_tdx_sys_info_version(struct tdx_sys_info_version *sysinfo_version
 	return ret;
 }
 
-static __init int get_tdx_sys_info_features(struct tdx_sys_info_features *sysinfo_features)
-{
-	int ret = 0;
-	u64 val;
-
-	if (!ret && !(ret = read_sys_metadata_field(0x0A00000300000008, &val)))
-		sysinfo_features->tdx_features0 = val;
-
-	return ret;
-}
-
 static __init int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
 	int ret = 0;
-- 
2.52.0

