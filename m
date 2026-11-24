Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795485652;
	b=Qyi6Sny0g+Ex1HQB+yWWI6SUepiCaDkcIyGB72j8xC8JZht8YOi6G0iCi6mnPA4r3PLR
	 apyMqfrbgPdVxaF43zvPGjc1kazdt6oIoDILhhuhdhPuwxwrZlskQP0se9EKwIR+nhuS/
	 trciDIXhnQ266tBxeETRcxhJBuKwTUUMc9/EUwXPjWJ58pog/JhF0x0A/UDbEuqqRSz89
	 kjTi8jPoLAVugfCl4aEjOZauL2cVlt7e2ZdiBeLyTlWQeM52CEelOVNoqM62DafH1kejJ
	 ZKKVjhPbPl3xXTOtiLfilg73DNe9jw6EM2dvg2HVWn0fwSJt4/0T2LYtEQNJjk9PbhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795485652;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=12urVjcJIDrcl9cjZIEhxB1h221OuQzODVPOk8kxWGk=;
	b=pzAZ2ga5YUWDObCI40nTulXfAWMVLLVsxObZtoKuKCaeHV0yd21JtuACNGAgyHa8hnLf
	 nAP2hr1ml1eQVEkBA5dbDTSFlE3+SwO0r16M0EBxFwixHICQ0kXW4jI4ny82UW1pzKA7v
	 Ul53DjDS9f+lDHJ97smV7JmYE3b5GgF8bccn6GaMwr2fOBoPzwT6rnCG10bhEqPYc1hSk
	 SgGE+as53A2ppb73xlzpvIAVOeX9AnvnXgD/hepVS/pbivoW+UeGqsjzkT6LCfRdnFqsa
	 Szl8nGi4bz6REFSKTL1y6wVZPwWhIRLKYbGO5mWZ+dYCTOBrXv0hn74vWLVHiQmSGvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kx0ffL+x;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A52606A31E;
	Tue, 24 Nov 2026 02:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66A52606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kx0ffL+x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795485650; x=1827021650;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lcA3kg9TsxK18noq96/6h7QbMzoV2+N3Xz/cpoKQw4E=;
  b=kx0ffL+xdSHPlZK1wiM9oFZbyuzfDZf3fOzsCDgwAFqi3+Aod6lc9UQF
   90ZYOtQS6+Xcdg/4hkzIaIIsJh0CpQwjJhHcuDhjhm0KUqHX4doxNzwLo
   xQ5M9NZdrKIAP+EaE8sXu1cE8yW+xt2oAxNLqxtVafQ1MyFcb25/RNSOm
   EfPh/uadsQzCp7/Z/B3o3QPIFuevsI7XzKk4meZ3EN+abzmp2NvVF14Ez
   sOgQ4Rp12QNfXIaT2ml29yCE2h7/96vUDpEJxLKEc7JtNo4E2cjgYNAgA
   w+2Uw4/xnMLbQvHgyV2bSsuk27T0O6GGGy+xn/db3MUMTHeYTF1PmFouu
   g==;
X-CSE-ConnectionGUID: PEcslABSQy6tg3NYkyfucw==
X-CSE-MsgGUID: G/OSGO9FSquc1nzbM9R1Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4360960"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4360960"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 18:00:49 -0800
X-CSE-ConnectionGUID: 7kg1gRCKQK+nRgQBRs1u1w==
X-CSE-MsgGUID: GOfZ3mg7Tr+rrB3JCjetsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11776766"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by fmviesa006.fm.intel.com with ESMTP; 23 Nov 2026 18:00:49 -0800
From: Sohil Mehta <sohil.mehta@intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dave Hansen <dave.hansen@intel.com>,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/fred: Add this_cpu_fred_sp() and export it for KVM
Date: Mon, 23 Nov 2026 17:58:40 -0800
Message-ID: <20261124015840.2673975-1-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FRED adds fields to the VMCS host-state area for the stack pointers of
stack levels 1 to 3. The CPU loads these pointers on every VM exit to
ensure a valid FRED event delivery context is established immediately.
These values are per CPU, so KVM has to refresh them each time a vCPU is
loaded onto a CPU.

The stack for each level is assigned implicitly, when the FRED RSP MSRs
are programmed during CPU initialization. KVM could read the MSRs back,
but that costs three RDMSRs on every vCPU load, while the kernel already
has the values at hand. Add a helper that returns the corresponding
stack pointer for each FRED RSP MSR. Use it to program the MSRs during
init, and export it for KVM.

Key the helper on the MSR rather than on a stack level, so that KVM
never needs to know which exception stack backs which level. Eventually,
the same interface can be extended for the FRED shadow stack MSRs as
well.

Originally-by: Xin Li <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
I have been working on splitting the FRED KVM series to make it easier
to review and merge. I am posting this separately because the patch has
a minor dependency on the ESTACK_ prefix patch merged in tip today. The
main goal is to collect acks from the x86 maintainers.

The first exported user for the helper is going to be in the FRED KVM
series, so I assume this would likely be merged via the KVM tree. You
can consider merging it via the x86 tree if you are feeling generous :)

Note, based on a quick check on a CWF system, reading the three FRED RSP
MSRs takes about ~6x longer than reading the per-CPU cached values.

v1:
 - Key the helper on the FRED RSP MSR rather than on a stack level.
   https://lore.kernel.org/lkml/82dc24e3-f574-4696-99cb-87c0c04eab93@intel.com/
 - Warn and return 0 on an unexpected MSR rather than calling BUG().
 - Add a comment saying why stack level 2 is special.
 - Drop Binbin's Reviewed-by and Xin's author tag, since the interface
   has changed.

FRED KVM v10:
 - https://lore.kernel.org/lkml/20260911213659.2025974-7-sohil.mehta@intel.com/
---
 arch/x86/include/asm/fred.h |  2 ++
 arch/x86/kernel/fred.c      | 29 ++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fred.h b/arch/x86/include/asm/fred.h
index 18a2f811c358..eb0b231f24ae 100644
--- a/arch/x86/include/asm/fred.h
+++ b/arch/x86/include/asm/fred.h
@@ -88,6 +88,7 @@ static __always_inline void fred_entry_from_kvm(unsigned int type, unsigned int
 void cpu_init_fred_exceptions(void);
 void cpu_init_fred_rsps(void);
 void fred_complete_exception_setup(void);
+unsigned long this_cpu_fred_sp(u32 msr);
 
 DECLARE_PER_CPU(unsigned long, fred_rsp0);
 
@@ -110,6 +111,7 @@ static __always_inline unsigned long fred_event_data(struct pt_regs *regs) { ret
 static inline void cpu_init_fred_exceptions(void) { }
 static inline void cpu_init_fred_rsps(void) { }
 static inline void fred_complete_exception_setup(void) { }
+static inline unsigned long this_cpu_fred_sp(u32 msr) { return 0; }
 static inline void fred_sync_rsp0(unsigned long rsp0) { }
 static inline void fred_update_rsp0(void) { }
 #endif /* CONFIG_X86_FRED */
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 1c452a389a70..12d2fda60e69 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/kernel.h>
+#include <linux/kvm_types.h>
 
 #include <asm/desc.h>
 #include <asm/fred.h>
@@ -25,6 +26,28 @@
 DEFINE_PER_CPU(unsigned long, fred_rsp0);
 EXPORT_PER_CPU_SYMBOL(fred_rsp0);
 
+unsigned long this_cpu_fred_sp(u32 msr)
+{
+	switch (msr) {
+	case MSR_IA32_FRED_RSP0:
+		return __this_cpu_read(fred_rsp0);
+	case MSR_IA32_FRED_RSP1:
+		return __this_cpu_ist_top_va(ESTACK_DB);
+	case MSR_IA32_FRED_RSP2:
+		/*
+		 * NMI and #MC both use the NMI stack so ESTACK_MCE is left
+		 * unused on a FRED system.
+		 */
+		return __this_cpu_ist_top_va(ESTACK_NMI);
+	case MSR_IA32_FRED_RSP3:
+		return __this_cpu_ist_top_va(ESTACK_DF);
+	default:
+		WARN_ONCE(1, "Unexpected FRED stack pointer MSR 0x%x\n", msr);
+		return 0;
+	}
+}
+EXPORT_SYMBOL_FOR_KVM(this_cpu_fred_sp);
+
 void cpu_init_fred_exceptions(void)
 {
 	/*
@@ -84,7 +107,7 @@ void cpu_init_fred_rsps(void)
 	       FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
 
 	/* The FRED equivalents to IST stacks... */
-	wrmsrq(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(ESTACK_DB));
-	wrmsrq(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(ESTACK_NMI));
-	wrmsrq(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(ESTACK_DF));
+	wrmsrq(MSR_IA32_FRED_RSP1, this_cpu_fred_sp(MSR_IA32_FRED_RSP1));
+	wrmsrq(MSR_IA32_FRED_RSP2, this_cpu_fred_sp(MSR_IA32_FRED_RSP2));
+	wrmsrq(MSR_IA32_FRED_RSP3, this_cpu_fred_sp(MSR_IA32_FRED_RSP3));
 }

base-commit: 135dbd0519cf7f72af120801ec7dbb79275a362d
-- 
2.43.0

