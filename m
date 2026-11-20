Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795218765;
	b=avgBJJWsO2kme5/kWK//mPbTlx/UD/IgvusXKbaL2NmYx5KvdVqEbTvldFx11eUGixFw
	 /RAQnsInzbgLqddMlUOObnGOPR7ZhGJdiit9TXYMjpdbDQL0MeWk4C8z9W6vVUgsDw5uC
	 /7VjL6SrxQTumoq5tFLjrRsRA4WuG6u2CyqBGTh3FXa6gzbtKfyCABBlvQ2s3s8pZ3CXJ
	 xOIvk7PNr30H1kKf6fbCY8eBuIu7csMilTQIGTgpDRqPg40T4a9dInbKQIdkgTeBnJ4Z7
	 JPmf25Cv7aoAN+htns3oBN+eWCfhO0zmEPMmj05cWyBqMSIf5HzS/nlTUYlxP7pkVYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795218765;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tfP4Kgyh9eeR/sWL09gEiTNFaNNSY4Wv02vH8yqudX0=;
	b=bAWlSz5c+gnCqcLd0e8ht8M+MS6BLc6zH+eNzG6Bw291ScgKvWIF2NYk3y3Ik2Yw2ar+
	 aRnZy8fk15Ao42nsJlCepDGKN3yeVQLHXhVM+jk0tnDhEu83vGl0qktP1VSSn3zh7HgCh
	 wc9XGpTAMXA5PmU7WqvmbSxATmxyeX32HllAmQcZM7IpyzLydvjDLuF+oDrbIQ6Ooo/iC
	 fs2EYKumfUmeuGD4qUlNv2g1JE8XvbHfBiwez7RwuZeQZU0RDARdd0mJFrCp5SMgoAgd7
	 QT2HTLJWZ50aucHZW7hb7uiHRklBK9l2a4rhpW5zc3x4r1n0k2uW4swbe/wb/4nO/lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EsD5ejM6;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BEC606A692;
	Fri, 20 Nov 2026 23:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86BEC606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EsD5ejM6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795218761; x=1826754761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=orby79fs0BQOstqQjoXJpol75bZXbf3z8NkuG4vocGo=;
  b=EsD5ejM6/WMVUzhLDQCW0/bawpFMFNT6uL9lqDpWE0bbwliZpHyhlIiG
   Z3ZwHrXd634NZ4tJoYvrmEkaWjC1R4TUWpR/wLc/EkXKnJTKu2dYlpMAt
   5MT8XY82idpG/G38eR9tnw/JYoppRDZXnZRIpm0Qu6d77PP1Rvd8vtLxE
   xYSVZaR5cE+1Dctk6NqUjgDApofG4z85o17scvqmSm3RgfezOO3TOda6h
   2iqnak/XM4dZj+xeWMNAAUfUBnIfT9lyZQm8qmu40TjHG9xF+WtyjD5CS
   gmNZTPKnp3FoXiI9V5RwAztOv84RUpjwjtqDeZWzmOKaYVbZTiRjz9J7e
   g==;
X-CSE-ConnectionGUID: 0sW3TAaRRYO6r3lTRKls9A==
X-CSE-MsgGUID: bBPAcAY1QsCjUmviZiMqHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4021671"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4021671"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 15:52:40 -0800
X-CSE-ConnectionGUID: wOzMm06eQrqGoAPi4GjMXQ==
X-CSE-MsgGUID: 1Sfx10V3TKO8npMYYD5rEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10722794"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa004.jf.intel.com with ESMTP; 20 Nov 2026 15:52:35 -0800
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
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Chao Gao <chao.gao@intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Dave Hansen <dave.hansen@intel.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] x86/cea: Prefix exception stack names with ESTACK_
Date: Fri, 20 Nov 2026 15:50:24 -0800
Message-ID: <20261120235025.2809042-2-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261120235025.2809042-1-sohil.mehta@intel.com>
References: <20261120235025.2809042-1-sohil.mehta@intel.com>
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

From: "Xin Li (Intel)" <xin@zytor.com>

Add the ESTACK_ prefix to the exception stack names to improve clarity
and readability. Without the prefix, names like DF, NMI, and DB are too
brief and potentially ambiguous.

This renaming also prepares for reaching the stacks by their enum
exception_stack_ordering value instead of by name.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v1:
 - Say "exception stack" instead of "event stack" in the commit message.
 - Pick up Binbin's Reviewed-by.

FRED KVM v10:
 - https://lore.kernel.org/lkml/20260911213659.2025974-5-sohil.mehta@intel.com/
---
 arch/x86/coco/sev/noinstr.c           |  5 +++--
 arch/x86/coco/sev/vc-handle.c         |  3 ++-
 arch/x86/include/asm/cpu_entry_area.h | 26 +++++++++++++-------------
 arch/x86/kernel/cpu/common.c          | 10 +++++-----
 arch/x86/kernel/dumpstack_64.c        | 14 +++++++-------
 arch/x86/kernel/fred.c                |  6 +++---
 arch/x86/kernel/traps.c               |  2 +-
 arch/x86/mm/cpu_entry_area.c          | 12 ++++++------
 arch/x86/mm/fault.c                   |  2 +-
 9 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/arch/x86/coco/sev/noinstr.c b/arch/x86/coco/sev/noinstr.c
index e1e03f12fc7b..8ff556d28780 100644
--- a/arch/x86/coco/sev/noinstr.c
+++ b/arch/x86/coco/sev/noinstr.c
@@ -31,7 +31,8 @@ static __always_inline bool on_vc_stack(struct pt_regs *regs)
 	if (ip_within_syscall_gap(regs))
 		return false;
 
-	return ((sp >= __this_cpu_ist_bottom_va(VC)) && (sp < __this_cpu_ist_top_va(VC)));
+	return ((sp >= __this_cpu_ist_bottom_va(ESTACK_VC)) &&
+		(sp <  __this_cpu_ist_top_va(ESTACK_VC)));
 }
 
 /*
@@ -83,7 +84,7 @@ void noinstr __sev_es_ist_exit(void)
 	/* Read IST entry */
 	ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
 
-	if (WARN_ON(ist == __this_cpu_ist_top_va(VC)))
+	if (WARN_ON(ist == __this_cpu_ist_top_va(ESTACK_VC)))
 		return;
 
 	/* Read back old IST entry and write it to the TSS */
diff --git a/arch/x86/coco/sev/vc-handle.c b/arch/x86/coco/sev/vc-handle.c
index f25d302efceb..954df836ac65 100644
--- a/arch/x86/coco/sev/vc-handle.c
+++ b/arch/x86/coco/sev/vc-handle.c
@@ -854,7 +854,8 @@ static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
 
 static __always_inline bool is_vc2_stack(unsigned long sp)
 {
-	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
+	return (sp >= __this_cpu_ist_bottom_va(ESTACK_VC2) &&
+		sp <  __this_cpu_ist_top_va(ESTACK_VC2));
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
index 9bd50c68cd7e..5c24f32c0558 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2379,12 +2379,12 @@ static inline void setup_getcpu(int cpu)
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
index aa88370ce739..37f972913928 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -677,7 +677,7 @@ page_fault_oops(struct pt_regs *regs, unsigned long error_code,
 		 * and then double-fault, though, because we're likely to
 		 * break the console driver and lose most of the stack dump.
 		 */
-		call_on_stack(__this_cpu_ist_top_va(DF) - sizeof(void*),
+		call_on_stack(__this_cpu_ist_top_va(ESTACK_DF) - sizeof(void *),
 			      handle_stack_overflow,
 			      ASM_CALL_ARG3,
 			      , [arg1] "r" (regs), [arg2] "r" (address), [arg3] "r" (&info));
-- 
2.43.0

