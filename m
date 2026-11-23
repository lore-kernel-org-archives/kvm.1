Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457890;
	b=tZFbqxmFohhT9GYhuC1UhQEfECD2PPZjFQK5c7ALZG6jIfbpdDcCtfYcaEpxhaN1YWT5
	 S81UbqGL3ad0qwm9zxNXU9XRbKTGS1scJSb9rHwVOu3EnHkSs6klt5O4SVe6TD+BwCHxs
	 4sEZiDy/lYFBC8uvl8R0UvBaKruEM2oF7O/DPaSMpXUFDOJ93CrUpORMwJPiTvcbmUSxY
	 wxaWJ1lrzGIAWR4wTcv9vCCAVnUpuSFTYoMTTnIGuktDqBJ3LzsORj6Cq9GWpxz4PCn9k
	 AKVyl9hPhPrz/eIqOHANUmKmsomBN14JXkNQoCsg2Tub6UeQZp/qtUW6QpVgwGj34aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457890;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=q+Ejdqhi4vpr5f/s209hrjQaWCAdYUWEHYVgRC9xhLU=;
	b=HVv8ywU98pTqcRbYP0craAvVnb3LFc4xT+5xAwT1Nohf7DnPpueL+SewUkM51RTQRNe4
	 W2F1DbhQzak1CINa+BpTXkPG9+v/k/wj2fmIhr/HUn+Hk3PQejMFzVYJUrfIneBP3TOvh
	 Q/1DtbnwNe2G1/5AptW3J76/s/ZLS+sc/Dd6+NCVzCsInhDHOcBjB2vcRymDWFxS7Kks1
	 quLtlcQosJ+KAKQL/RH6tFR+4/Rjcxo45hQMvbONyKlFyoBXQcnZ981MRh+HPsnOMwd3M
	 E6Xu3m16sWgHB0vXoz1v9nwGK9z4+8MjirG7q+u+3E17mqdkqBfQiV7erTLpCNOh7WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VD5IoxIY;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900060A6F71;
	Mon, 23 Nov 2026 18:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1900060A6F71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VD5IoxIY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795457890; x=1826993890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kwI3GqUlWxS2wvBNysiSkrj6sohmeIKqG79Hvv1FIns=;
  b=VD5IoxIYobT486j3RzT0P76mLL5W9W6//yaUL3mF5ZXfRz4ocX2ieWPG
   kMNgRk1gPLa/ckctBDTprHFSRAkbdoeYqu4EGJaBAmOwFM9tmiEPDFMwA
   uGO2BM/Q+aCy4iGeEm/MNdy6XTkfDueieJjwA9w6ujjW0k55klnzduq5k
   cyb9pywiaQxbvbYMBGLUQQvhMcdClU4T/fyMYs9B+tnVQMWhbjeFEd84F
   koYs3v/XGlFy5VZABlTYHRwm/HijNIde5sx40EFvt1o4tOyZkSeKQri3s
   hT2PWJd0C8GnH4C8sTdxfjm7yHtFXe5LkoISi7lUwb12h8Pemqi2XIGQG
   A==;
X-CSE-ConnectionGUID: +TGFHeWVT2SHPBD7rY4UJQ==
X-CSE-MsgGUID: wII6bENQQgKYrhFPAzk3hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4288856"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4288856"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:05:26 -0800
X-CSE-ConnectionGUID: P+/E56N1SfOo4eAyAnj24Q==
X-CSE-MsgGUID: UQIEA5YoSuG38oCevIk8ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11241147"
Received: from chang-linux-3.sc.intel.com (HELO chang-linux-3) ([172.25.66.174])
  by orviesa004.jf.intel.com with ESMTP; 23 Nov 2026 10:05:26 -0800
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: seanjc@google.com,
	jmattson@google.com
Cc: pbonzini@redhat.com,
	kvm@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	zhao1.liu@intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH v10 13/20] KVM: x86: Support REX2-prefixed opcode decode
Date: Mon, 23 Nov 2026 17:37:25 +0000
Message-ID: <20261123173732.1072124-14-chang.seok.bae@intel.com>
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

Extend the instruction decoder to recognize and handle the REX2 prefix,
including validation of prefix sequences and correct opcode table
selection. Mark the UD opcode flag explicitly with Undefined, instead
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
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Link: https://lore.kernel.org/CABgObfYYGTvkYpeyqLSr9JgKMDA_STSff2hXBNchLZuKFU+MMA@mail.gmail.com
---
V9 -> V10: Collect a review tag
---
 arch/x86/kvm/emulate.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 2b649d15d5f5..3536bba2c035 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3996,7 +3996,7 @@ static int check_perm_out(struct x86_emulate_ctxt *ctxt)
 		I2bv(((_f) | DstReg | SrcMem | ModRM) & ~Lock, _e),	\
 		I2bv(((_f) & ~Lock) | DstAcc | SrcImm, _e)
 
-static const struct opcode ud = I(SrcNone, emulate_ud);
+static const struct opcode ud = I(SrcNone | Undefined, emulate_ud);
 
 static const struct opcode group7_rm0[] = {
 	N,
@@ -4278,7 +4278,7 @@ static const struct opcode opcode_table[256] = {
 	/* 0x38 - 0x3F */
 	I6ALU(NoWrite, em_cmp), N, N,
 	/* 0x40 - 0x4F */
-	X8(I(DstReg | NoRex2, em_inc)), X8(I(DstReg | NoRex2, em_dec)),
+	X8(I(DstReg | NoRex2 | No64, em_inc)), X8(I(DstReg | NoRex2 | No64, em_dec)),
 	/* 0x50 - 0x57 */
 	X8(I(SrcReg | Stack, em_push)),
 	/* 0x58 - 0x5F */
@@ -4871,6 +4871,17 @@ static int x86_decode_avx(struct x86_emulate_ctxt *ctxt,
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
@@ -4924,7 +4935,7 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 	ctxt->op_bytes = def_op_bytes;
 	ctxt->ad_bytes = def_ad_bytes;
 
-	/* Legacy prefixes. */
+	/* Legacy and REX/REX2 prefixes. */
 	for (;;) {
 		switch (ctxt->b = insn_fetch(u8, ctxt)) {
 		case 0x66:	/* operand-size override */
@@ -4970,6 +4981,17 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
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
@@ -4992,6 +5014,12 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
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
@@ -5009,17 +5037,19 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
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

