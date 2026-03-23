Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EC3E5EC6;
	Mon, 23 Mar 2026 20:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774299572; cv=none; b=j8g6TLtuCRplwc70S+ORMnQr04sqedIsK+G3ZHABHn271Zh9z3aJS/KHiR0SNPIVDlSWy+HeqOqE6dBJTbaU3VjYCgK0QtJBVRzEMRX6eXmNjRjs/yiYnemr+6LGwWmbNR6+QShKLKnLvu6zo8wTkL5kO+KWHzlQvaZ+VWBRwi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774299572; c=relaxed/simple;
	bh=pZPF5E66mGJD0tGfn+qRQzAoVevdL7wcW2+5+5knpfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=phamfLGo9HGFxC3WVwetNoYfEVVMcNOkGeaEa7vQq5Hsd6EWKRxPZvPLszph7x90s2KMpcbmPag6wBAaMemtaGol//Nxo/hfSfMdsdlCPTrisOBb0n1g+a2gf6RcEz+DuHA5rx8yRXAHkWht4sbrWjRd3Tm/jmcg9tFHIVNdivY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jawaMhUg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jawaMhUg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774299571; x=1805835571;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=pZPF5E66mGJD0tGfn+qRQzAoVevdL7wcW2+5+5knpfQ=;
  b=jawaMhUgbCLH0Y7U0Oh68nvx9/7GeQHPCgTouCbm2CpFVyv+uNTZiHcs
   HDkw8ePppLdEpuR7GvDqGF4FJEeDsPBcn77UUt36HHfb9iI5sfLCpK48S
   lUtxfsZeYnXOFUdGtLDgqzihD4lzVA/tTaBoeMWKBagTQji7xm5zIa/ZI
   egPfkiJdSBTlGI2Ezual34vBMSDjwtqRZJtJs4q9SNsTfzeQXdU9dIhQD
   WDZRfuVkxd40794DtrPDMHe5GD8UeTcKmWgYpQHFFY6i8W90uoML6tJeC
   sLsYnqfcRhJYukig8sqGfle6PU4zzPw+WGPt6+aTEkBvmnAxOJVrmcy7A
   w==;
X-CSE-ConnectionGUID: mPkoV0JISOWfMEBXW8lbNg==
X-CSE-MsgGUID: +RgD7v9xQMGbjCB2k0vKew==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="74491159"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74491159"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:59:24 -0700
X-CSE-ConnectionGUID: KjKJ7GB5TiOX1EVfyw1BZg==
X-CSE-MsgGUID: zIFc9fmvTPSl0LWM8Q/QGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="224156874"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.124.221.51])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 13:59:23 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Mon, 23 Mar 2026 14:59:07 -0600
Subject: [PATCH v2 4/5] x86/tdx: Disable the TDX module during kexec and
 kdump
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-fuller_tdx_kexec_support-v2-4-87a36409e051@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3582;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=pZPF5E66mGJD0tGfn+qRQzAoVevdL7wcW2+5+5knpfQ=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDJkHVy5j3npot2jw3deyu12XHC6//abyG1t5oXRqYOX75
 3EtnaxvOkpZGMS4GGTFFFn+7vnIeExuez5PYIIjzBxWJpAhDFycAjCRhwwMv1l++6lNqGzTe8T0
 YJ8Is0u+DtPnBqFHCz9m5cg2Je8PXc7IsC8nd7XrcdEXM9QOG8VU8hxVU+TdHMR51mLNmhhz+5S
 pnAA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

Use the TDH.SYS.DISABLE SEAMCALL, which disables the TDX module,
reclaims all memory resources assigned to TDX, and clears any
partial-write induced poison, to allow kexec and kdump on platforms with
the partial write errata.

On TDX-capable platforms with the partial write erratum, kexec has been
disabled because the new kernel could hit a machine check reading a
previously poisoned memory location.

Later TDX modules support TDH.SYS.DISABLE, which disables the module and
reclaims all TDX memory resources, allowing the new kernel to re-initialize
TDX from scratch. This operation also clears the old memory, cleaning up
any poison.

Add tdx_sys_disable() to tdx_shutdown(), which is called in the
syscore_shutdown path for kexec. This is done just before tdx_shutdown()
disables VMX on all CPUs.

For kdump, call tdx_sys_disable() in the crash path before
x86_virt_emergency_disable_virtualization_cpu() does VMXOFF.

Since this clears any poison on TDX-managed memory, remove the
X86_BUG_TDX_PW_MCE check in machine_kexec() that blocked kexec on
partial write errata platforms.

Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 arch/x86/kernel/crash.c            |  2 ++
 arch/x86/kernel/machine_kexec_64.c | 16 ----------------
 arch/x86/virt/vmx/tdx/tdx.c        |  1 +
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cd796818d94d..623d4474631a 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -38,6 +38,7 @@
 #include <linux/kdebug.h>
 #include <asm/cpu.h>
 #include <asm/reboot.h>
+#include <asm/tdx.h>
 #include <asm/intel_pt.h>
 #include <asm/crash.h>
 #include <asm/cmdline.h>
@@ -112,6 +113,7 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 
 	crash_smp_send_stop();
 
+	tdx_sys_disable();
 	x86_virt_emergency_disable_virtualization_cpu();
 
 	/*
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 0590d399d4f1..c3f4a389992d 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -347,22 +347,6 @@ int machine_kexec_prepare(struct kimage *image)
 	unsigned long reloc_end = (unsigned long)__relocate_kernel_end;
 	int result;
 
-	/*
-	 * Some early TDX-capable platforms have an erratum.  A kernel
-	 * partial write (a write transaction of less than cacheline
-	 * lands at memory controller) to TDX private memory poisons that
-	 * memory, and a subsequent read triggers a machine check.
-	 *
-	 * On those platforms the old kernel must reset TDX private
-	 * memory before jumping to the new kernel otherwise the new
-	 * kernel may see unexpected machine check.  For simplicity
-	 * just fail kexec/kdump on those platforms.
-	 */
-	if (boot_cpu_has_bug(X86_BUG_TDX_PW_MCE)) {
-		pr_info_once("Not allowed on platform with tdx_pw_mce bug\n");
-		return -EOPNOTSUPP;
-	}
-
 	/* Setup the identity mapped 64bit page table */
 	result = init_pgtable(image, __pa(control_page));
 	if (result)
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 3a76000dec7a..aaf22a87717a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -252,6 +252,7 @@ static void tdx_shutdown_cpu(void *ign)
 
 static void tdx_shutdown(void *ign)
 {
+	tdx_sys_disable();
 	on_each_cpu(tdx_shutdown_cpu, NULL, 1);
 }
 

-- 
2.53.0

