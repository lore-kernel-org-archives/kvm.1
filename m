Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457888;
	b=YUTdzgEDyG0aOtnXxQBGeuh2h4CZp2V2qnyICsYe9dbAQC27AYte0vDugn9byakWSq3t
	 PsZ1Q8vM17F4luKrhYdvS9VOyQT5gxhsv0F2fWsV9Sg9N1l1QRcHMqH0IpMuV/YOXXPJw
	 ly5/EnldyoX2t1Fj69PY1r5XUFupK7VcvX3YvnSQI2k/dm7cOp+msA4wZANDfiY2LEoFr
	 g6txvUvHUOxq/PflXyw4xTAfpVQP68xQ79xpEgYl9n8r8HF+O/g4eG9IiXLXlP1obFiwe
	 yDoGdUuTLpWvMl3F5rj3Guu0kDpRGKd0wlnfcTvI6JAhH13QQ+WWhcxIZkkQMw5HVuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457888;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/D3jeXWjIZicrVcDLYoYO62YViuPL2W6b/yLM29yp5s=;
	b=y3ut4MYc47HxDcZ0sKJNqvBBaXDtJFxfX7XS3ihddDRczmt/Z+Nh75g39Ha6RvGKJeh/
	 T31XIWd9BBP+aCN3dkX7tbW+O1oLkGzfhnkHWQO8Kx46sDNuAj/9S+LMLsa0yPUtuEiTD
	 oBaVYea6uFSN8ZEJlK23p1CXsphC3KkQNcbCx2kDN8EUewOc3MME/m+mcZgOU5JpyYw9p
	 z7gHbRqH/iyI57LJgS7wRbJREOFG7KlUdTXsx359MrKp5yD6VggPcOgSadVD1P3whgvtH
	 aj9910VvXsYZ6TA0E0dZKHZ5t8zsksGG7LOBMgMzbQbBp2ePrywZTcA0BgbAfmC43Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G6N4akyS;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16018606A69C;
	Mon, 23 Nov 2026 18:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16018606A69C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G6N4akyS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457888; x=1826993888;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8UKh3ypT9l3AGaC1yTS4XxmNj/kYDB1MmgCPqo9Md2c=;
  b=G6N4akyS9ykLXiUEl4K31d0BUcAqijpr6HB4acK9W4jxOG56Ugiot3au
   wtfjZskeuEElMSFA/+G7i/TaQRESBgCV5O9YlN5dGgG+9m/9LqcGPPPXN
   CR92zaj0V8wPI0qwq9bFXciVobik+hM00gYg75685KgNeOaS60PbYMMqx
   cC0uPXNfWwFVYWwDIwTcpfL5adWMOS9a0KWbaZMLFPltKl4DBOIBExYo0
   fJPhRttinrGjV/vog5wf+pg1rMdlLz8i7NBDT8yS/VZkqh9XiQ/Ttfwig
   adcwBZq7Nr5n8sTj/k3nBGzp0LjflzGuyr0yHoyXNKTheAhDpb6Ma4BGW
   w==;
X-CSE-ConnectionGUID: RARJtS07RhGxGNmLtWW0+Q==
X-CSE-MsgGUID: 3WujMnLyTEGmbXcnD3EPGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288840"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288840"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:23 -0800
X-CSE-ConnectionGUID: FpvUmG0oSaa+EQFY//1CmA==
X-CSE-MsgGUID: UeeJvbxdTkqt3C3jEkxH3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241136"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:23 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 11/20] KVM: x86: Support EGPR accessing and tracking for emulator
Date: Mon, 23 Nov 2026 17:37:23 +0000
Message-ID: <20261123173732.1072124-12-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123173732.1072124-1-chang.seok.bae@intel.com>
References: <20261123173732.1072124-1-chang.seok.bae@intel.com>
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
adding support for REX2-prefixed instructions. Like vCPU cache, the
emulator can uniformly cache and track all GPRs.

Also replace `1 << reg` with `BIT(reg)` in reg_read()/reg_write(). The
former performs a signed 32-bit shift, which becomes undefined for R31.
BIT() instead shifts an unsigned value that is suitable for all indices.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
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

