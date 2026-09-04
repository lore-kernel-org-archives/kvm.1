Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33913A9632;
	Fri,  4 Sep 2026 02:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788489104; cv=none; b=SaYzjMgYyhFBgPC9Ng3r+vLLO/9SsWB6iUa+GUQzGcY6Ru4bDBRHivAlzPJQGcksJ4AXUc0+bag5l+Sht+xlQ7ghHKgQOc0mbgSFjFlt//YxAyrq0U1aH9/F3x7QkdxG64ey4gkL/11KakXgzOlR9vM5vjAZnYgoKF3+EgJkZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788489104; c=relaxed/simple;
	bh=Y/C74PtlLrDL9g64zLS3H+BxuUL5piASYlJDBzLOhUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUI66WA4lJ8aUsd61ZS1XeZwlzAKWURRInnW0A3qXz+Vmeki079EY0oabnK+GfHaExRfOu7SG4yufONUmGSvQBraaI2dVYDVhtQ0cqAb6RCKA0ralcVj7uOCUwuX7zx+KoVzrZeou/EsyQqVGRPd/eUu6RNdCuWXn8j0cygcBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yj5vJ381; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yj5vJ381"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788489100; x=1820025100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y/C74PtlLrDL9g64zLS3H+BxuUL5piASYlJDBzLOhUs=;
  b=Yj5vJ381hSUtS9cz2mYxrg8k946cVsj0pkYm1sZ6/IUdCzOOjD8KPC2Q
   1hsVDCB5FlK0YORlGwYFBKa3k9O4khNxSNi6dRKYRmiqhv2vliSgsdtOH
   p7ZRJZemxRTusTcrZpjOcqJlUEdcZva4hOt8Z2nocS5/lHnmJ6EVvtWrR
   OLTUbEHD0v0es92jPMwqosJpCnr93RlwwLdQha4hLTua7cQWGRGs8Yv2A
   SurancQdo1UrMIPB/LEjSjmhMGVTKzXUVKS4p8Ux6Y3T5dpKs9B/doCdv
   M14vl3NKxV6OKUfIYtp9IuALXhImwwq69hgvoKzvDrUJO7CWkwy/wpvzH
   Q==;
X-CSE-ConnectionGUID: u9rJoGHnRL+4eMVDjGHv/A==
X-CSE-MsgGUID: BX2HYz69SzCyquX3I+DlDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="106506759"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="106506759"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 19:31:39 -0700
X-CSE-ConnectionGUID: 1zwJdFx3Q5i3ZdT75mYyNw==
X-CSE-MsgGUID: T5ej3sr7QMybL0Nq6oFuQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="270433499"
Received: from zhaoliu1-desk.sh.intel.com ([10.238.208.118])
  by orviesa009.jf.intel.com with ESMTP; 03 Sep 2026 19:31:36 -0700
From: Zhao Liu <zhao1.liu@intel.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Chao Gao <chao.gao@intel.com>,
	Xin Li <xin@zytor.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 2/4] KVM: selftests: Synchronize and update VMCS controls
Date: Fri,  4 Sep 2026 10:31:03 +0800
Message-Id: <20260904023105.1167376-3-zhao1.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904023105.1167376-1-zhao1.liu@intel.com>
References: <20260904023105.1167376-1-zhao1.liu@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Copy and update VMCS controls definitions from arch/x86/include/asm/vmx.h.

And because VMX_FEATURE_##x is defined in
arch/x86/include/asm/vmxfeatures.h, copy this header file to selftest
as well.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 tools/testing/selftests/kvm/include/x86/vmx.h | 145 ++++++++++--------
 .../selftests/kvm/include/x86/vmxfeatures.h   |  93 +++++++++++
 2 files changed, 178 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/x86/vmxfeatures.h

diff --git a/tools/testing/selftests/kvm/include/x86/vmx.h b/tools/testing/selftests/kvm/include/x86/vmx.h
index 04f5e34dea3a..0c61cfdd3201 100644
--- a/tools/testing/selftests/kvm/include/x86/vmx.h
+++ b/tools/testing/selftests/kvm/include/x86/vmx.h
@@ -11,85 +11,110 @@
 #include <stdint.h>
 #include "processor.h"
 #include "apic.h"
+#include "vmxfeatures.h"
+
+#define VMCS_CONTROL_BIT(x)	BIT(VMX_FEATURE_##x & 0x1f)
 
 /*
  * Definitions of Primary Processor-Based VM-Execution Controls.
  */
-#define CPU_BASED_INTR_WINDOW_EXITING		0x00000004
-#define CPU_BASED_USE_TSC_OFFSETTING		0x00000008
-#define CPU_BASED_HLT_EXITING			0x00000080
-#define CPU_BASED_INVLPG_EXITING		0x00000200
-#define CPU_BASED_MWAIT_EXITING			0x00000400
-#define CPU_BASED_RDPMC_EXITING			0x00000800
-#define CPU_BASED_RDTSC_EXITING			0x00001000
-#define CPU_BASED_CR3_LOAD_EXITING		0x00008000
-#define CPU_BASED_CR3_STORE_EXITING		0x00010000
-#define CPU_BASED_CR8_LOAD_EXITING		0x00080000
-#define CPU_BASED_CR8_STORE_EXITING		0x00100000
-#define CPU_BASED_TPR_SHADOW			0x00200000
-#define CPU_BASED_NMI_WINDOW_EXITING		0x00400000
-#define CPU_BASED_MOV_DR_EXITING		0x00800000
-#define CPU_BASED_UNCOND_IO_EXITING		0x01000000
-#define CPU_BASED_USE_IO_BITMAPS		0x02000000
-#define CPU_BASED_MONITOR_TRAP			0x08000000
-#define CPU_BASED_USE_MSR_BITMAPS		0x10000000
-#define CPU_BASED_MONITOR_EXITING		0x20000000
-#define CPU_BASED_PAUSE_EXITING			0x40000000
-#define CPU_BASED_ACTIVATE_SECONDARY_CONTROLS	0x80000000
+#define CPU_BASED_INTR_WINDOW_EXITING           VMCS_CONTROL_BIT(INTR_WINDOW_EXITING)
+#define CPU_BASED_USE_TSC_OFFSETTING            VMCS_CONTROL_BIT(USE_TSC_OFFSETTING)
+#define CPU_BASED_HLT_EXITING                   VMCS_CONTROL_BIT(HLT_EXITING)
+#define CPU_BASED_INVLPG_EXITING                VMCS_CONTROL_BIT(INVLPG_EXITING)
+#define CPU_BASED_MWAIT_EXITING                 VMCS_CONTROL_BIT(MWAIT_EXITING)
+#define CPU_BASED_RDPMC_EXITING                 VMCS_CONTROL_BIT(RDPMC_EXITING)
+#define CPU_BASED_RDTSC_EXITING                 VMCS_CONTROL_BIT(RDTSC_EXITING)
+#define CPU_BASED_CR3_LOAD_EXITING		VMCS_CONTROL_BIT(CR3_LOAD_EXITING)
+#define CPU_BASED_CR3_STORE_EXITING		VMCS_CONTROL_BIT(CR3_STORE_EXITING)
+#define CPU_BASED_ACTIVATE_TERTIARY_CONTROLS	VMCS_CONTROL_BIT(TERTIARY_CONTROLS)
+#define CPU_BASED_CR8_LOAD_EXITING              VMCS_CONTROL_BIT(CR8_LOAD_EXITING)
+#define CPU_BASED_CR8_STORE_EXITING             VMCS_CONTROL_BIT(CR8_STORE_EXITING)
+#define CPU_BASED_TPR_SHADOW                    VMCS_CONTROL_BIT(VIRTUAL_TPR)
+#define CPU_BASED_NMI_WINDOW_EXITING		VMCS_CONTROL_BIT(NMI_WINDOW_EXITING)
+#define CPU_BASED_MOV_DR_EXITING                VMCS_CONTROL_BIT(MOV_DR_EXITING)
+#define CPU_BASED_UNCOND_IO_EXITING             VMCS_CONTROL_BIT(UNCOND_IO_EXITING)
+#define CPU_BASED_USE_IO_BITMAPS                VMCS_CONTROL_BIT(USE_IO_BITMAPS)
+#define CPU_BASED_MONITOR_TRAP_FLAG             VMCS_CONTROL_BIT(MONITOR_TRAP_FLAG)
+#define CPU_BASED_USE_MSR_BITMAPS               VMCS_CONTROL_BIT(USE_MSR_BITMAPS)
+#define CPU_BASED_MONITOR_EXITING               VMCS_CONTROL_BIT(MONITOR_EXITING)
+#define CPU_BASED_PAUSE_EXITING                 VMCS_CONTROL_BIT(PAUSE_EXITING)
+#define CPU_BASED_ACTIVATE_SECONDARY_CONTROLS   VMCS_CONTROL_BIT(SEC_CONTROLS)
 
 #define CPU_BASED_ALWAYSON_WITHOUT_TRUE_MSR	0x0401e172
 
 /*
  * Definitions of Secondary Processor-Based VM-Execution Controls.
  */
-#define SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES 0x00000001
-#define SECONDARY_EXEC_ENABLE_EPT		0x00000002
-#define SECONDARY_EXEC_DESC			0x00000004
-#define SECONDARY_EXEC_ENABLE_RDTSCP		0x00000008
-#define SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE	0x00000010
-#define SECONDARY_EXEC_ENABLE_VPID		0x00000020
-#define SECONDARY_EXEC_WBINVD_EXITING		0x00000040
-#define SECONDARY_EXEC_UNRESTRICTED_GUEST	0x00000080
-#define SECONDARY_EXEC_APIC_REGISTER_VIRT	0x00000100
-#define SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY	0x00000200
-#define SECONDARY_EXEC_PAUSE_LOOP_EXITING	0x00000400
-#define SECONDARY_EXEC_RDRAND_EXITING		0x00000800
-#define SECONDARY_EXEC_ENABLE_INVPCID		0x00001000
-#define SECONDARY_EXEC_ENABLE_VMFUNC		0x00002000
-#define SECONDARY_EXEC_SHADOW_VMCS		0x00004000
-#define SECONDARY_EXEC_RDSEED_EXITING		0x00010000
-#define SECONDARY_EXEC_ENABLE_PML		0x00020000
-#define SECONDARY_EPT_VE			0x00040000
-#define SECONDARY_ENABLE_XSAV_RESTORE		0x00100000
-#define SECONDARY_EXEC_TSC_SCALING		0x02000000
-
-#define PIN_BASED_EXT_INTR_MASK			0x00000001
-#define PIN_BASED_NMI_EXITING			0x00000008
-#define PIN_BASED_VIRTUAL_NMIS			0x00000020
-#define PIN_BASED_VMX_PREEMPTION_TIMER		0x00000040
-#define PIN_BASED_POSTED_INTR			0x00000080
+#define SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES VMCS_CONTROL_BIT(VIRT_APIC_ACCESSES)
+#define SECONDARY_EXEC_ENABLE_EPT               VMCS_CONTROL_BIT(EPT)
+#define SECONDARY_EXEC_DESC			VMCS_CONTROL_BIT(DESC_EXITING)
+#define SECONDARY_EXEC_ENABLE_RDTSCP		VMCS_CONTROL_BIT(RDTSCP)
+#define SECONDARY_EXEC_VIRTUALIZE_X2APIC_MODE   VMCS_CONTROL_BIT(VIRTUAL_X2APIC)
+#define SECONDARY_EXEC_ENABLE_VPID              VMCS_CONTROL_BIT(VPID)
+#define SECONDARY_EXEC_WBINVD_EXITING		VMCS_CONTROL_BIT(WBINVD_EXITING)
+#define SECONDARY_EXEC_UNRESTRICTED_GUEST	VMCS_CONTROL_BIT(UNRESTRICTED_GUEST)
+#define SECONDARY_EXEC_APIC_REGISTER_VIRT       VMCS_CONTROL_BIT(APIC_REGISTER_VIRT)
+#define SECONDARY_EXEC_VIRTUAL_INTR_DELIVERY    VMCS_CONTROL_BIT(VIRT_INTR_DELIVERY)
+#define SECONDARY_EXEC_PAUSE_LOOP_EXITING	VMCS_CONTROL_BIT(PAUSE_LOOP_EXITING)
+#define SECONDARY_EXEC_RDRAND_EXITING		VMCS_CONTROL_BIT(RDRAND_EXITING)
+#define SECONDARY_EXEC_ENABLE_INVPCID		VMCS_CONTROL_BIT(INVPCID)
+#define SECONDARY_EXEC_ENABLE_VMFUNC            VMCS_CONTROL_BIT(VMFUNC)
+#define SECONDARY_EXEC_SHADOW_VMCS              VMCS_CONTROL_BIT(SHADOW_VMCS)
+#define SECONDARY_EXEC_ENCLS_EXITING		VMCS_CONTROL_BIT(ENCLS_EXITING)
+#define SECONDARY_EXEC_RDSEED_EXITING		VMCS_CONTROL_BIT(RDSEED_EXITING)
+#define SECONDARY_EXEC_ENABLE_PML               VMCS_CONTROL_BIT(PAGE_MOD_LOGGING)
+#define SECONDARY_EXEC_EPT_VIOLATION_VE		VMCS_CONTROL_BIT(EPT_VIOLATION_VE)
+#define SECONDARY_EXEC_PT_CONCEAL_VMX		VMCS_CONTROL_BIT(PT_CONCEAL_VMX)
+#define SECONDARY_EXEC_ENABLE_XSAVES		VMCS_CONTROL_BIT(XSAVES)
+#define SECONDARY_EXEC_MODE_BASED_EPT_EXEC	VMCS_CONTROL_BIT(MODE_BASED_EPT_EXEC)
+#define SECONDARY_EXEC_PT_USE_GPA		VMCS_CONTROL_BIT(PT_USE_GPA)
+#define SECONDARY_EXEC_TSC_SCALING              VMCS_CONTROL_BIT(TSC_SCALING)
+#define SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE	VMCS_CONTROL_BIT(USR_WAIT_PAUSE)
+#define SECONDARY_EXEC_BUS_LOCK_DETECTION	VMCS_CONTROL_BIT(BUS_LOCK_DETECTION)
+#define SECONDARY_EXEC_NOTIFY_VM_EXITING	VMCS_CONTROL_BIT(NOTIFY_VM_EXITING)
+
+/*
+ * Definitions of Tertiary Processor-Based VM-Execution Controls.
+ */
+#define TERTIARY_EXEC_IPI_VIRT			VMCS_CONTROL_BIT(IPI_VIRT)
+
+#define PIN_BASED_EXT_INTR_MASK                 VMCS_CONTROL_BIT(INTR_EXITING)
+#define PIN_BASED_NMI_EXITING                   VMCS_CONTROL_BIT(NMI_EXITING)
+#define PIN_BASED_VIRTUAL_NMIS                  VMCS_CONTROL_BIT(VIRTUAL_NMIS)
+#define PIN_BASED_VMX_PREEMPTION_TIMER          VMCS_CONTROL_BIT(PREEMPTION_TIMER)
+#define PIN_BASED_POSTED_INTR                   VMCS_CONTROL_BIT(POSTED_INTR)
 
 #define PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR	0x00000016
 
-#define VM_EXIT_SAVE_DEBUG_CONTROLS		0x00000004
-#define VM_EXIT_HOST_ADDR_SPACE_SIZE		0x00000200
-#define VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL	0x00001000
-#define VM_EXIT_ACK_INTR_ON_EXIT		0x00008000
+#define VM_EXIT_SAVE_DEBUG_CONTROLS             0x00000004
+#define VM_EXIT_HOST_ADDR_SPACE_SIZE            0x00000200
+#define VM_EXIT_LOAD_IA32_PERF_GLOBAL_CTRL      0x00001000
+#define VM_EXIT_ACK_INTR_ON_EXIT                0x00008000
 #define VM_EXIT_SAVE_IA32_PAT			0x00040000
 #define VM_EXIT_LOAD_IA32_PAT			0x00080000
-#define VM_EXIT_SAVE_IA32_EFER			0x00100000
-#define VM_EXIT_LOAD_IA32_EFER			0x00200000
-#define VM_EXIT_SAVE_VMX_PREEMPTION_TIMER	0x00400000
+#define VM_EXIT_SAVE_IA32_EFER                  0x00100000
+#define VM_EXIT_LOAD_IA32_EFER                  0x00200000
+#define VM_EXIT_SAVE_VMX_PREEMPTION_TIMER       0x00400000
+#define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
+#define VM_EXIT_PT_CONCEAL_PIP			0x01000000
+#define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
+#define VM_EXIT_LOAD_CET_STATE                  0x10000000
+#define VM_EXIT_SAVE_IA32_PERF_GLOBAL_CTRL	0x40000000
 
 #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
 
-#define VM_ENTRY_LOAD_DEBUG_CONTROLS		0x00000004
-#define VM_ENTRY_IA32E_MODE			0x00000200
-#define VM_ENTRY_SMM				0x00000400
-#define VM_ENTRY_DEACT_DUAL_MONITOR		0x00000800
-#define VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL	0x00002000
+#define VM_ENTRY_LOAD_DEBUG_CONTROLS            0x00000004
+#define VM_ENTRY_IA32E_MODE                     0x00000200
+#define VM_ENTRY_SMM                            0x00000400
+#define VM_ENTRY_DEACT_DUAL_MONITOR             0x00000800
+#define VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL     0x00002000
 #define VM_ENTRY_LOAD_IA32_PAT			0x00004000
-#define VM_ENTRY_LOAD_IA32_EFER			0x00008000
+#define VM_ENTRY_LOAD_IA32_EFER                 0x00008000
+#define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
+#define VM_ENTRY_PT_CONCEAL_PIP			0x00020000
+#define VM_ENTRY_LOAD_IA32_RTIT_CTL		0x00040000
+#define VM_ENTRY_LOAD_CET_STATE                 0x00100000
 
 #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
 
diff --git a/tools/testing/selftests/kvm/include/x86/vmxfeatures.h b/tools/testing/selftests/kvm/include/x86/vmxfeatures.h
new file mode 100644
index 000000000000..0204c004aef8
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/vmxfeatures.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef SELFTEST_KVM_VMXFEATURES_H
+#define SELFTEST_KVM_VMXFEATURES_H
+
+/*
+ * Defines VMX CPU feature bits
+ */
+#define NVMXINTS			5 /* N 32-bit words worth of info */
+
+/*
+ * Note: If the comment begins with a quoted string, that string is used
+ * in /proc/cpuinfo instead of the macro name.  Otherwise, this feature bit
+ * is not displayed in /proc/cpuinfo at all.
+ */
+
+/* Pin-Based VM-Execution Controls, EPT/VPID, APIC and VM-Functions, word 0 */
+#define VMX_FEATURE_INTR_EXITING	( 0*32+  0) /* VM-Exit on vectored interrupts */
+#define VMX_FEATURE_NMI_EXITING		( 0*32+  3) /* VM-Exit on NMIs */
+#define VMX_FEATURE_VIRTUAL_NMIS	( 0*32+  5) /* "vnmi" NMI virtualization */
+#define VMX_FEATURE_PREEMPTION_TIMER	( 0*32+  6) /* "preemption_timer" VMX Preemption Timer */
+#define VMX_FEATURE_POSTED_INTR		( 0*32+  7) /* "posted_intr" Posted Interrupts */
+
+/* EPT/VPID features, scattered to bits 16-23 */
+#define VMX_FEATURE_INVVPID		( 0*32+ 16) /* "invvpid" INVVPID is supported */
+#define VMX_FEATURE_EPT_EXECUTE_ONLY	( 0*32+ 17) /* "ept_x_only" EPT entries can be execute only */
+#define VMX_FEATURE_EPT_AD		( 0*32+ 18) /* "ept_ad" EPT Accessed/Dirty bits */
+#define VMX_FEATURE_EPT_1GB		( 0*32+ 19) /* "ept_1gb" 1GB EPT pages */
+#define VMX_FEATURE_EPT_5LEVEL		( 0*32+ 20) /* "ept_5level" 5-level EPT paging */
+
+/* Aggregated APIC features 24-27 */
+#define VMX_FEATURE_FLEXPRIORITY	( 0*32+ 24) /* "flexpriority" TPR shadow + virt APIC */
+#define VMX_FEATURE_APICV	        ( 0*32+ 25) /* "apicv" TPR shadow + APIC reg virt + virt intr delivery + posted interrupts */
+
+/* VM-Functions, shifted to bits 28-31 */
+#define VMX_FEATURE_EPTP_SWITCHING	( 0*32+ 28) /* "eptp_switching" EPTP switching (in guest) */
+
+/* Primary Processor-Based VM-Execution Controls, word 1 */
+#define VMX_FEATURE_INTR_WINDOW_EXITING ( 1*32+  2) /* VM-Exit if INTRs are unblocked in guest */
+#define VMX_FEATURE_USE_TSC_OFFSETTING	( 1*32+  3) /* "tsc_offset" Offset hardware TSC when read in guest */
+#define VMX_FEATURE_HLT_EXITING		( 1*32+  7) /* VM-Exit on HLT */
+#define VMX_FEATURE_INVLPG_EXITING	( 1*32+  9) /* VM-Exit on INVLPG */
+#define VMX_FEATURE_MWAIT_EXITING	( 1*32+ 10) /* VM-Exit on MWAIT */
+#define VMX_FEATURE_RDPMC_EXITING	( 1*32+ 11) /* VM-Exit on RDPMC */
+#define VMX_FEATURE_RDTSC_EXITING	( 1*32+ 12) /* VM-Exit on RDTSC */
+#define VMX_FEATURE_CR3_LOAD_EXITING	( 1*32+ 15) /* VM-Exit on writes to CR3 */
+#define VMX_FEATURE_CR3_STORE_EXITING	( 1*32+ 16) /* VM-Exit on reads from CR3 */
+#define VMX_FEATURE_TERTIARY_CONTROLS	( 1*32+ 17) /* Enable Tertiary VM-Execution Controls */
+#define VMX_FEATURE_CR8_LOAD_EXITING	( 1*32+ 19) /* VM-Exit on writes to CR8 */
+#define VMX_FEATURE_CR8_STORE_EXITING	( 1*32+ 20) /* VM-Exit on reads from CR8 */
+#define VMX_FEATURE_VIRTUAL_TPR		( 1*32+ 21) /* "vtpr" TPR virtualization, a.k.a. TPR shadow */
+#define VMX_FEATURE_NMI_WINDOW_EXITING	( 1*32+ 22) /* VM-Exit if NMIs are unblocked in guest */
+#define VMX_FEATURE_MOV_DR_EXITING	( 1*32+ 23) /* VM-Exit on accesses to debug registers */
+#define VMX_FEATURE_UNCOND_IO_EXITING	( 1*32+ 24) /* VM-Exit on *all* IN{S} and OUT{S}*/
+#define VMX_FEATURE_USE_IO_BITMAPS	( 1*32+ 25) /* VM-Exit based on I/O port */
+#define VMX_FEATURE_MONITOR_TRAP_FLAG	( 1*32+ 27) /* "mtf" VMX single-step VM-Exits */
+#define VMX_FEATURE_USE_MSR_BITMAPS	( 1*32+ 28) /* VM-Exit based on MSR index */
+#define VMX_FEATURE_MONITOR_EXITING	( 1*32+ 29) /* VM-Exit on MONITOR (MWAIT's accomplice) */
+#define VMX_FEATURE_PAUSE_EXITING	( 1*32+ 30) /* VM-Exit on PAUSE (unconditionally) */
+#define VMX_FEATURE_SEC_CONTROLS	( 1*32+ 31) /* Enable Secondary VM-Execution Controls */
+
+/* Secondary Processor-Based VM-Execution Controls, word 2 */
+#define VMX_FEATURE_VIRT_APIC_ACCESSES	( 2*32+  0) /* "vapic" Virtualize memory mapped APIC accesses */
+#define VMX_FEATURE_EPT			( 2*32+  1) /* "ept" Extended Page Tables, a.k.a. Two-Dimensional Paging */
+#define VMX_FEATURE_DESC_EXITING	( 2*32+  2) /* VM-Exit on {S,L}*DT instructions */
+#define VMX_FEATURE_RDTSCP		( 2*32+  3) /* Enable RDTSCP in guest */
+#define VMX_FEATURE_VIRTUAL_X2APIC	( 2*32+  4) /* Virtualize X2APIC for the guest */
+#define VMX_FEATURE_VPID		( 2*32+  5) /* "vpid" Virtual Processor ID (TLB ASID modifier) */
+#define VMX_FEATURE_WBINVD_EXITING	( 2*32+  6) /* VM-Exit on WBINVD */
+#define VMX_FEATURE_UNRESTRICTED_GUEST	( 2*32+  7) /* "unrestricted_guest" Allow Big Real Mode and other "invalid" states */
+#define VMX_FEATURE_APIC_REGISTER_VIRT	( 2*32+  8) /* "vapic_reg" Hardware emulation of reads to the virtual-APIC */
+#define VMX_FEATURE_VIRT_INTR_DELIVERY	( 2*32+  9) /* "vid" Evaluation and delivery of pending virtual interrupts */
+#define VMX_FEATURE_PAUSE_LOOP_EXITING	( 2*32+ 10) /* "ple" Conditionally VM-Exit on PAUSE at CPL0 */
+#define VMX_FEATURE_RDRAND_EXITING	( 2*32+ 11) /* VM-Exit on RDRAND*/
+#define VMX_FEATURE_INVPCID		( 2*32+ 12) /* Enable INVPCID in guest */
+#define VMX_FEATURE_VMFUNC		( 2*32+ 13) /* Enable VM-Functions (leaf dependent) */
+#define VMX_FEATURE_SHADOW_VMCS		( 2*32+ 14) /* "shadow_vmcs" VMREAD/VMWRITE in guest can access shadow VMCS */
+#define VMX_FEATURE_ENCLS_EXITING	( 2*32+ 15) /* VM-Exit on ENCLS (leaf dependent) */
+#define VMX_FEATURE_RDSEED_EXITING	( 2*32+ 16) /* VM-Exit on RDSEED */
+#define VMX_FEATURE_PAGE_MOD_LOGGING	( 2*32+ 17) /* "pml" Log dirty pages into buffer */
+#define VMX_FEATURE_EPT_VIOLATION_VE	( 2*32+ 18) /* "ept_violation_ve" Conditionally reflect EPT violations as #VE exceptions */
+#define VMX_FEATURE_PT_CONCEAL_VMX	( 2*32+ 19) /* Suppress VMX indicators in Processor Trace */
+#define VMX_FEATURE_XSAVES		( 2*32+ 20) /* Enable XSAVES and XRSTORS in guest */
+#define VMX_FEATURE_MODE_BASED_EPT_EXEC	( 2*32+ 22) /* "ept_mode_based_exec" Enable separate EPT EXEC bits for supervisor vs. user */
+#define VMX_FEATURE_PT_USE_GPA		( 2*32+ 24) /* Processor Trace logs GPAs */
+#define VMX_FEATURE_TSC_SCALING		( 2*32+ 25) /* "tsc_scaling" Scale hardware TSC when read in guest */
+#define VMX_FEATURE_USR_WAIT_PAUSE	( 2*32+ 26) /* "usr_wait_pause" Enable TPAUSE, UMONITOR, UMWAIT in guest */
+#define VMX_FEATURE_ENCLV_EXITING	( 2*32+ 28) /* VM-Exit on ENCLV (leaf dependent) */
+#define VMX_FEATURE_BUS_LOCK_DETECTION	( 2*32+ 30) /* VM-Exit when bus lock caused */
+#define VMX_FEATURE_NOTIFY_VM_EXITING	( 2*32+ 31) /* "notify_vm_exiting" VM-Exit when no event windows after notify window */
+
+/* Tertiary Processor-Based VM-Execution Controls, word 3 */
+#define VMX_FEATURE_IPI_VIRT		( 3*32+  4) /* "ipi_virt" Enable IPI virtualization */
+#endif /* SELFTEST_KVM_VMXFEATURES_H */
-- 
2.34.1

