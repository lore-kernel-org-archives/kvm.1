Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3AD345745;
	Tue, 28 Apr 2026 05:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777353998; cv=none; b=g9ZSnVlXPZnpOnOvrfLqi5VDQpfTfzmJVb9rovxQ4fEOE1BCz49gD/AAf4Uuab6JqAeZeD7UdwKgCZN0lUis49Iy+4TAZksi/GF+kN1/ECC1V/PJv5S9JWYvC2d66eEs+IV1/9oOxtikOTcRNQfSiljNvRpP5KqkXXY7cZjVGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777353998; c=relaxed/simple;
	bh=VRsdO/FqgSJXlcFMefOZ8AWqWGRmIWKm4M/N6CCDlmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBf6S5AQsesoQFsT+4dM38TMsdHNFkp4VykVB5Ww3XnWLOUApAgefWWozcHhIC8TNzWKAL8wa1CBSBUchcnYm6cgyu2bPhUMwC7zjvd1D1CleWSr3+LODpf230LS3GejrXqPcdx87JSmqe0LRSQOytGA2jZtG30UMe5hoZBSCq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kx1jyE64; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kx1jyE64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777353996; x=1808889996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VRsdO/FqgSJXlcFMefOZ8AWqWGRmIWKm4M/N6CCDlmg=;
  b=Kx1jyE64qlk0i4e3qwhbz8Y+YjJWOPZKDz8hPef5hipaxLgTrEltzoNx
   BuyfX2SxSbCqzZBEU8Ugi6dGPlaOsLs4g61atC6HWnXEe2DiZBLFj4OPm
   n1QlxVJK16j+ktISA/8GvPoMiKsJa0rk+jO8KXQ6EMjwTTMJ6GOBfBPrH
   4EJByHtayr3i4UYcm139VAfhLk9Gg8Tuv7RbOlh9CDQAZxqf43AJrOqqi
   nr3Ef+dzSOXbTMN7ba1B8DqSYvjXul+SajDghh/70Qihh03D2iNNZpiEc
   MteIC0HrkFCmNb3ak0MZOvDKiHiyDFZnWxFf7MsiEAn4KjH3F5w1/L5Vr
   g==;
X-CSE-ConnectionGUID: KhaoAvQ4TM+5DqOEJGC7QQ==
X-CSE-MsgGUID: 0zFwUhD9S0awnFqzCygXwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78131732"
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="78131732"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 22:26:30 -0700
X-CSE-ConnectionGUID: gQonUJEiSgisRSsHvPmQfg==
X-CSE-MsgGUID: vJYQdjiRRy2n3y4tppU2ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,203,1770624000"; 
   d="scan'208";a="234130218"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.106])
  by orviesa007.jf.intel.com with ESMTP; 27 Apr 2026 22:26:30 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: pbonzini@redhat.com,
	seanjc@google.com
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chao.gao@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v3 14/20] KVM: x86: Support REX2-prefixed opcode decode
Date: Tue, 28 Apr 2026 05:01:05 +0000
Message-ID: <20260428050111.39323-15-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428050111.39323-1-chang.seok.bae@intel.com>
References: <20260428050111.39323-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: kvm@vger.kernel.org
List-Id: <kvm.vger.kernel.org>
List-Subscribe: <mailto:kvm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:kvm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Extend the instruction decoder to recognize and handle the REX2 prefix,
including validation of prefix sequences and correct opcode table
selection.

REX2 is a terminal prefix: once 0xD5 is encountered, the following byte
is the opcode. When REX.M=0, most prefix bytes are invalid after REX2,
including REX, VEX, EVEX, and another REX2. Also, REX2-prefixed
instructions are only valid in 64-bit mode.

All of the invalid prefix combinations after REX2 coincide with opcodes
that are architecturally invalid in 64-bit mode. Thus, marking such
opcodes with No64 in opcode_table[] naturally disallows those illegal
prefix sequences.

The 0x40–0x4F opcode row was missing the No64 flag. While NoRex2 already
invalidates REX2 for these opcodes, adding No64 makes opcode attributes
explicit and complete.

Link: https://lore.kernel.org/CABgObfYYGTvkYpeyqLSr9JgKMDA_STSff2hXBNchLZuKFU+MMA@mail.gmail.com
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
Note the posted unit-test patch [1] validates the decoding towards
emulations

[1] https://lore.kernel.org/20260420212355.507827-1-chang.seok.bae@intel.com
---
 arch/x86/kvm/emulate.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 0fef9416cb4d..efe8adca1317 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4268,7 +4268,7 @@ static const struct opcode opcode_table[256] = {
 	/* 0x38 - 0x3F */
 	I6ALU(NoWrite, em_cmp), N, N,
 	/* 0x40 - 0x4F */
-	X8(I(DstReg | NoRex2, em_inc)), X8(I(DstReg | NoRex2, em_dec)),
+	X8(I(DstReg | NoRex2 | No64, em_inc)), X8(I(DstReg | NoRex2 | No64, em_dec)),
 	/* 0x50 - 0x57 */
 	X8(I(SrcReg | Stack, em_push)),
 	/* 0x58 - 0x5F */
@@ -4862,6 +4862,17 @@ static int x86_decode_avx(struct x86_emulate_ctxt *ctxt,
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
@@ -4915,7 +4926,7 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 	ctxt->op_bytes = def_op_bytes;
 	ctxt->ad_bytes = def_ad_bytes;
 
-	/* Legacy prefixes. */
+	/* Legacy and REX/REX2 prefixes. */
 	for (;;) {
 		switch (ctxt->b = insn_fetch(u8, ctxt)) {
 		case 0x66:	/* operand-size override */
@@ -4961,6 +4972,17 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
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
@@ -4983,6 +5005,12 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 	if (ctxt->rex_bits & REX_W)
 		ctxt->op_bytes = 8;
 
+	/* REX2 opcode is one byte unless M-bit selects the two-byte map */
+	if (ctxt->rex_bits & REX_M)
+		goto decode_twobytes;
+	else if (ctxt->rex_prefix == REX2_PREFIX)
+		goto decode_onebyte;
+
 	/* Opcode byte(s). */
 	if (ctxt->b == 0xc4 || ctxt->b == 0xc5) {
 		/* VEX or LDS/LES */
@@ -5000,17 +5028,19 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
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
2.51.0

