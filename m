Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940333;
	b=Wt9UmmSz6gRmeuXOXE8yvL8KZ7JLrzDtZVpSs4SHCqeBzs6dmZwGRsQUI69wvgbMO+l9
	 DbAv9x9rNU7tFsYtgqcD2QTD2jwjb5OHKETfg3aKeiC8JzBR6BlHThkxlMpU21B3gCslD
	 37S/9mslKwvg2aNyW9tZlDTcG6SKjHgVjT4qMqm4BmDUhDGlbbzQJ3fI7zBJSgWckIfmI
	 gkK92Pl7YkUy/XJY0PmtEbiv/hR8wukwOMRqpKbly0xev1cIeymBjdW3Tls05HDtk2UVh
	 YuHLxeSbv0BONuEtwBI4lIxpOKjVZ/EOfWvGTCbnGOZnbjLbvtZH+fvB0xnjRZsEOjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940333;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ib/Dca1Ao5cQ+ZzvLRS7nCxtfQXod6ecGM6Wuyt4ZD0=;
	b=FOsZOBmrDrdKeolZrqoOnOersN9Qi3iMhEAMJ2wQCrhgyYBjz+fqXmLozovsYfz7cWwI
	 QDC+c7+HP3R2GrzFn2MM+tq6saU8lT98I+cf0DXqMXtoGN+T4VwRgvh9pTJzPOuY+XXI4
	 xo/3Tf60O2S/0h/2FG5znhDGKYXC1djfzEVCVoWJLmSUwFvCpqXJNaZ8bMff0Nhp/jlDB
	 6jEyemDYwiI9T/shSg5FFqOT3Wd/8DcHap396RJCnS32/3H/VzEFJus0A3DAeX4TKr7un
	 KFQoJqBtEnwwB1kDeA4sd5wyFbdCxgqtqe5bxuAXXKFuceAikUB9y/FXDM349+l298w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DdeHID47;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB4606A8A5;
	Tue, 17 Nov 2026 18:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFEB4606A8A5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DdeHID47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940333; x=1826476333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LdTplT7BiYD4oTjCQifHUzds6u3fh0CLodbjtaTz+40=;
  b=DdeHID47CeMXglbrxbX2vYxrsFnJgCpR1iwmGXxGGHxP2adQBLDjJt61
   m+6eFvVFKxzEiqm6R2ihyock47VsvrUsSYymzc+w3GkMU30pU03bpWZSm
   HUoTRt9JUtYcF3OHmgbbEKEXGPtdCExRK47SoWYO1Pxw9M7QMNSzW1AmZ
   UdiDXqHsr978qHAVb7MvwLXMt3o2caI9/QICKgrQEtNS0SMyrjhVhXs1E
   47Qxyh61kHhm/76qejzakMHoy93qTiRxQCRcHG3J5NRrr/SYFdWzPJhlA
   WbAdmhSG5ImYHwktJnfSxl6llBr7hLQKz1lMLMpcpS8t/fNWmYj38Heg+
   Q==;
X-CSE-ConnectionGUID: E/WxUD3JR6idTSi3LI3LJw==
X-CSE-MsgGUID: nXogrM2MT1OaZzbjc9rnrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607315"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607315"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:55 -0800
X-CSE-ConnectionGUID: WD4Ry2SIRDmICW75e7/NbA==
X-CSE-MsgGUID: CEryC7qnRuqCPWUwCdTjsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775061"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:56 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 11/20] KVM: x86: Support EGPR accessing and tracking for emulator
Date: Tue, 17 Nov 2026 18:03:01 +0000
Message-ID: <20261117180310.921701-12-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117180310.921701-1-chang.seok.bae@intel.com>
References: <20261117180310.921701-1-chang.seok.bae@intel.com>
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

Extend the emulator context and GPR accessors to handle EGPRs before
adding support for REX2-prefixed instructions. Like VCPU cache, the
emulator can uniformly cache and track all GPRs.

Also replace `1 << reg` with `BIT(reg)` in reg_read()/reg_write(). The
former performs a signed 32-bit shift, which becomes undefined for R31.
BIT() instead shifts an unsigned value that is suitable for all indices.

Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/kvm_emulate.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 10886bea82c9..52f0aaa38c4c 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -109,13 +109,13 @@ struct x86_instruction_info {
 struct x86_emulate_ops {
 	void (*vm_bugged)(struct x86_emulate_ctxt *ctxt);
 	/*
-	 * read_gpr: read a general purpose register (rax - r15)
+	 * read_gpr: read a general purpose register (rax - r31)
 	 *
 	 * @reg: gpr number.
 	 */
 	ulong (*read_gpr)(struct x86_emulate_ctxt *ctxt, unsigned reg);
 	/*
-	 * write_gpr: write a general purpose register (rax - r15)
+	 * write_gpr: write a general purpose register (rax - r31)
 	 *
 	 * @reg: gpr number.
 	 * @val: value to write.
@@ -321,7 +321,9 @@ typedef void (*fastop_t)(struct fastop *);
  * also uses _eip, RIP cannot be a register operand nor can it be an operand in
  * a ModRM or SIB byte.
  */
-#ifdef CONFIG_X86_64
+#if defined(CONFIG_KVM_APX)
+#define NR_EMULATOR_GPRS	32
+#elif defined(CONFIG_X86_64)
 #define NR_EMULATOR_GPRS	16
 #else
 #define NR_EMULATOR_GPRS	8
@@ -381,9 +383,9 @@ struct x86_emulate_ctxt {
 	u8 lock_prefix;
 	u8 rep_prefix;
 	/* bitmaps of registers in _regs[] that can be read */
-	u16 regs_valid;
+	u32 regs_valid;
 	/* bitmaps of registers in _regs[] that have been written */
-	u16 regs_dirty;
+	u32 regs_dirty;
 	/* modrm */
 	u8 modrm;
 	u8 modrm_mod;
@@ -547,8 +549,8 @@ static inline ulong reg_read(struct x86_emulate_ctxt *ctxt, unsigned nr)
 	if (KVM_EMULATOR_BUG_ON(nr >= NR_EMULATOR_GPRS, ctxt))
 		nr &= NR_EMULATOR_GPRS - 1;
 
-	if (!(ctxt->regs_valid & (1 << nr))) {
-		ctxt->regs_valid |= 1 << nr;
+	if (!(ctxt->regs_valid & BIT(nr))) {
+		ctxt->regs_valid |= BIT(nr);
 		ctxt->_regs[nr] = ctxt->ops->read_gpr(ctxt, nr);
 	}
 	return ctxt->_regs[nr];
@@ -562,8 +564,8 @@ static inline ulong *reg_write(struct x86_emulate_ctxt *ctxt, unsigned nr)
 	BUILD_BUG_ON(sizeof(ctxt->regs_dirty) * BITS_PER_BYTE < NR_EMULATOR_GPRS);
 	BUILD_BUG_ON(sizeof(ctxt->regs_valid) * BITS_PER_BYTE < NR_EMULATOR_GPRS);
 
-	ctxt->regs_valid |= 1 << nr;
-	ctxt->regs_dirty |= 1 << nr;
+	ctxt->regs_valid |= BIT(nr);
+	ctxt->regs_dirty |= BIT(nr);
 	return &ctxt->_regs[nr];
 }
 
-- 
2.53.0

