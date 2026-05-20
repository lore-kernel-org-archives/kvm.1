Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAD39B94C;
	Wed, 20 May 2026 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284420; cv=none; b=UAbhYIJVoz7n0IGu4/s2vxzQrsdn442ttqEtf/H9U5aIavIsCVgHmvwfLVVJh/PtTmF8okAvVj3EnEwvLHzPFEQLxMTBxIx1PadmV243O+DQBzrLLY66dctbx9c5n9ZwhnJbi3ut4OQHxFT0xE9Gic/6A3sW6MtQkaxOIcUsxlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284420; c=relaxed/simple;
	bh=Otjxhkr5ExaAgS9xigLSzxVdyYwj4abmozFtPQYLOd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jB6EUpL9ZgyD8kE8ipSdR//JEZWdDSK+AM5yIDpl45hJZRb90jDB0uOCjH0/nHeqLjTnURvFTX0grOoKRNkb8HAfo60s6iu+rtQ23SYilw2UhZqMLQ7Z1zVZRizrgVw4zAFRJTqavIfkjyVjA9kEHY7JPRNEL50QxeUkSK9x8Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gdJaxJmc; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gdJaxJmc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284418; x=1810820418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Otjxhkr5ExaAgS9xigLSzxVdyYwj4abmozFtPQYLOd0=;
  b=gdJaxJmcPEhm2dIMbzOSLPmB6W4c07sfZTCrmheaMT6PhxRETvBwKHdk
   R9JNuh43cszpPM7iNHPvWc4dSQbcfJdV9BotLFf8D0+2FBvCJaBYJCGee
   NHS5V37VKz29BCOB25Jg0BvNHoP0UzcohRPfAZdXa+6G1Sieb/GQD2uV2
   cyhmuWHrTbHZViCkxrIZHLDdH/c1fjrg3Jxp6l7P6CVCu2hkYRPvgCmgM
   y9w1UnNPfNnzNG85KAb7FVaKTF5rZSrqJyYn2ihqYkxIGU1qUN1+TXI1q
   6xGiWiPYPhqDpjoCOWE6fAgYGWC2q2/QWaGn16CTyPPPaC8Z5HjkCGYuY
   w==;
X-CSE-ConnectionGUID: dCQiXu0ESlGH5ONbIRu7Tw==
X-CSE-MsgGUID: R+5jtgkVRqSjuj7XnVuYtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146471"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146471"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:12 -0700
X-CSE-ConnectionGUID: NXf43sx1RnW0ofeSR4hOOw==
X-CSE-MsgGUID: URyZ0Z7bQ0WlxGaRpOzamQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923811"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:11 -0700
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
Subject: [PATCH v10 09/25] x86/virt/seamldr: Add a helper to retrieve P-SEAMLDR information
Date: Wed, 20 May 2026 06:38:12 -0700
Message-ID: <20260520133909.409394-10-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260520133909.409394-1-chao.gao@intel.com>
References: <20260520133909.409394-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

P-SEAMLDR reports its state via SEAMLDR.INFO, including its version and
the number of remaining runtime updates.

This information is useful for userspace. For example, the admin can use
the P-SEAMLDR version to determine whether a candidate TDX module is
compatible with the running loader, and can use the remaining update count
to determine whether another runtime update is still possible.

Add a helper to retrieve P-SEAMLDR information in preparation for
exposing P-SEAMLDR version and other necessary information to userspace.
Export the new kAPI for use by the "tdx_host" device.

Note that there are two distinct P-SEAMLDR APIs with similar names:

  "SEAMLDR.INFO" is metadata about the loader. It's metadata for the
  update process.

  "SEAMLDR.SEAMINFO" is metadata about SEAM mode. It is for the module
  init process, not for the update process.

Use SEAMLDR.INFO here.

For details, see "Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
Interface Specification".

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v10:
 - Shorten the comment above the SEAMLDR_INFO structure [Dave]
 - Use tdx_host consistently when referring to the device [Dave]
 - Shorten the changelog description about SEAMLDR.{INFO,SEAMINFO} [Dave]
---
 arch/x86/include/asm/seamldr.h  | 35 +++++++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/seamldr.c | 20 ++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/seamldr.h

diff --git a/arch/x86/include/asm/seamldr.h b/arch/x86/include/asm/seamldr.h
new file mode 100644
index 000000000000..a74151b75599
--- /dev/null
+++ b/arch/x86/include/asm/seamldr.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SEAMLDR_H
+#define _ASM_X86_SEAMLDR_H
+
+#include <linux/types.h>
+
+/*
+ * This is the "SEAMLDR_INFO" data structure defined in the
+ * "SEAM Loader (SEAMLDR) Interface Specification".
+ *
+ * Must be aligned to a 256-byte boundary.
+ */
+struct seamldr_info {
+	u32	version;
+	u32	attributes;
+	u32	vendor_id;
+	u32	build_date;
+	u16	build_num;
+	u16	minor_version;
+	u16	major_version;
+	u16	update_version;
+	u32	acm_x2apicid;
+	u32	num_remaining_updates;
+	u8	seam_info[128];
+	u8	seam_ready;
+	u8	seam_debug;
+	u8	p_seam_ready;
+	u8	reserved[93];
+} __packed __aligned(256);
+
+static_assert(sizeof(struct seamldr_info) == 256);
+
+int seamldr_get_info(struct seamldr_info *seamldr_info);
+
+#endif /* _ASM_X86_SEAMLDR_H */
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
index 65616dd2f4d2..7269a239bc22 100644
--- a/arch/x86/virt/vmx/tdx/seamldr.c
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -8,8 +8,13 @@
 
 #include <linux/spinlock.h>
 
+#include <asm/seamldr.h>
+
 #include "seamcall_internal.h"
 
+/* P-SEAMLDR SEAMCALL leaf function */
+#define P_SEAMLDR_INFO			0x8000000000000000
+
 /*
  * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
  * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
@@ -18,8 +23,21 @@
  */
 static DEFINE_RAW_SPINLOCK(seamldr_lock);
 
-static __maybe_unused int seamldr_call(u64 fn, struct tdx_module_args *args)
+static int seamldr_call(u64 fn, struct tdx_module_args *args)
 {
 	guard(raw_spinlock)(&seamldr_lock);
 	return seamcall_prerr(fn, args);
 }
+
+int seamldr_get_info(struct seamldr_info *seamldr_info)
+{
+	struct tdx_module_args args = {};
+
+	/*
+	 * Use slow_virt_to_phys() since @seamldr_info may be allocated on
+	 * the stack.
+	 */
+	args.rcx = slow_virt_to_phys(seamldr_info);
+	return seamldr_call(P_SEAMLDR_INFO, &args);
+}
+EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
-- 
2.52.0

