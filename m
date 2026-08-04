Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC6369D51;
	Tue,  4 Aug 2026 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843076; cv=none; b=boO/WqrkK0fmvIDYD29TLOhJ8OW5fgKq65dWFRQnc3t35gih2Z5XE1EDG5CQRX2iFwW9KxbIoxbx4OOrT0MRTtsiJR8Ou7/xr/p2YbLs3ipQkUPQJOmuH7njO8LBOj+WRMFbbFREvTsl72dy2GFbRo5I8VHEgfvgm29YEXUkOXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843076; c=relaxed/simple;
	bh=Pi5qbVX2SOI5SdGfiFCW/36EzzapHXmkthYgHMyLdi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VyfrngkiMwNHlfEkFEV1DUSjOz89Y1Lq6cFkvCiGLFelqmPqwtXRXpdKoyOLLRB+35DkLnsnQywEYFtJyNICPLVbwBFlJvt/IyVnJLelZ/Wj/sMfRWbsEnYpagOBRX6uO6FoMX2DnI4PCmikLjAxJjIj4dTYWteg0ftqt5RY/U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jA8GFWk0; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jA8GFWk0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785843074; x=1817379074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Pi5qbVX2SOI5SdGfiFCW/36EzzapHXmkthYgHMyLdi8=;
  b=jA8GFWk0avpIlAXgTZJLhi5Vei+5Teo1ViMBOvGysmvs8rmnwtrXzt1z
   6vSZbLZ7aEshYtfGFuo2E3wlpKocB5E+lT+sVhjxDJ+QU3iXFc8iGlOd1
   cPdtWuaJzV+/Pm8nCIwchlGyYVuCAXyA9Z2W47sU8pGKyfnigCmxKUCLH
   s91Cec8rgfEsoE+N342PaG9updO/BMfQf6adsefhL5wgXgMT396LVdXW0
   0i5e3vGuHs0t5RrqLIzL2W60ZONQCu2qML2sd/c9KISSK+ufRycT6FNcJ
   7YZAHRjATdXIf/85vXP7eR/rS0aNHZPQtBrSugmUxeWPvaOCPewmJOxIW
   g==;
X-CSE-ConnectionGUID: ogDKrAfRTdqaoKVhxnnqDg==
X-CSE-MsgGUID: 5WHWkjspRD6EwIzfK4QW6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86244257"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="86244257"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:09 -0700
X-CSE-ConnectionGUID: 78mmNRjcQwWp/IN+2fEMVA==
X-CSE-MsgGUID: tSqKD+oUSMCGaCKujPcEAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265323118"
Received: from jf.jf.intel.com (HELO 984fee019967.jf.intel.com) ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:31:09 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org
Cc: rick.p.edgecombe@intel.com,
	kas@kernel.org,
	dave.hansen@linux.intel.com,
	chao.gao@intel.com
Subject: [PATCH v1 8/8] x86/virt/tdx: Verify the C member size against the metadata field ID
Date: Tue,  4 Aug 2026 04:29:36 -0700
Message-ID: <20260804112941.19894-9-chao.gao@intel.com>
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

Each TDX global metadata field ID encodes the size of that field.
read_sys_metadata_table() stores each value at the width recorded in
the table, which TD_SYSINFO_MAP() derives from the destination C member.
Nothing checks that the two agree.

A table entry naming the wrong field ID, or a struct member declared at
the wrong width, would silently truncate the value read from the TDX
module. That is a kernel-side bug rather than a TDX module problem.

Add macros to extract the encoded size from a field ID, and use them in
TD_SYSINFO_MAP() to assert that it matches the member size.  Both are
compile-time constants, so the check costs nothing at runtime.

Note that BUILD_BUG_ON() cannot be used in a structure initializer; use
BUILD_BUG_ON_ZERO() instead, which yields 0 and so can be folded into the
.size initializer without changing its value.

No functional change intended.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Chao Gao <chao.gao@intel.com>
---
 arch/x86/virt/vmx/tdx/tdx.c |  9 ++++++++-
 arch/x86/virt/vmx/tdx/tdx.h | 15 +++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4bf21848df62..59099cc15f7a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -357,11 +357,18 @@ struct tdx_sys_field {
 	u8  size;
 };
 
+/*
+ * The size encoded in the field ID and the size of the destination C
+ * member must agree; BUILD_BUG_ON_ZERO() enforces this at compile time.
+ */
 #define TD_SYSINFO_MAP(_field_id, _struct, _member)				\
 	{									\
 		.field_id = MD_FIELD_ID_##_field_id,				\
 		.offset   = offsetof(struct _struct, _member),			\
-		.size     = sizeof_field(struct _struct, _member),		\
+		.size     = sizeof_field(struct _struct, _member) +		\
+			    BUILD_BUG_ON_ZERO(					\
+				sizeof_field(struct _struct, _member) !=	\
+				MD_FIELD_ID_ELE_SIZE(MD_FIELD_ID_##_field_id)),	\
 	}
 
 /*
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 5f567cb6c07a..c612b1cf7c14 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -109,6 +109,21 @@
 #define MD_FIELD_ID_CPUID_CONFIG_LEAVES		0x9900000300000400ULL
 #define MD_FIELD_ID_CPUID_CONFIG_VALUES		0x9900000300000500ULL
 
+/*
+ * Sub-field definitions of MD_FIELD_ID.
+ *
+ * See "MD_FIELD_ID (Metadata Field Identifier / Sequence Header)
+ * Definition" in the Intel TDX Module ABI spec.
+ *
+ *  - Bit 33:32: ELEMENT_SIZE_CODE -- log2 of a single metadata
+ *                                    element's size in bytes
+ */
+#define MD_FIELD_ID_ELE_SIZE_CODE(field_id)	\
+	(((field_id) & GENMASK_ULL(33, 32)) >> 32)
+
+#define MD_FIELD_ID_ELE_SIZE(field_id)		\
+	(1 << MD_FIELD_ID_ELE_SIZE_CODE(field_id))
+
 /* TDX page types */
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
-- 
2.52.0

