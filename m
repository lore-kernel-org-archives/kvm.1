Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C4631B131;
	Thu,  2 Apr 2026 06:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111541; cv=none; b=B1jyzJqXhFk1dQ2FH3gILUcVMxbZqPsCJi7KGRKhzXdar7z7zQD5n2nYmM0NXZCECQFyJL8XArAAjebU/oY6U45LzCb5g/Umy0AYLdimHA2NcOO37a/Rgqqsada1PI6IZZrEBHtQnho0sm8I50k+nQUEDmRblsn6vo8Ivi+Ht8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111541; c=relaxed/simple;
	bh=L0GDKUyMS3vDRDQ4Bwa6uOWIZAf2jVJIXpcNzmI0SKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V4sxv8j0LkgveCE1CtkzP2/AHT+ZCUhW8Kt0ho4Z8TcxvNUUqIqfO4MM4iZdHv6ZDo1/SdiCx6nzQpVM/o+PdI6aCzuGPjXlc0KJWzhm+j3InYXAak8amMkmnqe6kwbV6o665SAsMCOpU2zAqR1z9Y32zlrtQf0DqtfkROxR09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZWlHAiqG; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZWlHAiqG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775111540; x=1806647540;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=L0GDKUyMS3vDRDQ4Bwa6uOWIZAf2jVJIXpcNzmI0SKA=;
  b=ZWlHAiqGOlK9wG8L2pXg6dhKqYduJ0/Z2K1niRbWopp9t8fP7nzQCByn
   kLEXPG0ovH1uPu9oL1fD821GE3nbhuGV4PoOm4eScH1ksyd9ndfz2Nl69
   Eicwpdzl8zjysxlx3uDVAU/JmX9NFx4T0czyxvkk59gu9l8WbceB8GC0d
   IKKWrpAdpwsp8aUARdAAt1XWo5JHWOWgDWCY3jvTC3VxLdDjjzBUtuqf/
   MbHkbrRjCES9MafqyZEj+MmwdvVB8NZ85YvcY7oxPwwIRUKmK8QsJF/SL
   6JQflix675jw2q8WPuxEbPYqbZH+7FLpXIpZWF7+T5WNJYA/rlsYELPtL
   Q==;
X-CSE-ConnectionGUID: h5Ct9InGSFCH2FpYonyuag==
X-CSE-MsgGUID: wKrmN+QQT4OIx2Y9o/w2gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="75884384"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="75884384"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:32:19 -0700
X-CSE-ConnectionGUID: OahonsBMSOCsH73omgS2Kw==
X-CSE-MsgGUID: eW9MGh/6RlSdLmFyC/FeyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="222042383"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.124.223.130])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2026 23:32:18 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Thu, 02 Apr 2026 00:32:03 -0600
Subject: [PATCH v3 3/5] x86/virt/tdx: Add SEAMCALL wrapper for
 TDH.SYS.DISABLE
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-fuller_tdx_kexec_support-v3-3-34438d7094bf@intel.com>
References: <20260402-fuller_tdx_kexec_support-v3-0-34438d7094bf@intel.com>
In-Reply-To: <20260402-fuller_tdx_kexec_support-v3-0-34438d7094bf@intel.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Kiryl Shutsemau <kas@kernel.org>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Sean Christopherson <seanjc@google.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>, 
 Chao Gao <chao.gao@intel.com>, Kai Huang <kai.huang@intel.com>
X-Mailer: b4 0.16-dev-ad80c
X-Developer-Signature: v=1; a=openpgp-sha256; l=6333;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=L0GDKUyMS3vDRDQ4Bwa6uOWIZAf2jVJIXpcNzmI0SKA=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDJnneAtey7nkh6dtEDtlaGTaMsmwXvCB2Em/08dP2Te5n
 pFVzFbpKGVhEONikBVTZPm75yPjMbnt+TyBCY4wc1iZQIYwcHEKwER+lDMy3J3Q16E/O/e3ebmX
 wXfhigflb3N/i8y91LK72SHilwZbJ8N/v8f2/+b7Z6y5x/Gv7Y/vtx2LeBtOy+ZGaa27uHpue5s
 +GwA=
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

An error is printed if the SEAMCALL fails with anything other than the
error codes that cause retries, or 'synthesized' error codes produced
for #GP or #UD. e.g., an old module that has been properly initialized,
that doesn't implement SYS_DISABLE, returns TDX_OPERAND_INVALID. This
prints:

  virt/tdx: TDH.SYS.DISABLE failed: 0xc000010000000000

But a system that doesn't have any TDX support at all doesn't print
anything.

Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/include/asm/shared/tdx_errno.h |  1 +
 arch/x86/include/asm/tdx.h              |  3 +++
 arch/x86/virt/vmx/tdx/tdx.h             |  1 +
 arch/x86/virt/vmx/tdx/tdx.c             | 31 +++++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/shared/tdx_errno.h b/arch/x86/include/asm/shared/tdx_errno.h
index 3c1e8ce716e3..ee411b360e20 100644
--- a/arch/x86/include/asm/shared/tdx_errno.h
+++ b/arch/x86/include/asm/shared/tdx_errno.h
@@ -13,6 +13,7 @@
 #define TDX_NON_RECOVERABLE_TD_NON_ACCESSIBLE	0x6000000500000000ULL
 #define TDX_NON_RECOVERABLE_TD_WRONG_APIC_MODE	0x6000000700000000ULL
 #define TDX_INTERRUPTED_RESUMABLE		0x8000000300000000ULL
+#define TDX_SYS_BUSY				0x8000020200000000ULL
 #define TDX_OPERAND_INVALID			0xC000010000000000ULL
 #define TDX_OPERAND_BUSY			0x8000020000000000ULL
 #define TDX_PREVIOUS_TLB_EPOCH_BUSY		0x8000020100000000ULL
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index bf83a974a0d5..15eac89b0afb 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -193,6 +193,8 @@ static inline int pg_level_to_tdx_sept_level(enum pg_level level)
         return level - 1;
 }
 
+void tdx_sys_disable(void);
+
 u64 tdh_vp_enter(struct tdx_vp *vp, struct tdx_module_args *args);
 u64 tdh_mng_addcx(struct tdx_td *td, struct page *tdcs_page);
 u64 tdh_mem_page_add(struct tdx_td *td, u64 gpa, struct page *page, struct page *source, u64 *ext_err1, u64 *ext_err2);
@@ -224,6 +226,7 @@ static inline void tdx_init(void) { }
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
index 1b2d854ba664..1ae558bcca3a 100644
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
@@ -1947,3 +1948,33 @@ u64 tdh_phymem_page_wbinvd_hkid(u64 hkid, struct page *page)
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
+	 *
+	 *  - TDX_INTERRUPTED_RESUMABLE guarantees forward progress between
+	 *    calls.
+	 *
+	 *  - TDX_SYS_BUSY could be returned due to contention with other
+	 *    TDH.SYS.* SEAMCALLs, but will lock out *new* TDH.SYS.* SEAMCALLs,
+	 *    so that SYS.DISABLE can eventually make progress.
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

