Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F623E6DF3;
	Mon, 23 Mar 2026 20:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299573; cv=none; b=HhbUz9o4Ts7BN7UvozlIl2cHg46oMh9QHlYUospgDYDNwsty14/vuGIqrg5lveDkdTweKt7xZu/dsQte5LC8gOO1MHOTPH4Zldse/FH/Po4ngHmaRTGMmyKHUMc0hkLn4kOAdk5IYl3VzT6jO28uYBKFyKzwMCqCWhnEt8XCAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299573; c=relaxed/simple;
	bh=P2DVlROBb3MiFEF2zbD3N1sxc8wm0dVtPD3VmuMsna8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rfns31y4Wrvc3QMpJswtAPJpQxF/6l+TWiJSWqnbbSXvELu0ZAe6i1aHNS/MYuO1AeEE9Ph0/kA9sBQrUCxa0R35njfijLSo08+5c3YPc5a8zSg6wX6as6jr0fDGj0cZS+Lws2faioXiQFQrlDgG1uugd1NIUQSFqoMVzkgh7sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FGpV5eZ6; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FGpV5eZ6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774299564; x=1805835564;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=P2DVlROBb3MiFEF2zbD3N1sxc8wm0dVtPD3VmuMsna8=;
  b=FGpV5eZ6sn9sF67aF0xCEIBeVEg7aqkm2F6N5WTSifn8qyx9oxrrtyDS
   tZ7xNFJSRBQMVB13lpkTKU6ej2u4M08cmQJ7dSzHgpZGM7ec3FR4Ggzki
   dT1/8UUHkfSFFJ9rC0fRO+3ePGTKJkpUyyPh26Fcb6JGnWjrF+D4vTOmQ
   3dbDct7kfW+r3SWRZMp/XQP7ibtocwOvINeLHjOZUEKxGl/ZVbdYX5qIV
   ljQethuySN03uu7hiORUlhv7yKN5/Et27V04FmPBS7vmogdM4aQK5o240
   skY6UOiy8p8elg7rY2OEZnDas+VF9TBjkJKj64Le4MPxzk3tH8rUV5x+7
   Q==;
X-CSE-ConnectionGUID: IlL2lSmDTzCXRe81hBfnGQ==
X-CSE-MsgGUID: VhspFhWuRLyMn7UeI8e/NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74491152"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74491152"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:59:23 -0700
X-CSE-ConnectionGUID: eoWAbyRMQjKofKFqzGUC1g==
X-CSE-MsgGUID: IzNA7qE8TfSuzZoaU/t85A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224156869"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.124.221.51])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:59:22 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Mon, 23 Mar 2026 14:59:06 -0600
Subject: [PATCH v2 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuller_tdx_kexec_support-v2-3-87a36409e051@intel.com>
References: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
In-Reply-To: <20260323-fuller_tdx_kexec_support-v2-0-87a36409e051@intel.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.16-dev-8c19c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5650;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=P2DVlROBb3MiFEF2zbD3N1sxc8wm0dVtPD3VmuMsna8=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDJkHVy7zKHKdy7voQ0KY8yOLLTGbH7rwzu132rt+mf35C
 UfDebdkdpSyMIhxMciKKbL83fOR8Zjc9nyewARHmDmsTCBDGLg4BWAiryUZ/lkcmzDn5U3Tfxtu
 zbiXKWPcwr7aL+t7pL6GXn/7t9Wf791nZNhb8GGO4ZtTphLpkw7YdKat6y/7U/k2y/vfZ3bJrXX
 6z3kA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

Some early TDX-capable platforms have an erratum where a partial write
to TDX private memory can cause a machine check on a subsequent read.
On these platforms, kexec and kdump have been disabled in these cases,
because the old kernel cannot safely hand off TDX state to the new
kernel. Later TDX modules support the TDH.SYS.DISABLE SEAMCALL, which
provides a way to cleanly disable TDX and allow kexec to proceed.

The new SEAMCALL has an enumeration bit, but that is ignored. It is
expected that users will be using the latest TDX module, and the failure
mode for running the missing SEAMCALL on an older module is not fatal.

This can be a long running operation, and the time needed largely
depends on the amount of memory that has been allocated to TDs. If all
TDs have been destroyed prior to the sys_disable call, then it is fast,
with only needing to override the TDX module memory.

After the SEAMCALL completes, the TDX module is disabled and all memory
resources allocated to TDX are freed and reset. The next kernel can then
re-initialize the TDX module from scratch via the normal TDX bring-up
sequence.

The SEAMCALL can return two different error codes that expect a retry.
 - TDX_INTERRUPTED_RESUMABLE can be returned in the case of a host
   interrupt. However, it will not return until it makes some forward
   progress, so we can expect to complete even in the case of interrupt
   storms.
 - TDX_SYS_BUSY will be returned on contention with other TDH.SYS.*
   SEAMCALLs, however a side effect of TDH.SYS.DISABLE is that it will
   block other SEAMCALLs once it gets going. So this contention will be
   short lived.

So loop infinitely on either of these error codes, until success or other
error.

Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 arch/x86/include/asm/shared/tdx_errno.h |  1 +
 arch/x86/include/asm/tdx.h              |  3 +++
 arch/x86/virt/vmx/tdx/tdx.h             |  1 +
 arch/x86/virt/vmx/tdx/tdx.c             | 28 ++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+)

diff --git a/arch/x86/include/asm/shared/tdx_errno.h b/arch/x86/include/asm/shared/tdx_errno.h
index 8bf6765cf082..246b4fd54a48 100644
--- a/arch/x86/include/asm/shared/tdx_errno.h
+++ b/arch/x86/include/asm/shared/tdx_errno.h
@@ -15,6 +15,7 @@
 #define TDX_NON_RECOVERABLE_TD_NON_ACCESSIBLE	0x6000000500000000ULL
 #define TDX_NON_RECOVERABLE_TD_WRONG_APIC_MODE	0x6000000700000000ULL
 #define TDX_INTERRUPTED_RESUMABLE		0x8000000300000000ULL
+#define TDX_SYS_BUSY				0x8000020200000000ULL
 #define TDX_OPERAND_INVALID			0xC000010000000000ULL
 #define TDX_OPERAND_BUSY			0x8000020000000000ULL
 #define TDX_PREVIOUS_TLB_EPOCH_BUSY		0x8000020100000000ULL
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 7674fc530090..a0a4a15142fc 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -172,6 +172,8 @@ static inline int pg_level_to_tdx_sept_level(enum pg_level level)
         return level - 1;
 }
 
+void tdx_sys_disable(void);
+
 u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
 u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page);
 u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, struct page *source, u64 *ext_err1, u64 *ext_err2);
@@ -203,6 +205,7 @@ static inline void tdx_init(void) { }
 static inline u32 tdx_get_nr_guest_keyids(void) { return 0; }
 static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
 static inline const struct tdx_sys_info *tdx_get_sysinfo(void) { return NULL; }
+static inline void tdx_sys_disable(void) { }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
 #endif /* !__ASSEMBLER__ */
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index dde219c823b4..e2cf2dd48755 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -46,6 +46,7 @@
 #define TDH_PHYMEM_PAGE_WBINVD		41
 #define TDH_VP_WR			43
 #define TDH_SYS_CONFIG			45
+#define TDH_SYS_DISABLE			69
 
 /*
  * SEAMCALL leaf:
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 0802d0fd18a4..3a76000dec7a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -37,6 +37,7 @@
 #include <asm/msr.h>
 #include <asm/cpufeature.h>
 #include <asm/tdx.h>
+#include <asm/shared/tdx_errno.h>
 #include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/mce.h>
@@ -1940,3 +1941,30 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
 	return seamcall(TDH_PHYMEM_PAGE_WBINVD, &args);
 }
 EXPORT_SYMBOL_FOR_KVM(tdh_phymem_page_wbinvd_hkid);
+
+void tdx_sys_disable(void)
+{
+	struct tdx_module_args args = {};
+	u64 ret;
+
+	/*
+	 * Don't loop forever.
+	 *  - TDX_INTERRUPTED_RESUMABLE guarantees forward progress between
+	 *    calls.
+	 *  - TDX_SYS_BUSY could transiently contend with TDH.SYS.* SEAMCALLs,
+	 *    but will lock out future ones.
+	 *
+	 * This is a 'destructive' SEAMCALL, in that no other SEAMCALL can be
+	 * run after this until a full reinitialization is done.
+	 */
+	do {
+		ret = seamcall(TDH_SYS_DISABLE, &args);
+	} while (ret == TDX_INTERRUPTED_RESUMABLE || ret == TDX_SYS_BUSY);
+
+	/*
+	 * Print SEAMCALL failures, but not SW-defined error codes
+	 * (SEAMCALL faulted with #GP/#UD, TDX not supported).
+	 */
+	if (ret && (ret & TDX_SW_ERROR) != TDX_SW_ERROR)
+		pr_err("TDH.SYS.DISABLE failed: 0x%016llx\n", ret);
+}

-- 
2.53.0

