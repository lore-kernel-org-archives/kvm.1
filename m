Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E6F3F20E8;
	Tue, 31 Mar 2026 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774961021; cv=none; b=HG/LUkfBkCPnUdXxoZ7ud9Oa0A0vwYw2aWCQmN58e/WX1aW9CBlihLSwQMHErFWVsvcVkA/i3Bpfwiq8uR1wves9K7wTrBaO4LX+1zjQ3lcGDvR6I3QAdlPkPVQyW8nMdJNd/wSix6dAD4tmFR7LhwiPQ2RLNtFIX51PDPRfd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774961021; c=relaxed/simple;
	bh=PDXYLSn6cSRJ7B1g7bny8FDi/2GIUbz3A/T7eX7X24U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jw054KSOHNvFScwHoS1Tua04WXZeX3DWqU++dvOnmNurSdIfsy3iDTzXaFxk49kD1PIArd4nf089twN+bvpt4mhSRUHI+6j/R2QsHxj/1zoEnOOBzm8oO1tab9XXWmTgXTMJpoYhisACjjOCIqUio5Yae7yd1voLEu/Wz+Hzc6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TPg+JaOM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TPg+JaOM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774961020; x=1806497020;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PDXYLSn6cSRJ7B1g7bny8FDi/2GIUbz3A/T7eX7X24U=;
  b=TPg+JaOMu1wkqpr39SI1uP9tunbUfqFRIJHsmP1bT8oFEUEQmki81uIl
   8yB9K6XfNZCNKUfOd68LZiQNMoFkH+jbi5+F5ozMzP10a/d/OMgFAKTNg
   vAMxFQW+7J3zTlxSh6K3O81VGxsCwbhbDxJPy61i+y68KqRJd6l71Pj1d
   lDkiJH02I4gqi+G9p2A/CbHrdbx6NvB+jew/xndfIfdHQSyEWFL3oFq22
   cvX7FZYi6B7thb8gTBG27M5Dyd70xE4ojGyOjD+NscaZ4nz30dfQbauZB
   pb0FsDf2L+U/x0JUYcZug2RCiJ3QtFJWgRjqnHTcYDOMnvT4ukRsoKMzt
   A==;
X-CSE-ConnectionGUID: Ge1GknBqSeawdASzjQNIWg==
X-CSE-MsgGUID: mkwEnL+YSuiYnU40wtQHyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11745"; a="76084572"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="76084572"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:40 -0700
X-CSE-ConnectionGUID: BTI5DQtpTm6wp3o7Wdwrlg==
X-CSE-MsgGUID: imZiDc4iSDiWo9DYPbGdXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; 
   d="scan'208";a="221492219"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2026 05:43:39 -0700
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
Subject: [PATCH v7 17/22] x86/virt/tdx: Avoid updates during update-sensitive operations
Date: Tue, 31 Mar 2026 05:41:30 -0700
Message-ID: <20260331124214.117808-18-chao.gao@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331124214.117808-1-chao.gao@intel.com>
References: <20260331124214.117808-1-chao.gao@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A runtime TDX module update can conflict with TD lifecycle operations that
are update-sensitive.

Today, update-sensitive operations include:

- TD build: TD measurement is accumulated across multiple
  TDH.MEM.PAGE.ADD, TDH.MR.EXTEND, and TDH.MR.FINALIZE calls.

- TD migration: intermediate crypto state is saved/restored across
  interrupted/resumed TDH.EXPORT.STATE.* and TDH.IMPORT.STATE.* flows.

If an update races TD build, for example, TD measurement can become
incorrect and attestation can fail.

The TDX architecture exposes two approaches:

1) Avoid updates during update-sensitive operations.
2) Detect incompatibility after update and recover.

Post-update detection (option #2) is not a good fit: as discussed in [1],
future module behavior may expand update-sensitive operations in ways that
make KVM ABIs unstable and will break userspace.

"Do nothing" is also not preferred: while it keeps kernel code simple, it
lets the issue leak into the broader stack, where both detection and
recovery require significantly more effort.

So, use option #1. Specifically, request "avoid update-sensitive" behavior
during TDX module shutdown and map the resulting failure to -EBUSY so
userspace can distinguish an update race from other failures.

When the "avoid update-sensitive" feature isn't supported, proceed with
updates. If a race occurs between module update and update-sensitive
operations, failures happen at a later stage (e.g., incorrect TD
measurements in attestation reports for TD build). Effectively, this
means "let userspace update at their own risk". Userspace can check if
the feature is supported or not. The alternative of blocking updates
entirely is rejected [2] as it introduces permanent kernel complexity to
accommodate limitations in early TDX module releases that userspace can
handle.

Note: this implementation is based on a reference patch by Vishal [3].
Note2: moving "NO_RBP_MOD" is just to centralize bit definitions.

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Link: https://lore.kernel.org/linux-coco/aQIbM5m09G0FYTzE@google.com/ # [1]
Link: https://lore.kernel.org/kvm/699fe97dc212f_2f4a100b@dwillia2-mobl4.notmuch/ # [2]
Link: https://lore.kernel.org/linux-coco/CAGtprH_oR44Vx9Z0cfxvq5-QbyLmy_+Gn3tWm3wzHPmC1nC0eg@mail.gmail.com/ # [3]
---
v7:
 - add error logging otherwise it is dropped when we switch from
   seamcall_prerr() to seamcall().

v6:
 - Revise the changelog to clarify behavior when "avoid
   update-sensitive" isn't supported.
 - Drop unnecessary wrapper for feature capability check
---
 arch/x86/include/asm/tdx.h   | 11 +++++++++--
 arch/x86/kvm/vmx/tdx_errno.h |  2 --
 arch/x86/virt/vmx/tdx/tdx.c  | 25 +++++++++++++++++++++----
 arch/x86/virt/vmx/tdx/tdx.h  |  3 ---
 4 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 79733fdb35c6..00751506dd3c 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -26,11 +26,18 @@
 #define TDX_SEAMCALL_GP			(TDX_SW_ERROR | X86_TRAP_GP)
 #define TDX_SEAMCALL_UD			(TDX_SW_ERROR | X86_TRAP_UD)
 
+#define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
+
 /*
  * TDX module SEAMCALL leaf function error codes
  */
-#define TDX_SUCCESS		0ULL
-#define TDX_RND_NO_ENTROPY	0x8000020300000000ULL
+#define TDX_SUCCESS			0ULL
+#define TDX_RND_NO_ENTROPY		0x8000020300000000ULL
+#define TDX_UPDATE_COMPAT_SENSITIVE	0x8000051200000000ULL
+
+/* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_NO_RBP_MOD	BIT_ULL(18)
+#define TDX_FEATURES0_UPDATE_COMPAT	BIT_ULL(47)
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/x86/kvm/vmx/tdx_errno.h b/arch/x86/kvm/vmx/tdx_errno.h
index 6ff4672c4181..215c00d76a94 100644
--- a/arch/x86/kvm/vmx/tdx_errno.h
+++ b/arch/x86/kvm/vmx/tdx_errno.h
@@ -4,8 +4,6 @@
 #ifndef __KVM_X86_TDX_ERRNO_H
 #define __KVM_X86_TDX_ERRNO_H
 
-#define TDX_SEAMCALL_STATUS_MASK		0xFFFFFFFF00000000ULL
-
 /*
  * TDX SEAMCALL Status Codes (returned in RAX)
  */
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 08d9f4cb32f9..d144860e17c2 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -1176,10 +1176,13 @@ int tdx_enable(void)
 }
 EXPORT_SYMBOL_FOR_KVM(tdx_enable);
 
+#define TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE BIT(16)
+
 int tdx_module_shutdown(void)
 {
 	struct tdx_module_args args = {};
-	int ret, cpu;
+	u64 ret;
+	int cpu;
 
 	/*
 	 * Shut down the TDX module and prepare handoff data for the next
@@ -1189,9 +1192,23 @@ int tdx_module_shutdown(void)
 	 * modules as new modules likely have higher handoff version.
 	 */
 	args.rcx = tdx_sysinfo.handoff.module_hv;
-	ret = seamcall_prerr(TDH_SYS_SHUTDOWN, &args);
-	if (ret)
-		return ret;
+
+	if (tdx_sysinfo.features.tdx_features0 & TDX_FEATURES0_UPDATE_COMPAT)
+		args.rcx |= TDX_SYS_SHUTDOWN_AVOID_COMPAT_SENSITIVE;
+
+	ret = seamcall(TDH_SYS_SHUTDOWN, &args);
+
+	/*
+	 * Return -EBUSY to signal that there is one or more ongoing flows
+	 * which may not be compatible with an updated TDX module, so that
+	 * userspace can retry on this error.
+	 */
+	if ((ret & TDX_SEAMCALL_STATUS_MASK) == TDX_UPDATE_COMPAT_SENSITIVE)
+		return -EBUSY;
+	if (ret) {
+		seamcall_err(TDH_SYS_SHUTDOWN, ret, &args);
+		return -EIO;
+	}
 
 	/*
 	 * Mark the module is unavailable (in ERROR status) to prevent
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index f8686247c660..2435f88c6994 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -88,9 +88,6 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
-/* Bit definitions of TDX_FEATURES0 metadata field */
-#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
-
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
-- 
2.47.3

