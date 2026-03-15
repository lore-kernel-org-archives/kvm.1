Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2633A36A011;
	Sun, 15 Mar 2026 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583191; cv=none; b=SWkR97Puc39eUvzRt2WWvtu+SFGOjo0OsQs/wrWIsNQ+y4YhI5orw4SMWsvEL0N0XBQi6qiVmzMFPb2ywpyCO+qVSOOPvYALdNObnm3AZocHiZkIA7OWXIZdzO/SY0Ee4ZhzhEiB2ehGv0H1Gg1viz1QodWKT//ZDm9R61HrFGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583191; c=relaxed/simple;
	bh=TxuhOuUeWGF7/bXrPkhx+NM3pKhsm0PETGVMaPQRx5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXvUzl7STif3nW7wVF3X6tC2yPSGd5NTpENZ44Hy5z/mopTTHb2KZigAyp4+xjGkFQxfPhE53vnWQNDHkiAGhU72ltTb7qK2rndOvO59dYmr9kVt5NsTrijqH7IHmvivPe5U/CIr5SMXbA+LlURHl3Tud6pUIOG6dgmZtF2tWDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KA3XPUkI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KA3XPUkI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773583189; x=1805119189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TxuhOuUeWGF7/bXrPkhx+NM3pKhsm0PETGVMaPQRx5c=;
  b=KA3XPUkIj4GLnvwgEgdB3XN1j8B20Tz64zob/R07ysYp3uNHb1KxKcfK
   jDDt1NNipUdVDqTbGemAuXVAy+Bmd5ujzSssgTJG9JrTfBW3gv99sJo2S
   LqLj08d79Mr/AoCu2QEChpNQi2SRoHwlFkfIoggxTfHIZj307+dqBSP2h
   lPEuq4fYg6cDDJlg9ExuC7QvVdCf8piltgsSpxk5lvg3C+iuEz/jRl5Dx
   0xqjS8b1gbh3htajeo7ZiQ//lkb+ovj+wPw1zLdFhrdHGNyIAS/FZyg+j
   SiIoYypfONLXQNBSGyYbTy2kKmBYOXHTNRMvMSS5Trx7bPEJanUvon4nj
   w==;
X-CSE-ConnectionGUID: +DYZSwdRRjWU9C1ezIQeuw==
X-CSE-MsgGUID: mDgCXOGgRiyR/w1Zh2aVZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74732551"
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="74732551"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:45 -0700
X-CSE-ConnectionGUID: OTwhSTCaR4q3UNhnvtOQzw==
X-CSE-MsgGUID: eR2a0y0HSg+jYmVKVvxOOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,122,1770624000"; 
   d="scan'208";a="226123079"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2026 06:59:45 -0700
From: Chao Gao <chao.gao@intel.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-coco@lists.linux.dev
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
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 18/22] coco/tdx-host: Don't expose P-SEAMLDR features on CPUs with erratum
Date: Sun, 15 Mar 2026 06:58:38 -0700
Message-ID: <20260315135920.354657-19-chao.gao@intel.com>
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

Some TDX-capable CPUs have an erratum, as documented in Intel® Trust
Domain CPU Architectural Extensions (May 2021 edition) Chapter 2.3:

  SEAMRET from the P-SEAMLDR clears the current VMCS structure pointed
  to by the current-VMCS pointer. A VMM that invokes the P-SEAMLDR using
  SEAMCALL must reload the current-VMCS, if required, using the VMPTRLD
  instruction.

Clearing the current VMCS behind KVM's back will break KVM.

This erratum is not present when IA32_VMX_BASIC[60] is set. Add a CPU
bug bit for this erratum and refuse to expose P-SEAMLDR features (e.g.,
TDX module updates) on affected CPUs.

== Alternatives ==
Two workarounds were considered but both were rejected:

1. Save/restore the current VMCS around P-SEAMLDR calls. This produces ugly
   assembly code [1] and doesn't play well with #MCE or #NMI if they
   need to use the current VMCS.

2. Move KVM's VMCS tracking logic to the TDX core code, which would break
   the boundary between KVM and the TDX core code [2].

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/kvm/fedb3192-e68c-423c-93b2-a4dc2f964148@intel.com/ # [1]
Link: https://lore.kernel.org/kvm/aYIXFmT-676oN6j0@google.com/ # [2]
---
 arch/x86/include/asm/cpufeatures.h    |  1 +
 arch/x86/include/asm/vmx.h            |  1 +
 arch/x86/virt/vmx/tdx/tdx.c           | 11 +++++++++++
 drivers/virt/coco/tdx-host/tdx-host.c |  8 ++++++++
 4 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dbe104df339b..377d009b7e2e 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -572,4 +572,5 @@
 #define X86_BUG_ITS_NATIVE_ONLY		X86_BUG( 1*32+ 8) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
 #define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
 #define X86_BUG_VMSCAPE			X86_BUG( 1*32+10) /* "vmscape" CPU is affected by VMSCAPE attacks from guests */
+#define X86_BUG_SEAMRET_INVD_VMCS	X86_BUG( 1*32+11) /* "seamret_invd_vmcs" SEAMRET from P-SEAMLDR clears the current VMCS */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index b92ff87e3560..a5a5b373ec42 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -136,6 +136,7 @@
 #define VMX_BASIC_INOUT				BIT_ULL(54)
 #define VMX_BASIC_TRUE_CTLS			BIT_ULL(55)
 #define VMX_BASIC_NO_HW_ERROR_CODE_CC		BIT_ULL(56)
+#define VMX_BASIC_NO_SEAMRET_INVD_VMCS		BIT_ULL(60)
 
 static inline u32 vmx_basic_vmcs_revision_id(u64 vmx_basic)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 2025d00b0567..b76b8c393425 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -39,6 +39,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/mce.h>
+#include <asm/vmx.h>
 
 #include "seamcall_internal.h"
 #include "tdx.h"
@@ -1454,6 +1455,8 @@ static struct notifier_block tdx_memory_nb = {
 
 static void __init check_tdx_erratum(void)
 {
+	u64 basic_msr;
+
 	/*
 	 * These CPUs have an erratum.  A partial write from non-TD
 	 * software (e.g. via MOVNTI variants or UC/WC mapping) to TDX
@@ -1465,6 +1468,14 @@ static void __init check_tdx_erratum(void)
 	case INTEL_EMERALDRAPIDS_X:
 		setup_force_cpu_bug(X86_BUG_TDX_PW_MCE);
 	}
+
+	/*
+	 * Some TDX-capable CPUs have an erratum where the current VMCS is
+	 * cleared after calling into P-SEAMLDR.
+	 */
+	rdmsrq(MSR_IA32_VMX_BASIC, basic_msr);
+	if (!(basic_msr & VMX_BASIC_NO_SEAMRET_INVD_VMCS))
+		setup_force_cpu_bug(X86_BUG_SEAMRET_INVD_VMCS);
 }
 
 void __init tdx_init(void)
diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
index 1b93d20406c1..8cf3cc99024a 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -174,6 +174,14 @@ static int seamldr_init(struct device *dev)
 	if (!tdx_supports_runtime_update(tdx_sysinfo))
 		return 0;
 
+	/*
+	 * Calling P-SEAMLDR on CPUs with the seamret_invd_vmcs bug clears
+	 * the current VMCS, which breaks KVM. Verify the erratum is not
+	 * present before exposing P-SEAMLDR features.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_SEAMRET_INVD_VMCS))
+		return 0;
+
 	tdx_fwl = firmware_upload_register(THIS_MODULE, dev, "tdx_module",
 					   &tdx_fw_ops, NULL);
 	if (IS_ERR(tdx_fwl))
-- 
2.47.3

