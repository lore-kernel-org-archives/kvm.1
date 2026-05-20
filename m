Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17243E5EF9;
	Wed, 20 May 2026 13:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284421; cv=none; b=BoX9RXhWgG+cLa6WFx993vENHe6vbNDskGHC3VteAkpqC66fZUSgdbwASYpUIsuhy6oZhVemIerqEYqLSQkRgYFwya69Rng6ro4l7VUcMb2lxcJYfUfCu9q6vuX37Kg7cA8fi2Y5Sb+qba3kXMaPj1LMigbVek5GMRtrpkWv/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284421; c=relaxed/simple;
	bh=AlehDs/IqpKIcQ5FsfjPn2/Cs/DHt7hYJskpq+M548c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0LfPoPFCmLzn1pKlS4Tvl9gSiTblw5phIl1knOtPazeGGkD3oGlvegawYss49KjCn6+5CaQS7pwLjcx8j5OJsvIUJN0icsL1yd6/f41vwQ4YViYOW8k5zcUA//+xupniRRt8nq5jBLezUWpfmVfg36UGUl5fYSr9rjucmv6feY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgmSTf5X; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgmSTf5X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779284418; x=1810820418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AlehDs/IqpKIcQ5FsfjPn2/Cs/DHt7hYJskpq+M548c=;
  b=LgmSTf5XOPmligJcR9FmNwfszeGYlC1DB9jb0A+Vx/Kj34yyI17YDhoz
   rB1ODbmsHJBLJKbrAITbWrNHIl5e08MkKbqmwWKPxcECVtfWN4rBEcgoP
   MOfDVgRXf9hqL3aCMXoydsw2aoi6UHJ9nMUAQltVK8z4rkm3+VKBSnGp9
   UlNkPq/Or/umtn2pdx3lt6P1rIN3VnO1rBFOtTapojoiMA58Ao09PHjwm
   Xaku79H7MMzOkonlZBUhypoB1Tq7ZPhWOpnbZF/gvswVIWBQQ3fd7o5DJ
   bLBmHoH3faZHlKDc9XJXqDkXJiMEN+7RD6ULEWZ0njDVD413U+4E/RfQz
   Q==;
X-CSE-ConnectionGUID: 7RmRDnx9TpWXY3i1GRmwng==
X-CSE-MsgGUID: Lm99F4OdSuiI2G60/vnLSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80146493"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="80146493"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:15 -0700
X-CSE-ConnectionGUID: JwgCiX6ZSsWPYH4PXaafsQ==
X-CSE-MsgGUID: DMYUw12pT3m4kEo8EfC7YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235923846"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 06:40:14 -0700
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
Subject: [PATCH v10 11/25] coco/tdx-host: Don't expose P-SEAMLDR information on CPUs with erratum
Date: Wed, 20 May 2026 06:38:14 -0700
Message-ID: <20260520133909.409394-12-chao.gao@intel.com>
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

TDX-capable CPUs clobber the current VMCS on return from P-SEAMLDR, as
documented in Intel® Trust Domain CPU Architectural Extensions:

  SEAMRET from the P-SEAMLDR clears the current VMCS structure pointed
  to by the current-VMCS pointer. A VMM that invokes the P-SEAMLDR using
  SEAMCALL must reload the current-VMCS, if required, using the VMPTRLD
  instruction.

Clearing the current VMCS behind KVM's back will break KVM.

Future CPUs will fix this by preserving the current VMCS across
P-SEAMLDR calls. A future specification update will describe the SEAMRET
VMCS-clearing behavior as an erratum and to state that it does not occur
when IA32_VMX_BASIC[60] is set.

Add a CPU bug bit for this erratum and refuse to expose P-SEAMLDR
information on affected CPUs, because even reading the P-SEAMLDR sysfs
knobs would enter and exit P-SEAMLDR.

Use a CPU bug bit to stay consistent with X86_BUG_TDX_PW_MCE. As a bonus,
the bug bit is visible to userspace, which allows userspace to determine
why these sysfs files are not exposed, and it can also be checked by other
kernel components in the future if needed.

== Alternatives ==
Two workarounds were considered but both were rejected:

1. Save/restore the current VMCS around P-SEAMLDR calls. This produces ugly
   assembly code [1] and doesn't play well with #MCE or #NMI if they
   need to use the current VMCS.

2. Move KVM's VMCS tracking logic to the TDX core code, which would break
   the boundary between KVM and the TDX core code [2].

Signed-off-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/kvm/fedb3192-e68c-423c-93b2-a4dc2f964148@intel.com/ # [1]
Link: https://lore.kernel.org/kvm/aYIXFmT-676oN6j0@google.com/ # [2]
---
This is split into a separate patch rather than folded into the previous one,
because the erratum handling warrants a longer changelog and discussion of
the alternatives.

v10:
 - Make it clear that clearing VMCS is the current architecture behavior.
   but will be fixed by a later doc update.
---
 arch/x86/include/asm/cpufeatures.h    |  1 +
 arch/x86/include/asm/vmx.h            |  1 +
 arch/x86/virt/vmx/tdx/tdx.c           | 11 +++++++++++
 drivers/virt/coco/tdx-host/tdx-host.c |  8 ++++++++
 4 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 1d506e5d6f46..7b572bc24265 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -573,4 +573,5 @@
 #define X86_BUG_ITS_NATIVE_ONLY		X86_BUG( 1*32+ 8) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
 #define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
 #define X86_BUG_VMSCAPE			X86_BUG( 1*32+10) /* "vmscape" CPU is affected by VMSCAPE attacks from guests */
+#define X86_BUG_SEAMRET_INVD_VMCS	X86_BUG( 1*32+11) /* "seamret_invd_vmcs" SEAMRET from P-SEAMLDR clears the current VMCS */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index 37080382df54..49d8551d285d 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -147,6 +147,7 @@ struct vmcs {
 #define VMX_BASIC_INOUT				BIT_ULL(54)
 #define VMX_BASIC_TRUE_CTLS			BIT_ULL(55)
 #define VMX_BASIC_NO_HW_ERROR_CODE_CC		BIT_ULL(56)
+#define VMX_BASIC_NO_SEAMRET_INVD_VMCS		BIT_ULL(60)
 
 static inline u32 vmx_basic_vmcs_revision_id(u64 vmx_basic)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 5fb0441a9ac6..53cf99c41dbb 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -42,6 +42,7 @@
 #include <asm/processor.h>
 #include <asm/mce.h>
 #include <asm/virt.h>
+#include <asm/vmx.h>
 
 #include "seamcall_internal.h"
 #include "tdx.h"
@@ -1450,6 +1451,8 @@ static struct notifier_block tdx_memory_nb = {
 
 static void __init check_tdx_erratum(void)
 {
+	u64 basic_msr;
+
 	/*
 	 * These CPUs have an erratum.  A partial write from non-TD
 	 * software (e.g. via MOVNTI variants or UC/WC mapping) to TDX
@@ -1461,6 +1464,14 @@ static void __init check_tdx_erratum(void)
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
index 2997311f72fa..2cd7be7bb404 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -98,6 +98,14 @@ static umode_t seamldr_group_visible(struct kobject *kobj, struct attribute *att
 	if (!tdx_supports_runtime_update(sysinfo))
 		return 0;
 
+	/*
+	 * Calling P-SEAMLDR on CPUs with the seamret_invd_vmcs bug clears
+	 * the current VMCS, which breaks KVM. Verify the erratum is not
+	 * present before exposing P-SEAMLDR features.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_SEAMRET_INVD_VMCS))
+		return 0;
+
 	return attr->mode;
 }
 
-- 
2.52.0

