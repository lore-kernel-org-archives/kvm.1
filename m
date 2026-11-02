Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793659806;
	b=JPlks5NwnRvwZp+DyWQDcp+VI0DxS2dhG5Ux/prT1Vg0IaT1Riy0/C/erCa3Dfmf4M9Q
	 EyY1C+0Mti8yGzzQX3WFdC5D4ASj3RVv0815sqS/fhN1CTszucfsLAEphYfP68iiY0P52
	 gTWn7ZagljbemPyI49iYqnSd6k6HtrIvoxGrycGrFz5jLsjZVL+mXYdP1SPG/bLZMaLrw
	 bIbMztzxIlDZoV0HFYE88sdN91oSrUX8QZtl+VTXSPdjE2Ei5qNSWJkJsf1ax6cHBAFGb
	 +FGI4y6wdhgjS+W3SQUFO3zp+ECbujI89EINSRFTszJxELJpNZyDwRghTS9aF6BuNQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793659806;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=k8tnUczw/adIvXenmAmW/YRcW7M+t2qZ1o++8tGqdck=;
	b=QudVb4NJ4aOt2GmyZZebrmgHbwPNHxyL92ZgWwg6/7NdCxQx03i+QhJJwgAT6kfje1Ec
	 zBga69f9qKXHK9sQmUleGDogfzV7xduRGwwrN8jVu7j50WEVy8liGLX6ZtfSSw7lm/czm
	 /G3+fBCdCxK/KjgyVy2YtcNFooisXJwZyKV3KDVsuYWaHLbhUQuAgRj9nebtIYJ/ensg6
	 c/mUghMZw2Lare8lgddV6SuRs+MQGMYQOTSNp4ebd3NwP9RfkETEE43IUAlTVNzpG/8zu
	 2U/lWDY43pX9mhOzRXec0jJSlyfIZoPTTXuSy3ibmipW69pHHFHzeFDHoy1w3mzyJlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YuA6Ic4F;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864F2606A329;
	Mon,  2 Nov 2026 22:50:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 864F2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YuA6Ic4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793659804; x=1825195804;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=IuuB5lfPeAjcN6a1wobZID6wlbBI012KoIJkmL4+8kU=;
  b=YuA6Ic4FXkBvqRBs3FZWS7LwG+hzGuWijS03up+GNCp9LeiMYLkahDqY
   K454LX9+4cdILIFT6ew+TM5TIPG+XqqGBq6uGGFi2S8TDDZ6SxmFZ5im4
   9DsbsWoPG2D+RIqN/jzHg9pF1AaypeM4VAVvWkTzmtMr++8sDOXOivjpb
   hShttRqVQbcKA2AWtjjiMD7fErYdX2KJ/gznmxc10l3td8OaAOyy1gFkx
   LXz2R0u4UKtSTTHQo9bWBC6YjzsfdIsM4DocAgL2G3LTFOw9Vkk3tL7zY
   aV/Q2H/bXSj3ga9oHN23GUpVxDs6B9D1yvYc2juvyzWdTDq6bRVe7PeKj
   Q==;
X-CSE-ConnectionGUID: VI2ORzRDS9aiPF7R80vywQ==
X-CSE-MsgGUID: dJGOle+9SAq1eVDXKPrtyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2399401"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2399401"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:50:03 -0800
X-CSE-ConnectionGUID: KhNAZ1+DR7yN/w2Q6XcYig==
X-CSE-MsgGUID: 59hy0lnZR1S+4GtfBtANQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="8030896"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.125.109.177])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:50:03 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Mon, 02 Nov 2026 15:49:35 -0700
Subject: [PATCH v2] x86/tdx: Remove the early #VE handler
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Post: <mailto:kvm@vger.kernel.org>
List-Help: <mailto:kvm+help@vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:kvm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-b4-tdx_remove_early_ve_handler-v2-1-71361d14f359@intel.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOQQ6DIBBFr2JYlwaQonXVezTGKAyVRqUBSjTGu
 xf1AN3NS17+mxV5cAY8qrIVOYjGGzslYJcMyb6dXoCNSowYYYKUrMQdx0HNjYPRRmigdcPSpCO
 5agCHC0m5yKUmWuQojXwcaDMfgWd9sv92b5BhX92N3vhg3XJ8EOnunbE7Jf9ikWKKO82LlqtcE
 Hl7mCnAcJV2RPW2bT9Pqma53gAAAA==
X-Change-ID: 20260828-b4-tdx_remove_early_ve_handler-7c1463cf0f63
To: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 Kiryl Shutsemau <kas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
 kvm@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>, 
 Nikolay Borisov <nik.borisov@suse.com>, Andi Kleen <ak@linux.intel.com>
X-Mailer: b4 0.17-dev-e5168
X-Developer-Signature: v=1; a=openpgp-sha256; l=3976;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=IuuB5lfPeAjcN6a1wobZID6wlbBI012KoIJkmL4+8kU=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDFkvhbulJrSHrWtSCYx/3JbJH/beK3lt/Tp7j/dsR81Uq
 ybscm7qKGFhEONikBVTZPm75yPjMbnt+TyBCY4wc1iZQIYwcHEKwER2PWP4Xxh9W3PBro7tX6NF
 q8/ozGL1/Lg/++OsvuzGab8UuVI4gxi+Zwd/qPGYd/Wy+bls9tmODO/e5OYn39tZ8XezisGnZdv
 ZAA==
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
early_fixup_exception().

Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
Changes in v2:
- Add review tags (Rick, Kiryl, Nikolay)
- Move LLM attribution below the ---
- Rebase to v7.4-rc1
- Link to v1: https://patch.msgid.link/20260910-b4-tdx_remove_early_ve_handler-v1-1-bf47a4d360c5@intel.com
---
Found with the help of an LLM observing that the real IDT is installed
before parse_early_param(). LLMs were also used to verify this. On a TDX
guest booted with earlyprintk, a counter added to tdx_early_handle_ve()
for testing remained 0 after boot.
---
 arch/x86/include/asm/tdx.h |  4 ----
 arch/x86/coco/tdx/tdx.c    | 22 ----------------------
 arch/x86/kernel/head64.c   |  3 ---
 3 files changed, 29 deletions(-)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 1fcfaed515fec..3f7a96b85beb0 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -76,8 +76,6 @@ bool tdx_handle_virt_exception(struct pt_regs *regs, struct ve_info *ve);
 
 void tdx_halt(void);
 
-bool tdx_early_handle_ve(struct pt_regs *regs);
-
 int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport);
 
 int tdx_mcall_extend_rtmr(u8 index, u8 *data);
@@ -94,8 +92,6 @@ void __init tdx_dump_td_ctls(u64 td_ctls);
 static inline void tdx_early_init(void) { };
 static inline void tdx_halt(void) { };
 
-static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return false; }
-
 #endif /* CONFIG_INTEL_TDX_GUEST */
 
 #if defined(CONFIG_KVM_GUEST) && defined(CONFIG_INTEL_TDX_GUEST)
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 8bacbef62891f..288142062991e 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -737,28 +737,6 @@ static int handle_io(struct pt_regs *regs, struct ve_info *ve)
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
index fd28b53dbac51..7b8b13f454545 100644
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
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260828-b4-tdx_remove_early_ve_handler-7c1463cf0f63

Best regards,
--  
Vishal Verma <vishal.l.verma@intel.com>

