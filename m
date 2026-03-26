Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C84C377556;
	Thu, 26 Mar 2026 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514735; cv=none; b=bexppLCfsGf9cRKTlFJIIM4hIGznJuMSs4RoVJwk5XZpXe2q3Oo3nFyj7eYXw2hNUIRrWoU5IO6AxsvpatIzbCXGsbM5hCzjt+yeLa/NmLBkJ6rSj2DVEyjliwLYpyy4aL8vqHbgAVtKpuUuzl1SGy3Wu0UJzb4I3wcD3Ei3OXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514735; c=relaxed/simple;
	bh=01TmAcNXHQDtZ/pnCiN5RVmZGz2dkn5ConRYFY/hVEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ad2tcKRI3UFyaPdtgZxRIljvLG7bMi5V3w1tg4G38KQHJNZULPozEiap52DlRV2Q19aO3xawtT6nYM9L5HWi3EsDw8i5uGuLT9NV/tBzPqbfS5wzrADq7U8Lhoei6Rjt0BC449NQN8HC8AchC5e2oPlJuqMfWR24+JbpNUw88s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WloeetFa; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WloeetFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514734; x=1806050734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=01TmAcNXHQDtZ/pnCiN5RVmZGz2dkn5ConRYFY/hVEE=;
  b=WloeetFagxaAWQu60fWzou1DOzl+7AkjzU6dBXwI2So9M8YcGqwX60bX
   OwTCAUza23x+NTKHd23W7NSaR8HZ9DPKdJnnssxGe/9CCGR2k2J/zFCg8
   53fus+oHBoOtmUrSzDoEYram7qTleuU9VPuyAil298cBx1nGpO0Y/WL69
   oTnRao9SAx8HC7N9mAA9OYUNdn+Hi3vl5TsOQqEsZbPBIdc+b1OxyGq+B
   GEaIsh+1HtHMUOTj9QjrFGBPDGMB8ci4JzcJIv1M6XnV74tyzrKM9/s2S
   cajV+xyxEwQzLmx/yRDFoDa0bqJq4vf4L9WAhMExUyworstlhuO+ABE7i
   g==;
X-CSE-ConnectionGUID: Cmxa4jZaQKKnry+puvXxWQ==
X-CSE-MsgGUID: RfTyX9ZYRdWaUIJx+eHaNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644628"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644628"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:20 -0700
X-CSE-ConnectionGUID: QqigY9A/TSy/kL1Nb2Vpdg==
X-CSE-MsgGUID: e1hGNZ8sS3K26rFkvG+83A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967126"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:17 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
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
	"H. Peter Anvin" <hpa@zytor.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v6 04/22] x86/virt/seamldr: Introduce a wrapper for P-SEAMLDR SEAMCALLs
Date: Thu, 26 Mar 2026 01:43:55 -0700
Message-ID: <20260326084448.29947-5-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326084448.29947-1-chao.gao@intel.com>
References: <20260326084448.29947-1-chao.gao@intel.com>
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

Use seamcall_prerr() (not '_ret') because current P-SEAMLDR calls do not
use any output registers other than RAX.

Note that unlike P-SEAMLDR, there is also a non-persistent SEAM loader
("NP-SEAMLDR"). This is an authenticated code module (ACM) that is not
callable at runtime. Only BIOS launches it to load P-SEAMLDR at boot;
the kernel does not need to interact with it for runtime update.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Link: https://cdrdv2.intel.com/v1/dl/getContent/733582 # [1]
---
v6:
 - Don't refer to Intel® Trust Domain CPU Architectural Extensions
   [Xiaoyao]
 - clarify the usage of seamcall_prerr() [Xiaoyao]
 - Improve the explanation for raw_spinlock [Kiryl]

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
 arch/x86/virt/vmx/tdx/seamldr.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 1 deletion(-)
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
index 000000000000..65616dd2f4d2
--- /dev/null
+++ b/arch/x86/virt/vmx/tdx/seamldr.c
@@ -0,0 +1,25 @@
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
+ * be made with interrupts disabled, where plain spinlocks are prohibited in
+ * PREEMPT_RT kernels as they become sleeping locks.
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

