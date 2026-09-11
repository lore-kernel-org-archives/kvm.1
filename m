Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4327130EF92;
	Fri, 11 Sep 2026 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162828; cv=none; b=tvERtwPq7PpodxBcL4gfK98SRyKcynZLK0bnuBZuJrtSYXGQ6Z16eJic/8c5I8PQ7fQqpDxzpwPOpo049nRRpJ5cBSqKoJncNwagokZp4jxSjnL+X69ZA6caLpco9Oiuw6glOvHuX6uXQDDadQv1K+SwdpngW8kdkeT0S+z4ufs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162828; c=relaxed/simple;
	bh=iwxzmH2iihIdxmWRlG66weRogxbaF6jOqwKQ+MUSomg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8IN93VD24CIcjEcUB9E8HOwR8IDTL+IpC8X7/sx54O9OdEvVgP427pp0r4DN04Hd2Jt39vVtRsij1XPvkCvdkr9ym883LpNllNY5k3AWuOQ07jWq+IAxOF39kyLNMh5uJcJG2vgc4N86pkjYMfhynck9m8cjTlqyEpXcVGxZig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QZDc4pF4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QZDc4pF4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162826; x=1820698826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iwxzmH2iihIdxmWRlG66weRogxbaF6jOqwKQ+MUSomg=;
  b=QZDc4pF4jORHItwb0yKyxClFNk2CfRlJ+gu1h6q0M+cb1zTRVttuEYUL
   BIK2nx4almUTuvlor9aizqAlKTcnQR5RbMmw1/2Xvxp7j+UODwmeaE+WG
   c3Yxyd4o6Qno5MepG4xF7HcryBMhMo4mSLThebCjry0avkbfPLNetLJkp
   Q2p/fUfgthBnwdPafSf2WiKadyWC6V+Y2hOGDQ8uibyZD5hlvgoT36BBb
   FSeQer0uWGmIQGLF1nPkjmaHfKMXOeNk/pz5alb8cddeXFnALSmkXY/3d
   cvTYm3emhBssPve4mFtdfdAAaqUe7I6EfTY8+2OVJptyMKIVvXYgMDQdq
   w==;
X-CSE-ConnectionGUID: EBuzjFpxQq+8PB4NW925Ww==
X-CSE-MsgGUID: xITvrzZZRaWsUw+2wUjFYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572454"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572454"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:40:26 -0700
X-CSE-ConnectionGUID: Zx4jX7Y9RVSk51JgqfnD6A==
X-CSE-MsgGUID: 9k7Bz6UBSBGNtPMZSs8tvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272003956"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:40:25 -0700
From: Sohil Mehta <sohil.mehta@intel.com>
To: kvm@vger.kernel.org,
	x86@kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Xin Li <xin@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Shivansh Dhiman <shivansh.dhiman@amd.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Yosry Ahmed <yosry@kernel.org>,
	David Matlack <dmatlack@google.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v10 04/28] x86/cea: Prefix event stack names with ESTACK_
Date: Fri, 11 Sep 2026 14:36:34 -0700
Message-ID: <20260911213659.2025974-5-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911213659.2025974-1-sohil.mehta@intel.com>
References: <20260911213659.2025974-1-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Xin Li (Intel)" <xin@zytor.com>

Add the ESTACK_ prefix to event stack names to improve clarity and
readability.  Without the prefix, names like DF, NMI, and DB are too
brief and potentially ambiguous.

This renaming also prepares for converting __this_cpu_ist_top_va from
a macro into a function that accepts an enum exception_stack_ordering
argument, without requiring changes to existing callsites.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v10:
 - No change
---
 arch/x86/coco/sev/noinstr.c           |  4 ++--
 arch/x86/coco/sev/vc-handle.c         |  2 +-
 arch/x86/include/asm/cpu_entry_area.h | 26 +++++++++++++-------------
 arch/x86/kernel/cpu/common.c          | 10 +++++-----
 arch/x86/kernel/dumpstack_64.c        | 14 +++++++-------
 arch/x86/kernel/fred.c                |  6 +++---
 arch/x86/kernel/traps.c               |  2 +-
 arch/x86/mm/cpu_entry_area.c          | 12 ++++++------
 arch/x86/mm/fault.c                   |  2 +-
 9 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/x86/coco/sev/noinstr.c b/arch/x86/coco/sev/noinstr.c
index e1e03f12fc7b..8a695ab67821 100644
--- a/arch/x86/coco/sev/noinstr.c
+++ b/arch/x86/coco/sev/noinstr.c
@@ -31,7 +31,7 @@ static __always_inline bool on_vc_stack(struct pt_regs *regs)
 	if (ip_within_syscall_gap(regs))
 		return false;
 
-	return ((sp >= __this_cpu_ist_bottom_va(VC)) && (sp < __this_cpu_ist_top_va(VC)));
+	return ((sp >= __this_cpu_ist_bottom_va(ESTACK_VC)) && (sp < __this_cpu_ist_top_va(ESTACK_VC)));
 }
 
 /*
@@ -83,7 +83,7 @@ void noinstr __sev_es_ist_exit(void)
 	/* Read IST entry */
 	ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
 
-	if (WARN_ON(ist == __this_cpu_ist_top_va(VC)))
+	if (WARN_ON(ist == __this_cpu_ist_top_va(ESTACK_VC)))
 		return;
 
 	/* Read back old IST entry and write it to the TSS */
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index 96b62b49b2b5..134c14b489ef 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -871,7 +871,7 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 
 static __always_inline bool is_vc2_stack(unsigned long sp)
 {
-	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
+	return (sp >= __this_cpu_ist_bottom_va(ESTACK_VC2) && sp < __this_cpu_ist_top_va(ESTACK_VC2));
 }
 
 static __always_inline bool vc_from_invalid_context(struct pt_regs *regs)
diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index 462fc34f1317..d0f884c28178 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -18,19 +18,19 @@
 
 /* Macro to enforce the same ordering and stack sizes */
 #define ESTACKS_MEMBERS(guardsize, optional_stack_size)		\
-	char	DF_stack_guard[guardsize];			\
-	char	DF_stack[EXCEPTION_STKSZ];			\
-	char	NMI_stack_guard[guardsize];			\
-	char	NMI_stack[EXCEPTION_STKSZ];			\
-	char	DB_stack_guard[guardsize];			\
-	char	DB_stack[EXCEPTION_STKSZ];			\
-	char	MCE_stack_guard[guardsize];			\
-	char	MCE_stack[EXCEPTION_STKSZ];			\
-	char	VC_stack_guard[guardsize];			\
-	char	VC_stack[optional_stack_size];			\
-	char	VC2_stack_guard[guardsize];			\
-	char	VC2_stack[optional_stack_size];			\
-	char	IST_top_guard[guardsize];			\
+	char	ESTACK_DF_stack_guard[guardsize];		\
+	char	ESTACK_DF_stack[EXCEPTION_STKSZ];		\
+	char	ESTACK_NMI_stack_guard[guardsize];		\
+	char	ESTACK_NMI_stack[EXCEPTION_STKSZ];		\
+	char	ESTACK_DB_stack_guard[guardsize];		\
+	char	ESTACK_DB_stack[EXCEPTION_STKSZ];		\
+	char	ESTACK_MCE_stack_guard[guardsize];		\
+	char	ESTACK_MCE_stack[EXCEPTION_STKSZ];		\
+	char	ESTACK_VC_stack_guard[guardsize];		\
+	char	ESTACK_VC_stack[optional_stack_size];		\
+	char	ESTACK_VC2_stack_guard[guardsize];		\
+	char	ESTACK_VC2_stack[optional_stack_size];		\
+	char	ESTACK_IST_top_guard[guardsize];		\
 
 /* The exception stacks' physical storage. No guard pages required */
 struct exception_stacks {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a3df21d26460..99ec284fb829 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2372,12 +2372,12 @@ static inline void setup_getcpu(int cpu)
 static inline void tss_setup_ist(struct tss_struct *tss)
 {
 	/* Set up the per-CPU TSS IST stacks */
-	tss->x86_tss.ist[IST_INDEX_DF] = __this_cpu_ist_top_va(DF);
-	tss->x86_tss.ist[IST_INDEX_NMI] = __this_cpu_ist_top_va(NMI);
-	tss->x86_tss.ist[IST_INDEX_DB] = __this_cpu_ist_top_va(DB);
-	tss->x86_tss.ist[IST_INDEX_MCE] = __this_cpu_ist_top_va(MCE);
+	tss->x86_tss.ist[IST_INDEX_DF]	= __this_cpu_ist_top_va(ESTACK_DF);
+	tss->x86_tss.ist[IST_INDEX_NMI]	= __this_cpu_ist_top_va(ESTACK_NMI);
+	tss->x86_tss.ist[IST_INDEX_DB]	= __this_cpu_ist_top_va(ESTACK_DB);
+	tss->x86_tss.ist[IST_INDEX_MCE]	= __this_cpu_ist_top_va(ESTACK_MCE);
 	/* Only mapped when SEV-ES is active */
-	tss->x86_tss.ist[IST_INDEX_VC] = __this_cpu_ist_top_va(VC);
+	tss->x86_tss.ist[IST_INDEX_VC]	= __this_cpu_ist_top_va(ESTACK_VC);
 }
 #else /* CONFIG_X86_64 */
 static inline void tss_setup_ist(struct tss_struct *tss) { }
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 6c5defd6569a..40f51e278171 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -73,7 +73,7 @@ struct estack_pages {
 	 PFN_DOWN(CEA_ESTACK_OFFS(st) + CEA_ESTACK_SIZE(st) - 1)] = {	\
 		.offs	= CEA_ESTACK_OFFS(st),				\
 		.size	= CEA_ESTACK_SIZE(st),				\
-		.type	= STACK_TYPE_EXCEPTION + ESTACK_ ##st, }
+		.type	= STACK_TYPE_EXCEPTION + st, }
 
 /*
  * Array of exception stack page descriptors. If the stack is larger than
@@ -83,12 +83,12 @@ struct estack_pages {
  */
 static const
 struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
-	EPAGERANGE(DF),
-	EPAGERANGE(NMI),
-	EPAGERANGE(DB),
-	EPAGERANGE(MCE),
-	EPAGERANGE(VC),
-	EPAGERANGE(VC2),
+	EPAGERANGE(ESTACK_DF),
+	EPAGERANGE(ESTACK_NMI),
+	EPAGERANGE(ESTACK_DB),
+	EPAGERANGE(ESTACK_MCE),
+	EPAGERANGE(ESTACK_VC),
+	EPAGERANGE(ESTACK_VC2),
 };
 
 static __always_inline bool in_exception_stack(unsigned long *stack, struct stack_info *info)
diff --git a/arch/x86/kernel/fred.c b/arch/x86/kernel/fred.c
index 117aa06d25ca..1c452a389a70 100644
--- a/arch/x86/kernel/fred.c
+++ b/arch/x86/kernel/fred.c
@@ -84,7 +84,7 @@ void cpu_init_fred_rsps(void)
 	       FRED_STKLVL(X86_TRAP_DF,  FRED_DF_STACK_LEVEL));
 
 	/* The FRED equivalents to IST stacks... */
-	wrmsrq(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(DB));
-	wrmsrq(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(NMI));
-	wrmsrq(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(DF));
+	wrmsrq(MSR_IA32_FRED_RSP1, __this_cpu_ist_top_va(ESTACK_DB));
+	wrmsrq(MSR_IA32_FRED_RSP2, __this_cpu_ist_top_va(ESTACK_NMI));
+	wrmsrq(MSR_IA32_FRED_RSP3, __this_cpu_ist_top_va(ESTACK_DF));
 }
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 30aa8369957e..8afd607a5873 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -1075,7 +1075,7 @@ asmlinkage __visible noinstr struct pt_regs *vc_switch_off_ist(struct pt_regs *r
 
 	if (!get_stack_info_noinstr(stack, current, &info) || info.type == STACK_TYPE_ENTRY ||
 	    info.type > STACK_TYPE_EXCEPTION_LAST)
-		sp = __this_cpu_ist_top_va(VC2);
+		sp = __this_cpu_ist_top_va(ESTACK_VC2);
 
 sync:
 	/*
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 575f863f3c75..9fa371af8abc 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -151,15 +151,15 @@ static void __init percpu_setup_exception_stacks(unsigned int cpu)
 	 * by guard pages so each stack must be mapped separately. DB2 is
 	 * not mapped; it just exists to catch triple nesting of #DB.
 	 */
-	cea_map_stack(DF);
-	cea_map_stack(NMI);
-	cea_map_stack(DB);
-	cea_map_stack(MCE);
+	cea_map_stack(ESTACK_DF);
+	cea_map_stack(ESTACK_NMI);
+	cea_map_stack(ESTACK_DB);
+	cea_map_stack(ESTACK_MCE);
 
 	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
 		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT)) {
-			cea_map_stack(VC);
-			cea_map_stack(VC2);
+			cea_map_stack(ESTACK_VC);
+			cea_map_stack(ESTACK_VC2);
 		}
 	}
 }
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 45b99c3b1442..f6ee1cc3f125 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -677,7 +677,7 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		 * and then double-fault, though, because we're likely to
 		 * break the console driver and lose most of the stack dump.
 		 */
-		call_on_stack(__this_cpu_ist_top_va(DF) - sizeof(void*),
+		call_on_stack(__this_cpu_ist_top_va(ESTACK_DF) - sizeof(void*),
 			      handle_stack_overflow,
 			      ASM_CALL_ARG3,
 			      , [arg1] "r" (regs), [arg2] "r" (address), [arg3] "r" (&info));
-- 
2.43.0

