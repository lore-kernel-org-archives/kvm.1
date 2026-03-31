Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3913E3D88;
	Tue, 31 Mar 2026 12:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961011; cv=none; b=tPxWmU7hvW/7pOEc29e8hYqY///DY3nIC6uqvMSIoS/IKRkhbvjFN9axayjiyLNZK8ytk5SHwAXh3Nx8zOuVNt0tsHKS9jYTzje3T+DmyPuhWNRot1Pqia5Tf+l+TdX4rL3eXf1xYk8q3c9uIx3MaviLmEO84UXJFdyo10OGkXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961011; c=relaxed/simple;
	bh=/9S/xSkaBRBbh7/4dBvAcB/eEWGXx4+Jb9A94w5k71g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+McItjfVDualgVy2v7Cs1BtZ5h2iOa56r6joKrQLhWKqG9hBGn6ShzkqcXdrJjrmoYlDCdcuQ09dNSk+Yhn/AVbw5oihjPR0reQMs0Hp+mp/tuOjnKt3u49fBmJ1EtaXXWPxsVs2rjGgpWlx2B+78/5HOkvhAutXjgXSdqMEmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EpTQf2Xq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EpTQf2Xq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961009; x=1806497009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/9S/xSkaBRBbh7/4dBvAcB/eEWGXx4+Jb9A94w5k71g=;
  b=EpTQf2XqdIhrKb1KFQVAr/fZV6FPu7o7t+VuW98NdNvmZNsjjH/hyolt
   Uk0/tFwSv3OSG7Mj3leygXe8YlogtFw9bi8Ni/NekeUWYi9tMBHbZX9zN
   YIe1FFx9LBTjCcmja8JK0+7L6QZQljtbjm31ALVDfiG6TXzpnzz1wiHLC
   JB/3UpXD366YeiGxXaZIdUnMvtjU2nGWRzIl2EGhYisesO+n7h/d7XnFj
   rB100sRjury2sg1adrotCCnnK5ZogsOjbPZGypxVt8LRJtxhwxtUuyspO
   V9h3K1RkNP8cjJmw8oPTfR/ipYCnGENNEGUom5JRkscDq9osKJsel6YHp
   Q==;
X-CSE-ConnectionGUID: S0T2lydiQqSNBqvwvHixLQ==
X-CSE-MsgGUID: J32UGkcsRpahy7v/bh/RYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76084461"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76084461"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:23 -0700
X-CSE-ConnectionGUID: yn6Z8FXvQ4CDvLnGjUSFEw==
X-CSE-MsgGUID: KiDsNQFIT+OpN2kq5am93g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221492101"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:23 -0700
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
Subject: [PATCH v7 05/22] x86/virt/seamldr: Add a helper to retrieve P-SEAMLDR information
Date: Tue, 31 Mar 2026 05:41:18 -0700
Message-ID: <20260331124214.117808-6-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331124214.117808-1-chao.gao@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

P-SEAMLDR returns its information such as version number, in response to
the SEAMLDR.INFO SEAMCALL.

This information is useful for userspace. For example, the admin can decide
which TDX module versions are compatible with the P-SEAMLDR according to
the P-SEAMLDR version.

Add a helper to retrieve P-SEAMLDR information in preparation for
exposing P-SEAMLDR version and other necessary information to userspace.
Export the new kAPI for use by tdx-host.ko.

Note that there are two distinct P-SEAMLDR APIs with similar names:

  SEAMLDR.INFO: Returns a SEAMLDR_INFO structure containing SEAMLDR
                information such as version and remaining updates.

  SEAMLDR.SEAMINFO: Returns a SEAMLDR_SEAMINFO structure containing SEAM
                    and system information such as Convertible Memory
		    Regions (CMRs) and number of CPUs and sockets.

The former is used here.

For details, see "Intel® Trust Domain Extensions - SEAM Loader (SEAMLDR)
Interface Specification".

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
v6:
 - Clarify that this patch introduces a helper for retrieving info, not
   the retrieval itself [Xiaoyao]
v5:
 - add a comment for slow_virt_to_phys() [Kai]
v4:
 - put seamldr_info on stack [Dave]
 - improve changelogs to explain SEAMLDR.INFO and SEAMLDR.SEAMINFO [Dave]
 - add P-SEAMLDR spec information in the changelog [Dave]
 - add proper comments above ABI structure definition [Dave]
 - add unused ABI structure fields rather than marking them as reserved
   to better align with the specc [Dave] (I omitted "not used by kernel"
   tags since there are 5-6 such fields and maintaining these tags would
   be tedious.)
---
 arch/x86/include/asm/seamldr.h  | 36 +++++++++++++++++++++++++++++++++
 arch/x86/virt/vmx/tdx/seamldr.c | 19 ++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/seamldr.h

diff --git a/arch/x86/include/asm/seamldr.h b/arch/x86/include/asm/seamldr.h
new file mode 100644
index 000000000000..c67e5bc910a9
--- /dev/null
+++ b/arch/x86/include/asm/seamldr.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_SEAMLDR_H
+#define _ASM_X86_SEAMLDR_H
+
+#include <linux/types.h>
+
+/*
+ * This is called the "SEAMLDR_INFO" data structure and is defined
+ * in "SEAM Loader (SEAMLDR) Interface Specification".
+ *
+ * The SEAMLDR.INFO documentation requires this to be aligned to a
+ * 256-byte boundary.
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
index 65616dd2f4d2..8410df3a0bf4 100644
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
@@ -18,8 +23,20 @@
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
+	/*
+	 * Use slow_virt_to_phys() since @seamldr_info may be allocated on
+	 * the stack.
+	 */
+	struct tdx_module_args args = { .rcx = slow_virt_to_phys(seamldr_info) };
+
+	return seamldr_call(P_SEAMLDR_INFO, &args);
+}
+EXPORT_SYMBOL_FOR_MODULES(seamldr_get_info, "tdx-host");
-- 
2.47.3

