Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD5F486431;
	Fri, 11 Sep 2026 21:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162837; cv=none; b=RP9DsMLsXD1A3FWCubxFpGvFr2j5vrsQSJsBD6IrevgZ3ts4vR7pgox1Lj5hSjba5edNTPclh1moeOrmpCB+yjG/wFPeaxqOZQjFvC6eJl1V7pd+uPnF3XwjbUKj3BMFdGR0k8BRL65snlSAvWJcdEBWZGNubVH3S8ElZwqFmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162837; c=relaxed/simple;
	bh=GrFbnV7U/VzUxcfB10Sq6sd5UMQx0UKgx6eLIPtlYPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxJ/wY6BBhr8smBENXV72axkbPOyyeL0IW4V4e654lPR/xmjEyeEIqWJG/Ld6ukVd9ytjrudlXA3ANXg8VpRWxGyHvS3M0P6tIfpJjt2ZwNsZd8vCVLbRnJRfgRJ2imhJUpNX2RXblqM8vmJuT++czwKUbOqA9BNdqn7xg/UVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HXxXXw9X; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HXxXXw9X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789162835; x=1820698835;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GrFbnV7U/VzUxcfB10Sq6sd5UMQx0UKgx6eLIPtlYPU=;
  b=HXxXXw9Xs/ZVkH/Brcu2n3BwiIJ2cwpYA6wqdFMlgM31+FYAUdNfgsqe
   +Ox8rRdcBLTsFqz7wmGdvHt+d7uPD3cV2Djvy6ePm90RakK+UZqXNb4Ar
   92prs7Tr03trn8lMV+U/oxAbP5llMMqonlTecaP2gKDdVB/LBs8j+nj+i
   7EPev6d9OOnXyDsezZ9TOF5+Stigeawg7ula68uo5Aw+99HGYtl9/v+Ot
   EjahTm3CfUB6eyw3SVpljBMr78quGbzPT77AZTuo7vWwHcqMcsN2YVr7p
   wySC8Y6mtnJlxPhCSGqLg7yT+tSrIpLQpmZ9AEGUe/2npLi6WnS56ZvbO
   Q==;
X-CSE-ConnectionGUID: mrIUKlG8TW6TwVkzOSPNyQ==
X-CSE-MsgGUID: uMZdbgSCSOKDlzVum+Gclg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="88572468"
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="88572468"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 14:40:34 -0700
X-CSE-ConnectionGUID: e718XIOpSsu3rVM5kUdI0g==
X-CSE-MsgGUID: wmeAbYCiSgCsu98P0SiNnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,98,1787036400"; 
   d="scan'208";a="272003989"
Received: from sohilmeh.sc.intel.com ([172.25.103.65])
  by orviesa007.jf.intel.com with ESMTP; 11 Sep 2026 14:40:33 -0700
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
Subject: [PATCH v10 05/28] x86/cea: Use array indexing to simplify exception stack access
Date: Fri, 11 Sep 2026 14:36:35 -0700
Message-ID: <20260911213659.2025974-6-sohil.mehta@intel.com>
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

Refactor struct cea_exception_stacks to leverage array indexing for
exception stack access, improving code clarity and eliminating the
need for the ESTACKS_MEMBERS() macro.

Convert __this_cpu_ist_{bottom,top}_va() from macros to functions,
allowing removal of the now-obsolete CEA_ESTACK_BOT and CEA_ESTACK_TOP
macros.

Also drop CEA_ESTACK_SIZE, which just duplicated EXCEPTION_STKSZ.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
---
v10:
 - Check if the stack argument is within the array bounds of
   event_stacks (Boris).

v9:
 - Refactor first and then export in a separate patch (Dave Hansen).
---
 arch/x86/include/asm/cpu_entry_area.h | 52 ++++++++++++---------------
 arch/x86/kernel/dumpstack_64.c        |  4 +--
 arch/x86/mm/cpu_entry_area.c          | 22 +++++++++++-
 3 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index d0f884c28178..509e52fc3a0f 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -16,6 +16,19 @@
 #define VC_EXCEPTION_STKSZ	0
 #endif
 
+/*
+ * The exception stack ordering in [cea_]exception_stacks
+ */
+enum exception_stack_ordering {
+	ESTACK_DF,
+	ESTACK_NMI,
+	ESTACK_DB,
+	ESTACK_MCE,
+	ESTACK_VC,
+	ESTACK_VC2,
+	N_EXCEPTION_STACKS
+};
+
 /* Macro to enforce the same ordering and stack sizes */
 #define ESTACKS_MEMBERS(guardsize, optional_stack_size)		\
 	char	ESTACK_DF_stack_guard[guardsize];		\
@@ -39,37 +52,22 @@ struct exception_stacks {
 
 /* The effective cpu entry area mapping with guard pages. */
 struct cea_exception_stacks {
-	ESTACKS_MEMBERS(PAGE_SIZE, EXCEPTION_STKSZ)
+	struct {
+		char stack_guard[PAGE_SIZE];
+		char stack[EXCEPTION_STKSZ];
+	} event_stacks[N_EXCEPTION_STACKS];
+	char IST_top_guard[PAGE_SIZE];
 };
 
-/*
- * The exception stack ordering in [cea_]exception_stacks
- */
-enum exception_stack_ordering {
-	ESTACK_DF,
-	ESTACK_NMI,
-	ESTACK_DB,
-	ESTACK_MCE,
-	ESTACK_VC,
-	ESTACK_VC2,
-	N_EXCEPTION_STACKS
-};
-
-#define CEA_ESTACK_SIZE(st)					\
-	sizeof(((struct cea_exception_stacks *)0)->st## _stack)
-
-#define CEA_ESTACK_BOT(ceastp, st)				\
-	((unsigned long)&(ceastp)->st## _stack)
-
-#define CEA_ESTACK_TOP(ceastp, st)				\
-	(CEA_ESTACK_BOT(ceastp, st) + CEA_ESTACK_SIZE(st))
-
 #define CEA_ESTACK_OFFS(st)					\
-	offsetof(struct cea_exception_stacks, st## _stack)
+	offsetof(struct cea_exception_stacks, event_stacks[st].stack)
 
 #define CEA_ESTACK_PAGES					\
 	(sizeof(struct cea_exception_stacks) / PAGE_SIZE)
 
+extern unsigned long __this_cpu_ist_top_va(enum exception_stack_ordering stack);
+extern unsigned long __this_cpu_ist_bottom_va(enum exception_stack_ordering stack);
+
 #endif
 
 #ifdef CONFIG_X86_32
@@ -144,10 +142,4 @@ static __always_inline struct entry_stack *cpu_entry_stack(int cpu)
 	return &get_cpu_entry_area(cpu)->entry_stack_page.stack;
 }
 
-#define __this_cpu_ist_top_va(name)					\
-	CEA_ESTACK_TOP(__this_cpu_read(cea_exception_stacks), name)
-
-#define __this_cpu_ist_bottom_va(name)					\
-	CEA_ESTACK_BOT(__this_cpu_read(cea_exception_stacks), name)
-
 #endif
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 40f51e278171..93b10b264e53 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -70,9 +70,9 @@ struct estack_pages {
 
 #define EPAGERANGE(st)							\
 	[PFN_DOWN(CEA_ESTACK_OFFS(st)) ...				\
-	 PFN_DOWN(CEA_ESTACK_OFFS(st) + CEA_ESTACK_SIZE(st) - 1)] = {	\
+	 PFN_DOWN(CEA_ESTACK_OFFS(st) + EXCEPTION_STKSZ - 1)] = {	\
 		.offs	= CEA_ESTACK_OFFS(st),				\
-		.size	= CEA_ESTACK_SIZE(st),				\
+		.size	= EXCEPTION_STKSZ,				\
 		.type	= STACK_TYPE_EXCEPTION + st, }
 
 /*
diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 9fa371af8abc..a47dfd686bd3 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -18,6 +18,26 @@ static DEFINE_PER_CPU_PAGE_ALIGNED(struct entry_stack_page, entry_stack_storage)
 static DEFINE_PER_CPU_PAGE_ALIGNED(struct exception_stacks, exception_stacks);
 DEFINE_PER_CPU(struct cea_exception_stacks*, cea_exception_stacks);
 
+/*
+ * Typically invoked by entry code, so must be noinstr.
+ */
+noinstr unsigned long __this_cpu_ist_bottom_va(enum exception_stack_ordering stack)
+{
+	struct cea_exception_stacks *s;
+
+	BUILD_BUG_ON(ESTACK_DF != 0);
+	BUG_ON(stack >= N_EXCEPTION_STACKS);
+
+	s = __this_cpu_read(cea_exception_stacks);
+
+	return (unsigned long)&s->event_stacks[stack].stack;
+}
+
+noinstr unsigned long __this_cpu_ist_top_va(enum exception_stack_ordering stack)
+{
+	return __this_cpu_ist_bottom_va(stack) + EXCEPTION_STKSZ;
+}
+
 static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, _cea_offset);
 
 static __always_inline unsigned int cea_offset(unsigned int cpu)
@@ -132,7 +152,7 @@ static void __init percpu_setup_debug_store(unsigned int cpu)
 
 #define cea_map_stack(name) do {					\
 	npages = sizeof(estacks->name## _stack) / PAGE_SIZE;		\
-	cea_map_percpu_pages(cea->estacks.name## _stack,		\
+	cea_map_percpu_pages(cea->estacks.event_stacks[name].stack,	\
 			estacks->name## _stack, npages, PAGE_KERNEL);	\
 	} while (0)
 
-- 
2.43.0

