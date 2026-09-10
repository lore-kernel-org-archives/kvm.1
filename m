Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2961772602;
	Thu, 10 Sep 2026 18:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064949; cv=none; b=knsu9VIsra9Zjsh1AYalTtdaUI2LLlGPkjZ9TWn0vjJ0YnNEVafGEm1gEGpaiq3PM+6W4vIe39g9pqpw1iYxNvUYNJJZ/r9XD/Xple8oxaE4KY0MTcqiZXzkcB3LR4/LTDAv/zKTfAwZ9CK3aK7uI/irV3frdHX62z87UJr65vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064949; c=relaxed/simple;
	bh=cmYjXvdsYciBd0lCZ2ltm/dpXQelBMN3JS54FvQBC4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pkQsBX56j7BhqvGFD5H4HybFbeONSqn23SaYtf/Yb5gpHKf1KMQntfEKbALviIFst9BVxLd2/pYCfZJuls8lh8vkPqp+bSlryNPSybggHAs8Cg0fdfbe8i70VIJvrwLXGxtnVOF0Q4Law/34RHPMxvoHjQf6XmH8XsONg/2PAjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NXvXgKs9; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NXvXgKs9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789064945; x=1820600945;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=cmYjXvdsYciBd0lCZ2ltm/dpXQelBMN3JS54FvQBC4s=;
  b=NXvXgKs9FoV0GkG0tV7mevwh7iWTPEJGYAT8oAK+Y6CxUgIIKMUMtb6e
   JNOhw5FZiyPxL8jwFqTun4Kh+GU7bBOHr7BKxDoO8zMNybpKOO4C+HiAX
   OVJVSGILL86OwmXpx8m023HcKxTc1Q3wucm8KsP0JZk/3hKOUVCUws1W/
   5MmzQtsyNW5krsMUgl00yq9Li3wWklN4Afnkhi0ETMkA0qOaxKjEpSaHl
   h3sKYNxe1lmOoyPsfw1XoVtFTXDNtXP3ENDV+t0FDw7uwd0EVWKXC3sUe
   SNnRXwJL3qjIlzOmbpHLOTQpE9yPNCNayohhIxjmNGKGvdXfeV+3TZnEw
   g==;
X-CSE-ConnectionGUID: 7nYHbbR9TLS8TNnyMvMWWw==
X-CSE-MsgGUID: 5kPQSpn5R2OCWYFbfUwcrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100118692"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="100118692"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 11:28:57 -0700
X-CSE-ConnectionGUID: 4y2rpa5DRmaalaZAHZWkcA==
X-CSE-MsgGUID: 2lUi3idNRgOaMgZ/izzXoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="265511323"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.111.227])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 11:28:57 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Thu, 10 Sep 2026 12:28:40 -0600
Subject: [PATCH] x86/tdx: Remove the early #VE handler
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNUQqDMBAFryL73UCMkkqvUkrQ5KVNsVo2Vizi3
 V3bvzfwmFkpgxMyXYqVGHPKaRwEylNB/tEOd6gUhMloY3VjGtXVagqLY7zGGQ4t918nQ76hB6u
 zL2tb+aijrUgkb0ZMyy9wvf05f7on/HRYadt2bNswd4IAAAA=
X-Change-ID: 20260828-b4-tdx_remove_early_ve_handler-7c1463cf0f63
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>, 
 Andi Kleen <ak@linux.intel.com>
X-Mailer: b4 0.16-dev-62088
X-Developer-Signature: v=1; a=openpgp-sha256; l=3634;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=cmYjXvdsYciBd0lCZ2ltm/dpXQelBMN3JS54FvQBC4s=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFmLvr1omWodErDFZtrfyZPX8Be+Z6q7lCtZwmGZ6J51/
 JnmV5f6jlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAEykKZWRYU6JE3OoT0Dd0w15
 QQFR0ktzVwtv/PbJame8YsvbOS+jexj+WSzwenkpoe/pFJvL1+IW/1+zze73Hce9KnxnrnnfMns
 cyAEA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

tdx_early_handle_ve() emulates port I/O for #VEs taken before
idt_setup_early_traps() installs the real #VE gate. Per commit
32e72854fa5f ("x86/tdx: Port I/O: Add early boot support"), it exists to
support earlyprintk's serial driver.

"earlyprintk=" and "earlycon=" are both early_param() handlers, so no
console can be registered before parse_early_param(), which runs from
setup_arch(), after idt_setup_early_traps() has replaced the early IDT.
Nothing in the window between idt_setup_early_handler() and
idt_setup_early_traps() does port I/O, so this emulation doesn't ever
get called.

Remove the handler. Any #VE in the early window now falls through to
early_fixup_exception(), as it previously did for #VEs that were not I/O
instructions.

Found with the help of an LLM observing that the real IDT is installed
before parse_early_param(). LLMs were also used to verify this. On a TDX
guest booted with earlyprintk, a counter added to tdx_early_handle_ve()
for testing remained 0 after boot.

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/tdx.h |  4 ----
 arch/x86/coco/tdx/tdx.c    | 22 ----------------------
 arch/x86/kernel/head64.c   |  3 ---
 3 files changed, 29 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 89e97d5761d8..495154a7d77d 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -75,8 +75,6 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
 void tdx_halt(void);
 
-bool tdx_early_handle_ve(struct pt_regs *regs);
-
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
 int tdx_mcall_extend_rtmr(u8 index, u8 *data);
@@ -91,8 +89,6 @@ void __init tdx_dump_td_ctls(u64 td_ctls);
 static inline void tdx_early_init(void) { };
 static inline void tdx_halt(void) { };
 
-static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
-
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f904a636d449..9bc78cb28710 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -755,28 +755,6 @@ static int handle_io(struct pt_regs *regs, struct ve_info *ve)
 	return ve_instr_len(ve);
 }
 
-/*
- * Early #VE exception handler. Only handles a subset of port I/O.
- * Intended only for earlyprintk. If failed, return false.
- */
-__init bool tdx_early_handle_ve(struct pt_regs *regs)
-{
-	struct ve_info ve;
-	int insn_len;
-
-	tdx_get_ve_info(&ve);
-
-	if (ve.exit_reason != EXIT_REASON_IO_INSTRUCTION)
-		return false;
-
-	insn_len = handle_io(regs, &ve);
-	if (insn_len < 0)
-		return false;
-
-	regs->ip += insn_len;
-	return true;
-}
-
 void tdx_get_ve_info(struct ve_info *ve)
 {
 	struct tdx_module_args args = {};
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index fd28b53dbac5..7b8b13f45454 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -166,9 +166,6 @@ void __init do_early_exception(struct pt_regs *regs, int trapnr)
 	    trapnr == X86_TRAP_VC && handle_vc_boot_ghcb(regs))
 		return;
 
-	if (trapnr == X86_TRAP_VE && tdx_early_handle_ve(regs))
-		return;
-
 	early_fixup_exception(regs, trapnr);
 }
 

---
base-commit: df2908090cda368b01ff43709f51890076c56157
change-id: 20260828-b4-tdx_remove_early_ve_handler-7c1463cf0f63

Best regards,
--  
Vishal Verma <vishal.l.verma@intel.com>

