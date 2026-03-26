Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2338A70F;
	Thu, 26 Mar 2026 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514748; cv=none; b=pIHYe4K+/XhCrTWd4e9K30VVf030AnKEKtfXBqLG/q7p3IzPiPdOIoc6hjO4fsr3O1U1N5fY9jzZvHUDjTfjNiizfMkGVsbDp3+bCwZGzJi3XeGxoS9+w5Fv6QvzFuryGRqRIDM53Or6xbZSK/1myTZeLLxZyAK6nrZcwnswWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514748; c=relaxed/simple;
	bh=muJF265lWTLM0ERfs1+2MxqJtN31axw2Pd8/CxfG3oY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g24eVqqM9BoKi/XVtVIRjujwT4nm4qlZ/xQUECHoFuNVqLobOsmaut7Se/d/kW5N6nW5QEQv3mKkFejUeoWeCBuWPn1mmpM/CEXuNHPbc+yGnbncoBdYtYoKJE1Rl1p46Eu7UXB54BoMS3C4+4AokYk1mU7ykIjEnGQsLY+xqnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QulrEX6o; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QulrEX6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774514746; x=1806050746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=muJF265lWTLM0ERfs1+2MxqJtN31axw2Pd8/CxfG3oY=;
  b=QulrEX6or0XDAanOQ/DANgxRRyjY0sbvmlm480jOkaW+vqCYkdiUFe29
   cRRHLLmcxCw/xqsPMKXAZVjl8ZbVZdNFekX3ZVJAA64g7MEdBK+m/F7v7
   U0m5ac8SzPIPhvdmMEuvjufvmqvapdbUWnjINA92qyvxW42vBUU8v9KXX
   YNvfviea7ZocPNUBP7NJx/y5Qx6bGbCCfrWk4JjA2CRya6f0TVb6FbKB4
   6zjfH0MvpXsKzoyKemcKytj6tR92ysL4yT3SemxOgjKEMgkU3eZyfjmpG
   jBgZThnTqe0GAM/N07ebsf7nzEHrVBJ7IhMA+5hAyrLdEvYTVQTOOpclt
   g==;
X-CSE-ConnectionGUID: Fz7u4yErT3KTzM5aIVYF4g==
X-CSE-MsgGUID: CZLwtt/FSjmtzsFNKHCSow==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86644754"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="86644754"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:26 -0700
X-CSE-ConnectionGUID: 7ZfLQLSITSOLURUS9cMa0w==
X-CSE-MsgGUID: HHKhthstQAiTZLejTot7dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224967246"
Received: from 984fee019967.jf.intel.com ([10.23.153.244])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 01:45:26 -0700
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
	xiaoyao.li@intel.com,
	yan.y.zhao@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v6 18/22] coco/tdx-host: Don't expose P-SEAMLDR features on CPUs with erratum
Date: Thu, 26 Mar 2026 01:44:09 -0700
Message-ID: <20260326084448.29947-19-chao.gao@intel.com>
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
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
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
index ad5b83390e61..3f4221098b78 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -39,6 +39,7 @@
 #include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/mce.h>
+#include <asm/vmx.h>
 
 #include "seamcall_internal.h"
 #include "tdx.h"
@@ -1455,6 +1456,8 @@ static struct notifier_block tdx_memory_nb = {
 
 static void __init check_tdx_erratum(void)
 {
+	u64 basic_msr;
+
 	/*
 	 * These CPUs have an erratum.  A partial write from non-TD
 	 * software (e.g. via MOVNTI variants or UC/WC mapping) to TDX
@@ -1466,6 +1469,14 @@ static void __init check_tdx_erratum(void)
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
index d4a552853021..f236119c2748 100644
--- a/drivers/virt/coco/tdx-host/tdx-host.c
+++ b/drivers/virt/coco/tdx-host/tdx-host.c
@@ -106,6 +106,14 @@ static bool can_expose_seamldr(void)
 	if (!sysinfo)
 		return false;
 
+	/*
+	 * Calling P-SEAMLDR on CPUs with the seamret_invd_vmcs bug clears
+	 * the current VMCS, which breaks KVM. Verify the erratum is not
+	 * present before exposing P-SEAMLDR features.
+	 */
+	if (boot_cpu_has_bug(X86_BUG_SEAMRET_INVD_VMCS))
+		return false;
+
 	return tdx_supports_runtime_update(sysinfo);
 }
 
-- 
2.47.3

