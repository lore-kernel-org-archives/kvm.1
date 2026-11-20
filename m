Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795218765;
	b=4M+O+DeyiCAIPKz9rxmojwsM1NTLoWi6oQkg41HBl/ADEWjZ6LWO7SJgocxC4YNajcIQ
	 JyUnQzub8XTNDX3bEEUsgTFGR2IHqfCAKCOB7X/dqXSQeWlI1w2+n3oxSLj9J/KYBzwEJ
	 FkYSH/zWjcTISYd9GNet86Wk4cw9f8H0rM9TEWmVLVHSxs+T5F4xKdgtoqVPhvx+MiA8p
	 osKtLoxlF9xZGO4GupX+rpaCRa0outeBZBW2ekdeUESET17tuYkBcjFL+mHkXDcf3Pe1j
	 2ybNT1svRRj8ZLXBycCwCQoulD9mKoOP8hLASNgCtj5bxWdm1cJBkZaYB8CDCxwVHEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795218765;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LLMdJFLAE+ptjTBYHy7d4fLgKcOjRF5JTIAJIDJw6Qk=;
	b=OPC6fK88D8EQFt9ShM1ze7YMSMFhQ/28WkM98XI56ptDHC8SLNE9eeDeGqBMMIrfxxRV
	 tV446Jjupo3vtaQR+8mQPcvJH5dyStL4VxtAx91Vrid7vc0rX5EqS6uNeCjDPdNYJXxLy
	 z8SbiVwmhHzuzkZ35OSb5hEp1CAmc0PNN9pA8fYoh/AiJd0qy2LF3yWjNnXAqzsNmuvgu
	 61RinJ45b8sBybzf0MRl+3r4LrSVMP0FNm8oQJTj9B5kTFzU2ZB9uGWMBViNNRBF0Y/Ul
	 2O5Kpci0wZahzM7a9a8xAM1bL6a3mzMqDYRqCWJeGICkkk/EJ/UxIin7rbbibvK1LMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TBv8rdAr;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A639606A6AF;
	Fri, 20 Nov 2026 23:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A639606A6AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TBv8rdAr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795218761; x=1826754761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1hmp9l/Q2jS845EOwA9ckELSd7nnOCKxnTFheI5+1hM=;
  b=TBv8rdArAxLFYZSsp01Pn1denqFeMHjTbCkT4S976FtJTWQNh8SXN5j2
   IteUUspqAbJeaJpCking9u77VPCiSAZbfb6csyygqjkZJaFcb6cAj8og3
   VGTYBhWAyfGEMpmQrMRb2xoiPuPnFOAAYtC1Iwhx5Mxw0wZ8FZNeWFR8m
   VmYBpI376AbG11o8b6Wd0NBNlbDOVM6aXdj0/dcrWXXdulwZdODM4T2b+
   zT+IFlI02ioQhvg33+9uM6onCrIO14edHVrW6OCjahW7Pg32sFcpzfUc8
   g90bRmmHm2e7qUSK+7XK8F45vXvK+zZTm7xWnjihbodVpEHDHmye9w/eP
   A==;
X-CSE-ConnectionGUID: UAlAxuHGT1SDgeRtRjPwgg==
X-CSE-MsgGUID: RP5T2erNQAKX6Pyu8t7zfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4021661"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4021661"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 15:52:37 -0800
X-CSE-ConnectionGUID: asEJAIbEQsOYPifGmgFk6Q==
X-CSE-MsgGUID: /gf9WzicTzCr0c0O3/OzwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10722798"
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
Subject: [PATCH 2/2] x86/cea: Index exception stacks by the ordering enum
Date: Fri, 20 Nov 2026 15:50:25 -0800
Message-ID: <20261120235025.2809042-3-sohil.mehta@intel.com>
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

The exception stacks are generated by ESTACKS_MEMBERS(), which pastes
each stack name into a member name, once for the physical storage and
once for the CEA mapping.

The macro used to be the only thing keeping the two structures in the
same order, but there is no ordering requirement left to enforce. The
stacks are mapped one at a time and have been paired by name for a
while. Also, the sizes stopped matching once the #VC stacks became
config dependent.

So, spell out the physical storage and index the mapping by the stack
ordering enum. Also drop CEA_ESTACK_SIZE, which just duplicated
EXCEPTION_STKSZ.

The stack addresses and the guard pages are unchanged. No functional
change intended.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
---
v1:
 - Drop the conversion of __this_cpu_ist_{bottom,top}_va() from macros
   to functions. KVM does not need the accessor exported any more.
 - Expand struct exception_stacks explicitly and drop ESTACKS_MEMBERS()
   altogether.
 - Name the new array stacks[] rather than event_stacks[].
 - Switch authorship due to significant changes to Xin's original patch.
 - Drop Binbin's and Dave's tags.

FRED KVM v10:
 - https://lore.kernel.org/lkml/20260911213659.2025974-6-sohil.mehta@intel.com/
---
 arch/x86/include/asm/cpu_entry_area.h | 52 +++++++++++----------------
 arch/x86/kernel/dumpstack_64.c        |  4 +--
 arch/x86/mm/cpu_entry_area.c          |  2 +-
 3 files changed, 24 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/cpu_entry_area.h b/arch/x86/include/asm/cpu_entry_area.h
index d0f884c28178..ba6456a04180 100644
--- a/arch/x86/include/asm/cpu_entry_area.h
+++ b/arch/x86/include/asm/cpu_entry_area.h
@@ -16,32 +16,6 @@
 #define VC_EXCEPTION_STKSZ	0
 #endif
 
-/* Macro to enforce the same ordering and stack sizes */
-#define ESTACKS_MEMBERS(guardsize, optional_stack_size)		\
-	char	ESTACK_DF_stack_guard[guardsize];		\
-	char	ESTACK_DF_stack[EXCEPTION_STKSZ];		\
-	char	ESTACK_NMI_stack_guard[guardsize];		\
-	char	ESTACK_NMI_stack[EXCEPTION_STKSZ];		\
-	char	ESTACK_DB_stack_guard[guardsize];		\
-	char	ESTACK_DB_stack[EXCEPTION_STKSZ];		\
-	char	ESTACK_MCE_stack_guard[guardsize];		\
-	char	ESTACK_MCE_stack[EXCEPTION_STKSZ];		\
-	char	ESTACK_VC_stack_guard[guardsize];		\
-	char	ESTACK_VC_stack[optional_stack_size];		\
-	char	ESTACK_VC2_stack_guard[guardsize];		\
-	char	ESTACK_VC2_stack[optional_stack_size];		\
-	char	ESTACK_IST_top_guard[guardsize];		\
-
-/* The exception stacks' physical storage. No guard pages required */
-struct exception_stacks {
-	ESTACKS_MEMBERS(0, VC_EXCEPTION_STKSZ)
-};
-
-/* The effective cpu entry area mapping with guard pages. */
-struct cea_exception_stacks {
-	ESTACKS_MEMBERS(PAGE_SIZE, EXCEPTION_STKSZ)
-};
-
 /*
  * The exception stack ordering in [cea_]exception_stacks
  */
@@ -55,17 +29,33 @@ enum exception_stack_ordering {
 	N_EXCEPTION_STACKS
 };
 
-#define CEA_ESTACK_SIZE(st)					\
-	sizeof(((struct cea_exception_stacks *)0)->st## _stack)
+/* The exception stacks' physical storage. No guard pages required */
+struct exception_stacks {
+	char ESTACK_DF_stack[EXCEPTION_STKSZ];
+	char ESTACK_NMI_stack[EXCEPTION_STKSZ];
+	char ESTACK_DB_stack[EXCEPTION_STKSZ];
+	char ESTACK_MCE_stack[EXCEPTION_STKSZ];
+	char ESTACK_VC_stack[VC_EXCEPTION_STKSZ];
+	char ESTACK_VC2_stack[VC_EXCEPTION_STKSZ];
+};
+
+/* The effective cpu entry area mapping with guard pages. */
+struct cea_exception_stacks {
+	struct {
+		char stack_guard[PAGE_SIZE];
+		char stack[EXCEPTION_STKSZ];
+	} stacks[N_EXCEPTION_STACKS];
+	char IST_top_guard[PAGE_SIZE];
+};
 
 #define CEA_ESTACK_BOT(ceastp, st)				\
-	((unsigned long)&(ceastp)->st## _stack)
+	((unsigned long)&(ceastp)->stacks[st].stack)
 
 #define CEA_ESTACK_TOP(ceastp, st)				\
-	(CEA_ESTACK_BOT(ceastp, st) + CEA_ESTACK_SIZE(st))
+	(CEA_ESTACK_BOT(ceastp, st) + EXCEPTION_STKSZ)
 
 #define CEA_ESTACK_OFFS(st)					\
-	offsetof(struct cea_exception_stacks, st## _stack)
+	offsetof(struct cea_exception_stacks, stacks[st].stack)
 
 #define CEA_ESTACK_PAGES					\
 	(sizeof(struct cea_exception_stacks) / PAGE_SIZE)
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
index 9fa371af8abc..570e60fde79c 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -132,7 +132,7 @@ static void __init percpu_setup_debug_store(unsigned int cpu)
 
 #define cea_map_stack(name) do {					\
 	npages = sizeof(estacks->name## _stack) / PAGE_SIZE;		\
-	cea_map_percpu_pages(cea->estacks.name## _stack,		\
+	cea_map_percpu_pages(cea->estacks.stacks[name].stack,		\
 			estacks->name## _stack, npages, PAGE_KERNEL);	\
 	} while (0)
 
-- 
2.43.0

