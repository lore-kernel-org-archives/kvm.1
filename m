Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9517847ECCC;
	Wed, 13 May 2026 15:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685105; cv=none; b=El1Gi12467OLF7fQ2xeV4aVoIPOCA+UFnzpkozQq3qwZfoddOPHCwkSDVNh+f6O1X+7ano4wcLeJDz+lF7CkZv9Tc5DQgnO/e+3z0Mu+zYhiNEY6v0Gn15tAsgK+2J01EcwiGudFpFZGtCJ7jxkXPRe1Vq1Num5eIfxEBGQWyj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685105; c=relaxed/simple;
	bh=7Whkh85mgm7G+NVn7IKbBq2HfUjBXzTeUUdbwVvkMGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZdiwLlBvfLGFCcoeNcZnjgNWZhdrno5+ujvIoH0+uqYI8QU9NJA2gHjEADynf4QXgKhykS1zMH2ofNk2HnVkGe8dM834WuLrqAKJbvaMMh2Aa7iE4rrMShUR/7gfgNyAj+x2xY+9WF1LWPEgeomxnj0F1w4OV/76UIlc1tW9OP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGZ7LWJo; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGZ7LWJo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778685103; x=1810221103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Whkh85mgm7G+NVn7IKbBq2HfUjBXzTeUUdbwVvkMGc=;
  b=WGZ7LWJoUhPysIfJagqHNPJwexGINFKe34DFPVlh5Ei2S/9ZfmoHFgxC
   LaNE85oq1uNCZK1Ncxo7tHNQBwDAynh0aDfG51jmZ1jtJqaA5kI/zm+bs
   VFwp2gQ89vi2iqrKXvNjsuJVtLVstg4vvMUh+EYozwYq8Ddl6477b0MmX
   U0jp4fBb+kM0X5qrDLnLyYnzq+KotLoRRcHqE1fHxodkb1410Whc+VBa7
   ZSf2N8KYJrjrVIf5RQvutiozZm/9Dq5PQbDnI//afseAsTNk7u1+6Lpei
   5Z41XN8ymyTWaVMGsxSFfrhAPAPZwMvyRKR6+Hh7HAReV2nkAXWaLsQNY
   w==;
X-CSE-ConnectionGUID: 8mtT0hapSEW0NG++nMiZcQ==
X-CSE-MsgGUID: fTBiSbxnT+mtimmePse1UA==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="89921640"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89921640"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:43 -0700
X-CSE-ConnectionGUID: NAtZAUrcQMaLefEkJZvRkw==
X-CSE-MsgGUID: r9fafdh6QDatDdGP7weP8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="231716788"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 08:11:43 -0700
From: Chao Gao <chao.gao@intel.com>
To: kvm@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
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
	"H. Peter Anvin" <hpa@zytor.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v9 06/23] x86/virt/seamldr: Introduce a wrapper for P-SEAMLDR SEAMCALLs
Date: Wed, 13 May 2026 08:09:49 -0700
Message-ID: <20260513151045.1420990-7-chao.gao@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260513151045.1420990-1-chao.gao@intel.com>
References: <20260513151045.1420990-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Link: https://cdrdv2.intel.com/v1/dl/getContent/733582 # [1]
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
2.52.0

