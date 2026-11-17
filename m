Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794940336;
	b=z3XxoriTdxTSIO+5KHG1gBVfmdmaQKkBd78yw5SwP+iZngJcna08i5/7ThCdpLLFvcWE
	 Z0dlCEt8prVZ8MKN1dqy2YklMqAS6wtj7WRa2MdBSgkS4KwHu1cnu0QM05ksk/HZhGV93
	 9cKv0rg0ycJbV4O9KwyDR1414UOewWo1atPEjJBdxYt0ojAJAZfn9PhhuM+RtMXOKj5YD
	 H2EF8Nh/bEVAGWOZWhMkuRAhztXXmIT62dCFx+cjL+fffkSw4MYMe1P0p9GFDOuho3n3j
	 K3VWKSKpEXbXLMoA/xBEhcmQDuVZkOnsywgWc0la8qgbJfFspubmXdrhtOnYCWCaJWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794940336;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AmWnntXHNz7/XwqTQF5VLOfxjqQhDFQP4IrbNbkNHQY=;
	b=brTIdu1sROwKv7Ws+dNabwgwXPDJyMA9FZPuqzILe+ZtvUoua7BM+fFR613pVxbT0wTX
	 CFvGzcFyXdw2NxSfTD8TjIdCm7/I7vZdLSqvAG4JAdE7u1V+SDS+sUP/KKL9A7ZLK/QHx
	 zV+ruypuVrWsyHzZOfI2jZF/z9miufxeov9tRU93g3Y3dWlXxdgJ/HNlSoPoLNxtbnH2V
	 yOYRJZulohTbnTk6IhxvFJ53CmkDx7FQylAlCcJ3gKxMjjCq0gDigz0buwke9bCC+BSL8
	 pTC/mPMVfMQnxPWdCdTzK0tOeuIQ4abmXjD+MwOstv8/INv5o3Iu3mNE6XK2IK0pR3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e3TxLS59;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF5E60A6F7A;
	Tue, 17 Nov 2026 18:32:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AF5E60A6F7A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e3TxLS59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794940335; x=1826476335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=awekmLGVjYFxtNNDrAF+D1zQ71K8KCBsfUe0Ftktn1o=;
  b=e3TxLS59/Pz/Hk2UqIWgFWJ7u7yrNv6J5d4ymywm3+w5odtZ/x8AKBcV
   0Ie90TfOO6WdlDsEgJck7mtfI2Z9OZp+LC8dsnFN+m/XX8OxRnCUK525m
   wU3N51fHtJYSdPa8vFHWie5K7VAz8EX+tiTea2OVgyr1OHQ664UBSy0dB
   /jORe2RBHBe6fS12IyLqac0s13Fisk2qiKkW4XXN3YOw23fGw4hR1HOwo
   +2nl11egejIMyBtOTTpshD9+Yc8xGJBKiMqn02X/7ZfT8XtfZSZZNKcae
   rni6KHHBaxjME+g3gVfVcp0OmgeKgZfwuIEppFoUbSEYiLFxd6KG8odAT
   w==;
X-CSE-ConnectionGUID: JuKVitjiQrywvrvcat1BBg==
X-CSE-MsgGUID: PBI9EmYhTDijvpGrgYe3ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3607334"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3607334"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:30:58 -0800
X-CSE-ConnectionGUID: WUtvAYIgR1i8CFs4xHSvrg==
X-CSE-MsgGUID: Y8QbaLqyTF2lcZIldQ7+gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9775071"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa003.jf.intel.com with ESMTP; 17 Nov 2026 10:30:58 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v9 13/20] KVM: x86: Support REX2-prefixed opcode decode
Date: Tue, 17 Nov 2026 18:03:03 +0000
Message-ID: <20261117180310.921701-14-chang.seok.bae@intel.com>
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

Extend the instruction decoder to recognize and handle the REX2 prefix,
including validation of prefix sequences and correct opcode table
selection. Prepare the UD opcode flag explicitly with Undefined, instead
of zeroing.

REX2 is a terminal prefix: once 0xD5 is encountered, the following byte
is the opcode. When REX2.M=0, most prefix bytes are invalid after REX2,
including REX, VEX, EVEX, and another REX2. Also, REX2-prefixed
instructions are only valid in 64-bit mode.

All of the invalid prefix combinations after REX2 coincide with opcodes
that are architecturally invalid in 64-bit mode. Thus, marking such
opcodes with No64 in opcode_table[] naturally disallows those illegal
prefix sequences.

The 0x40 - 0x4F opcode row was missing the No64 flag. While NoRex2
already invalidates REX2 for these opcodes, adding No64 makes opcode
attributes explicit and complete.

Note opcodes marked NotImpl alone end up in handle_emulation_failure(),
but that will inject #UD eventually.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Link: https://lore.kernel.org/CABgObfYYGTvkYpeyqLSr9JgKMDA_STSff2hXBNchLZuKFU+MMA@mail.gmail.com
---
V8 -> V9: Clarify UD vs emul-failure in changelog and UD define (Jim Mattson)
---
 arch/x86/kvm/emulate.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c6e11f551438..3a587e553f9a 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3990,7 +3990,7 @@ static int check_perm_out(struct x86_emulate_ctxt *ctxt)
 		I2bv(((_f) | DstReg | SrcMem | ModRM) & ~Lock, _e),	\
 		I2bv(((_f) & ~Lock) | DstAcc | SrcImm, _e)
 
-static const struct opcode ud = I(SrcNone, emulate_ud);
+static const struct opcode ud = I(SrcNone | Undefined, emulate_ud);
 
 static const struct opcode group7_rm0[] = {
 	N,
@@ -4272,7 +4272,7 @@ static const struct opcode opcode_table[256] = {
 	/* 0x38 - 0x3F */
 	I6ALU(NoWrite, em_cmp), N, N,
 	/* 0x40 - 0x4F */
-	X8(I(DstReg | NoRex2, em_inc)), X8(I(DstReg | NoRex2, em_dec)),
+	X8(I(DstReg | NoRex2 | No64, em_inc)), X8(I(DstReg | NoRex2 | No64, em_dec)),
 	/* 0x50 - 0x57 */
 	X8(I(SrcReg | Stack, em_push)),
 	/* 0x58 - 0x5F */
@@ -4865,6 +4865,17 @@ static int x86_decode_avx(struct x86_emulate_ctxt *ctxt,
 	return rc;
 }
 
+static inline bool rex2_invalid(struct x86_emulate_ctxt *ctxt)
+{
+	const struct x86_emulate_ops *ops = ctxt->ops;
+	u64 xcr = 0;
+
+	return ctxt->rex_prefix == REX_PREFIX ||
+	       !(ops->get_cr(ctxt, 4) & X86_CR4_OSXSAVE) ||
+	       ops->get_xcr(ctxt, 0, &xcr) ||
+	       !(xcr & XFEATURE_MASK_APX);
+}
+
 int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int emulation_type)
 {
 	int rc = X86EMUL_CONTINUE;
@@ -4918,7 +4929,7 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 	ctxt->op_bytes = def_op_bytes;
 	ctxt->ad_bytes = def_ad_bytes;
 
-	/* Legacy prefixes. */
+	/* Legacy and REX/REX2 prefixes. */
 	for (;;) {
 		switch (ctxt->b = insn_fetch(u8, ctxt)) {
 		case 0x66:	/* operand-size override */
@@ -4964,6 +4975,17 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 			ctxt->rex_prefix = REX_PREFIX;
 			ctxt->rex_bits   = ctxt->b & 0xf;
 			continue;
+		case 0xd5: /* REX2 */
+			if (mode != X86EMUL_MODE_PROT64)
+				goto done_prefixes;
+			if (rex2_invalid(ctxt)) {
+				opcode = ud;
+				goto done_modrm;
+			}
+			ctxt->rex_prefix = REX2_PREFIX;
+			ctxt->rex_bits   = insn_fetch(u8, ctxt);
+			ctxt->b          = insn_fetch(u8, ctxt);
+			goto done_prefixes;
 		case 0xf0:	/* LOCK */
 			ctxt->lock_prefix = 1;
 			break;
@@ -4986,6 +5008,12 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 	if (ctxt->rex_bits & REX_W)
 		ctxt->op_bytes = 8;
 
+	/* REX2 opcode is one byte unless M-bit selects the two-byte map */
+	if (ctxt->rex_bits & REX_M)
+		goto decode_twobytes;
+	if (ctxt->rex_prefix == REX2_PREFIX)
+		goto decode_onebyte;
+
 	/* Opcode byte(s). */
 	if (ctxt->b == 0xc4 || ctxt->b == 0xc5) {
 		/* VEX or LDS/LES */
@@ -5003,17 +5031,19 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 			goto done;
 	} else if (ctxt->b == 0x0f) {
 		/* Two- or three-byte opcode */
-		ctxt->opcode_len = 2;
 		ctxt->b = insn_fetch(u8, ctxt);
+decode_twobytes:
+		ctxt->opcode_len = 2;
 		opcode = twobyte_table[ctxt->b];
 
 		/* 0F_38 opcode map */
-		if (ctxt->b == 0x38) {
+		if (ctxt->b == 0x38 && ctxt->rex_prefix != REX2_PREFIX) {
 			ctxt->opcode_len = 3;
 			ctxt->b = insn_fetch(u8, ctxt);
 			opcode = opcode_map_0f_38[ctxt->b];
 		}
 	} else {
+decode_onebyte:
 		/* Opcode byte(s). */
 		opcode = opcode_table[ctxt->b];
 	}
-- 
2.53.0

