Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480893624B8;
	Sun, 15 Mar 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583179; cv=none; b=TlLZzTixmd7Kbkgk+ob+hf/FVakqVzgijHJvP2uiJXB/60fpIrumLuLwJSihEubZTGMMBstR4GlBhbPNxXkA1Wwvk0EF5mn7QKHfyvVC6fQgagC6z3bNy0Z4pyzMdrDz9rK/3v3cvXZw+mf/sQj5IBOilvKgWLrJDVJL6OwE+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583179; c=relaxed/simple;
	bh=6hG+hEvZmAYuU/lsnMBo0wE9WAvDNVh28lQMkbVWvHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBrbEixljtWfygmt/ru+l/e+QThso8mJpcCbCiOMAgg3NFTsqEt0p7MZZLol2pkuu/1fQNATHAV93KdydTwkHM7t16EaZMa0/u7FBi0SLSh7RLK+fbDvj0QR8JaYEDh9bltg3+FLXw0RctqZdWake83cbhTGxGWlTUo8WbcaQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AlAwzC0U; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AlAwzC0U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773583177; x=1805119177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6hG+hEvZmAYuU/lsnMBo0wE9WAvDNVh28lQMkbVWvHA=;
  b=AlAwzC0Uj5OoMNsLOoPakICl+GgwqGb40ZmbOaeMwG7ouyq3CCVzLfjM
   eyAU34acvFvVUbd2SMxRPI88vooxeyo5HtnkS6UgmiBihFsTjsdneGz5W
   upkKTqKOMlALfSKxiLemVjlJnnXCpYlYvF+R6/jgfSV/OJLl93pygD1Nj
   aiHAXSEHExC5QT6MK/EkGMLA5Y2AhOVcNCI7Ra4wtSVslcS4xuWvnWo3X
   5XfnFIe/ODz+GKNbGWgeAD2LckP+oFwvjnKE+FDchcuPKTZHYV8FtSD2g
   l9dJEzvkXSYEtuknOLOAkSHAOjXQYjDsXNStoHe2WtpHbvCqTEaSGFrkm
   Q==;
X-CSE-ConnectionGUID: cXRribC3RDy7+y8cvcog4w==
X-CSE-MsgGUID: pjl21pYuRv6kvZjth0fCgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74732437"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="74732437"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:37 -0700
X-CSE-ConnectionGUID: 6EjBzwVrRmSP76bp8e8OrQ==
X-CSE-MsgGUID: 7xmVYAALRQ6sWO+8R4YJwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="226123020"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:37 -0700
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
	Chao Gao <chao.gao@intel.com>,
	Farrah Chen <farrah.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 04/22] x86/virt/seamldr: Introduce a wrapper for P-SEAMLDR SEAMCALLs
Date: Sun, 15 Mar 2026 06:58:24 -0700
Message-ID: <20260315135920.354657-5-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260315135920.354657-1-chao.gao@intel.com>
References: <20260315135920.354657-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The TDX architecture uses the "SEAMCALL" instruction to communicate with
SEAM mode software. Right now, the only SEAM mode software that the kernel
communicates with is the TDX module. But, there is actually another
component that runs in SEAM mode but it is separate from the TDX module:
the persistent SEAM loader or "P-SEAMLDR". Right now, the only component
that communicates with it is the BIOS which loads the TDX module itself at
boot. But, to support updating the TDX module, the kernel now needs to be
able to talk to it.

P-SEAMLDR SEAMCALLs differ from TDX module SEAMCALLs in areas such as
concurrency requirements. Add a P-SEAMLDR wrapper to handle these
differences and prepare for implementing concrete functions.

Note that unlike P-SEAMLDR, there is also a non-persistent SEAM loader
("NP-SEAMLDR"). This is an authenticated code module (ACM) that is not
callable at runtime. Only BIOS launches it to load P-SEAMLDR at boot;
the kernel does not need to interact with it for runtime update.

For details of P-SEAMLDR SEAMCALLs, see Intel® Trust Domain CPU
Architectural Extensions, Revision 343754-002, Chapter 2.3 "INSTRUCTION
SET REFERENCE".

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Tested-by: Farrah Chen <farrah.chen@intel.com>
Link: https://cdrdv2.intel.com/v1/dl/getContent/733582 # [1]
---
v5:
 - Don't save/restore irq flags as P-SEAMLDR calls are made only in process
   context
 - clarify why raw_spinlock is used [Dave]
v4:
 - Give more background about P-SEAMLDR in changelog [Dave]
 - Don't handle P-SEAMLDR's "no_entropy" error [Dave]
 - Assume current VMCS is preserved across P-SEAMLDR calls [Dave]
 - I'm not adding Reviewed-by tags as the code has changed significantly.
v2:
 - don't create a new, inferior framework to save/restore VMCS
 - use human-friendly language, just "current VMCS" rather than
   SDM term "current-VMCS pointer"
 - don't mix guard() with goto
---
 arch/x86/virt/vmx/tdx/Makefile  |  2 +-
 arch/x86/virt/vmx/tdx/seamldr.c | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/virt/vmx/tdx/seamldr.c

diff --git a/arch/x86/virt/vmx/tdx/Makefile b/arch/x86/virt/vmx/tdx/Makefile
index 90da47eb85ee..d1dbc5cc5697 100644
--- a/arch/x86/virt/vmx/tdx/Makefile
+++ b/arch/x86/virt/vmx/tdx/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y += seamcall.o tdx.o
+obj-y += seamcall.o seamldr.o tdx.o
diff --git a/arch/x86/virt/vmx/tdx/seamldr.c b/arch/x86/virt/vmx/tdx/seamldr.c
new file mode 100644
index 000000000000..7ed9be89017c
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * P-SEAMLDR support for TDX module management features like runtime updates
+ *
+ * Copyright (C) 2025 Intel Corporation
+ */
+#define pr_fmt(fmt)	"seamldr: " fmt
+
+#include <linux/spinlock.h>
+
+#include "seamcall_internal.h"
+
+/*
+ * Serialize P-SEAMLDR calls since the hardware only allows a single CPU to
+ * interact with P-SEAMLDR simultaneously. Use raw version as the calls can
+ * be made with interrupts disabled.
+ */
+static DEFINE_RAW_SPINLOCK(seamldr_lock);
+
+static __maybe_unused int seamldr_call(u64 fn, struct tdx_module_args *args)
+{
+	guard(raw_spinlock)(&seamldr_lock);
+	return seamcall_prerr(fn, args);
+}
-- 
2.47.3

